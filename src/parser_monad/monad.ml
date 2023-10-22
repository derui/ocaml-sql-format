include (
  struct
    module Token = Types.Token
    module S = Sql_syntax

    type raw = (Kind.node, Kind.leaf) S.Raw.t

    type pointer = int

    type syntax_stack_element = Kind.node * pointer

    module Syntax_memo = Map.Make (struct
      type t = Kind.node * pointer

      let compare (k, p) (k', p') =
        let k = Kind.compare_node k k' in
        if k = 0 then Stdlib.compare p p' else k
    end)

    (** Type of monad. *)
    type data =
      { pointer : pointer
      ; token_stream : Tokenizer.t array
      ; language : Monad_intf.language
      ; current : raw option
      ; syntax_stack : syntax_stack_element list
      ; syntax_memo : raw Syntax_memo.t
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

    let many m =
      let open Let_syntax in
      let p = map (fun v -> [ v ]) m in
      let rec many' accum =
        let* v = choice p (return []) in
        match v with
        | [] -> List.rev accum |> return
        | v :: _ -> many' (v :: accum)
      in
      choice (many' []) (return [])

    let many1 m =
      let open Let_syntax in
      let* v = m in
      let* vs = many m in
      return (v :: vs)

    module Syntax = struct
      let ( >>= ) = bind

      let ( <$> ) = map

      let ( <*> ) = apply

      let ( <|> ) = choice

      let ( *> ) x y = (fun _ y -> y) <$> x <*> y
    end

    let put_current c size =
      edit_data (fun data ->
          { data with
            current = Some c
          ; pointer =
              min (data.pointer + size) (pred @@ Array.length data.token_stream)
          })

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
            trailing' (d.pointer + S.Trivia.length leading) []
            |> S.Trivia.trailing
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

    let put_current () =
      let open Let_syntax in
      let* raw = current in
      let* data = data () in
      match data.syntax_stack with
      | (k, p) :: _ ->
        fun data ->
          Ok
            ( ()
            , { data with
                current = None
              ; syntax_memo =
                  Syntax_memo.update (k, p)
                    (fun v ->
                      Option.get v |> S.Raw.push_layout raw |> Option.some)
                    data.syntax_memo
              } )
      | [] ->
        fun data ->
          Ok
            ( ()
            , { data with
                language = S.Language.append raw data.language
              ; current = None
              } )

    let push_syntax (kind : Kind.node) (raw : raw) =
      let open Let_syntax in
      let* data = data () in

      if Syntax_memo.mem (kind, data.pointer) data.syntax_memo then
        fail "Detect infinite recursion"
      else
        let key = (kind, data.pointer) in
        edit_data (fun data ->
            { data with
              syntax_stack = key :: data.syntax_stack
            ; syntax_memo = Syntax_memo.add key raw data.syntax_memo
            })

    let pop_syntax () =
      let open Let_syntax in
      let* data = data () in
      match data.syntax_stack with
      | key :: rest ->
        let syntax = Syntax_memo.find key data.syntax_memo in
        fun data ->
          Ok
            ( syntax
            , { data with
                syntax_stack = rest
              ; syntax_memo = Syntax_memo.remove key data.syntax_memo
              } )
      | [] -> fail "Invalid stack management"

    let bump : unit t =
      let open Let_syntax in
      let* () = put_current () in
      edit_data (fun data -> { data with current = None })

    let bump_when tok =
      let open Let_syntax in
      let* raw = current in
      if S.Raw.match' (Token.equal tok) raw then bump
      else
        fail @@ Printf.sprintf "Does not match token for %s" @@ Token.show tok

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
      let* () = push_syntax kind syntax in
      let* _ = m in
      let* syntax = pop_syntax () in
      edit_data (fun data ->
          match data.syntax_stack with
          | key :: _ ->
            { data with
              syntax_memo =
                Syntax_memo.update key
                  (fun v ->
                    Option.get v |> S.Raw.push_layout syntax |> Option.some)
                  data.syntax_memo
            }
          | [] ->
            { data with
              language = S.Language.append syntax data.language
            ; syntax_stack = []
            ; syntax_memo = Syntax_memo.empty
            })

    let parse tokens monad =
      let data =
        { pointer = 0
        ; token_stream = tokens
        ; language = S.Language.empty ()
        ; current = None
        ; syntax_stack = []
        ; syntax_memo = Syntax_memo.empty
        }
      in
      match monad data with
      | Ok (_, data) -> Ok data.language
      | Error e -> Error e
  end :
    Monad_intf.S)
