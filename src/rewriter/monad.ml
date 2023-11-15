include (
  struct
    module R = Sql_syntax.Raw
    module K = Sql_syntax.Kind
    module T = Types.Token

    type error =
      { node : R.t
      ; layout_index : int
      ; message : string
      }

    type env =
      { resolver : K.node -> R.t t
      ; options : Options.t
      ; current_node : R.t
      ; layout_index : int
      ; current_indent : int
      }

    and 'a t = env -> ('a * env, error) result

    let bind : 'a t -> ('a -> 'b t) -> 'b t =
     fun v f data ->
      match v data with
      | Ok (v, env) -> f v env
      | Error _ as e -> e

    let return v env = Ok (v, env)

    let map f xp data =
      match xp data with
      | Ok (v, data) -> Ok (f v, data)
      | Error _ as e -> e

    let apply fp xp data =
      match fp data with
      | Ok (f, data) -> (map f xp) data
      | Error _ as e -> e

    module Syntax = struct
      let ( >>= ) = bind

      let ( <*> ) = apply
    end

    module Monad_syntax = struct
      let ( let* ) = bind
    end

    include Syntax
    include Monad_syntax

    let env () env = Ok (env, env)

    let fail message env = Error { node = env.current_node; layout_index = env.layout_index; message }

    let new_env env _ = Ok ((), env)

    let current_raw () =
      let* env = env () in
      match env.current_node with
      | R.Node { layouts; _ } -> return @@ List.nth (List.rev layouts) env.layout_index
      | _ -> fail "Leaf only syntax is invalid"

    let leaf k =
      let* env = env () in
      let* raw = current_raw () in
      match raw with
      | R.Leaf { kind; _ } when kind = k ->
        let* () = new_env { env with layout_index = succ env.layout_index } in
        return raw
      | _ -> fail @@ Printf.sprintf "Do not match required kind: %s" @@ K.show_leaf k

    let node k =
      let* env = env () in
      let* raw = current_raw () in
      match raw with
      | R.Node { kind; _ } when kind = k -> new_env { env with current_node = raw; layout_index = 0 }
      | _ -> fail @@ Printf.sprintf "Do not match required kind: %s" @@ K.show_node k

    let new_node layouts =
      let* env = env () in
      return @@ R.replace_layouts layouts env.current_node

    module Re = struct
      let keyword_case r =
        let* env = env () in
        match env.options.keyword_case with
        | `as_is -> return r
        | `upper ->
          return
          @@ R.replace
               (function
                 | T.Tok_keyword (v, kw) -> T.Tok_keyword (String.uppercase_ascii v, kw)
                 | _ as v -> v)
               r
        | `lower ->
          return
          @@ R.replace
               (function
                 | T.Tok_keyword (v, kw) -> T.Tok_keyword (String.lowercase_ascii v, kw)
                 | _ as v -> v)
               r

      let spacer ?(leading = 1) ?(trailing = 0) = function
        | R.Leaf _ as v ->
          let module Tr = Sql_syntax.Trivia in
          let leading old =
            Tr.to_tokens old |> (fun v -> List.append v @@ List.init leading @@ Fun.const T.Tok_space) |> Tr.leading
          in
          let trailing old =
            Tr.to_tokens old |> (fun v -> List.append v @@ List.init trailing @@ Fun.const T.Tok_space) |> Tr.trailing
          in
          R.replace_trivia ~leading ~trailing v |> return
        | _ as r -> return r

      let newline ?(count = 1) = function
        | R.Leaf _ as r ->
          assert (count >= 1);
          let module Tr = Sql_syntax.Trivia in
          let* env = env () in
          let current_indent = env.current_indent in
          let newlines =
            List.init count (fun _ -> List.init current_indent @@ Fun.const T.Tok_space |> List.cons T.Tok_newline)
            |> List.concat
          in
          r |> R.replace_trivia ~leading:(fun old -> List.concat [ Tr.to_tokens old; newlines ] |> Tr.leading) |> return
        | _ as r -> return r

      let indent_in size =
        assert (size >= 0);
        let* old_env = env () in
        let* () = new_env { old_env with current_indent = size } in
        return ()

      let indent_out size =
        assert (size >= 0);
        let* old_env = env () in
        let* () = new_env { old_env with current_indent = size } in
        return ()
    end

    module Runner = struct
      let run m ~resolver ~options r =
        let env = { resolver; options; current_node = r; current_indent = 0; layout_index = 0 } in
        match m env with
        | Ok (r, _) -> Ok r
        | Error e ->
          Error
            (Printf.sprintf "Error occurred: node = %s; layout = %d; message = %s" (R.to_string e.node) e.layout_index
               e.message)
    end
  end :
    Monad_intf.S)
