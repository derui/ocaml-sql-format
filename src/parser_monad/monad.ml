include (
  struct
    module Token = Types.Token
    module S = Sql_syntax

    type raw = (Kind.node, Kind.leaf) S.Raw.t

    (** Type of monad. *)
    type data =
      { pointer : int
      ; token_stream : Tokenizer.t array
      ; language : Monad_intf.language
      ; current : raw option
      ; syntax_stack : raw list
      }

    type 'a t = data -> ('a * data, Parse_error.t) result

    (* basic monad/applicable operations *)
    let map : ('a -> 'b) -> 'a t -> 'b t =
     fun f v data ->
      match v data with
      | Ok (v, data) -> Ok (f v, data)
      | Error _ as e -> e

    let apply fp xp data =
      match fp data with
      | Ok (f, data) -> (map f xp) data
      | Error _ as e -> e

    let bind : 'a t -> ('a -> 'b t) -> 'b t =
     fun v f data ->
      match v data with
      | Ok (v, data) -> f v data
      | Error _ as e -> e

    let return v p = Ok (v, p)

    module Let_syntax = struct
      let ( let* ) = bind
    end

    let data () data = Ok (data, data)

    let edit_data f data = Ok ((), f data)

    let fail v =
      let open Let_syntax in
      let* data' = data () in
      let { start_pos; end_pos; token = _ } : Tokenizer.t =
        data'.token_stream.(data'.pointer)
      in
      fun _ -> Error { Parse_error.start_pos; end_pos; message = v }

    let skip = return ()

    let choice : 'a t -> 'a t -> 'a t =
     fun x y data ->
      let x' = x data in
      match x' with
      | Ok v -> Ok v
      | Error _ -> (
        let y' = y data in
        match y' with
        | Ok v -> Ok v
        | Error _ -> fail "Can not get any result" data)

    module Syntax = struct
      let ( >>= ) = bind

      let ( <$> ) = map

      let ( <*> ) = apply

      let ( <|> ) = choice
    end

    let put_current c size data =
      Ok ((), { data with current = Some c; pointer = data.pointer + size })

    let array_get_opt ary idx =
      if Array.length ary <= idx then None else Some ary.(idx)

    let current =
      let open Let_syntax in
      let* d = data () in

      match d.current with
      | Some c -> return c
      | None -> (
        let leading =
          let rec leading' pointer buf =
            match array_get_opt d.token_stream pointer with
            | Some c when S.Trivia.can_leading c.token ->
              leading' (succ pointer) (c.token :: buf)
            | _ -> List.rev buf
          in
          leading' d.pointer [] |> S.Trivia.leading
        in
        let c =
          array_get_opt d.token_stream (d.pointer + S.Trivia.length leading)
        in
        match c with
        | None -> fail "No any token"
        | Some c ->
          let trailing =
            let rec trailing' pointer buf =
              match array_get_opt d.token_stream pointer with
              | Some c when S.Trivia.can_trailing c.token ->
                trailing' (succ pointer) (c.token :: buf)
              | _ -> List.rev buf
            in
            trailing' d.pointer [] |> S.Trivia.trailing
          in
          let leaf =
            S.Raw.make_leaf
              (Kind.token_to_leaf c.token)
              ~trailing ~leading ~token:c.token
          in
          let* () =
            put_current leaf
              (S.Trivia.length leading + S.Trivia.length trailing + 1)
          in
          return leaf)

    let put_syntax raw =
      let open Let_syntax in
      let* data = data () in
      match data.syntax_stack with
      | syntax :: rest ->
        fun data ->
          Ok
            ( ()
            , { data with syntax_stack = S.Raw.push_layout raw syntax :: rest }
            )
      | [] ->
        fun data ->
          Ok ((), { data with language = S.Language.append raw data.language })

    let bump : unit t =
      let open Let_syntax in
      let* c = current in
      let* () = put_syntax c in
      fun data -> Ok ((), { data with current = None })

    let bump_when tok =
      let open Let_syntax in
      let* raw = current in
      if S.Raw.match' (Token.equal tok) raw then bump
      else fail "Does not match token"

    let bump_match f =
      let open Let_syntax in
      let* raw = current in
      if S.Raw.match' f raw then bump else fail "Does not match token"

    let bump_kw kw =
      let open Let_syntax in
      let* raw = current in
      let match_kw = function
        | Token.Tok_keyword (_, kw') -> Types.Keyword.equal kw' kw
        | _ -> false
      in
      if S.Raw.match' match_kw raw then bump else fail "Does not match token"

    let start_syntax : Kind.node -> 'a t -> unit t =
     fun kind m ->
      let open Let_syntax in
      let syntax = S.Raw.make_node kind ~layouts:[] in
      let* () =
       fun data ->
        Ok ((), { data with syntax_stack = syntax :: data.syntax_stack })
      in
      let* _ = m in
      edit_data (fun data ->
          match data.syntax_stack with
          | s :: rest ->
            { data with
              language = S.Language.append s data.language
            ; syntax_stack = rest
            }
          | [] -> failwith "Invalid syntax stack")

    let parse tokens monad =
      let data =
        { pointer = 0
        ; token_stream = tokens
        ; language = S.Language.empty ()
        ; current = None
        ; syntax_stack = []
        }
      in
      match monad data with
      | Ok (_, data) -> Ok data.language
      | Error e -> Error e
  end :
    Monad_intf.S)
