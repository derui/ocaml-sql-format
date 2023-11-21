(** support functions to rewrite *)

open Support_intf

include (
  struct
    module R = Sql_syntax.Raw
    module Tr = Sql_syntax.Trivia
    open Types.Token

    let map ~rewriter env r =
      let ret = ref [] in
      match r with
      | R.Leaf _ -> []
      | R.Node { layouts; _ } ->
        List.iter
          (fun r ->
            match rewriter env r with
            | None -> ret := r :: !ret
            | Some r -> ret := r :: !ret)
          layouts;
        !ret

    let when_leaf kind rewriter env = function
      | R.Leaf { kind = kind'; _ } as r when kind' = kind -> rewriter env r
      | _ -> None

    let should_be_node kind r =
      match r with
      | R.Node { kind = kind'; _ } -> assert (kind = kind') |> ignore
      | _ -> assert false |> ignore

    let space ?(leading = 0) ?(trailing = 0) _ = function
      | R.Leaf _ as r ->
        assert (leading >= 0 && trailing >= 0);

        R.replace_trivia
          ~leading:(fun tr ->
            if leading = 0 then tr
            else List.init leading (fun _ -> Tok_space) |> List.fold_left (fun tr tok -> Tr.push tok tr) tr)
          ~trailing:(fun tr ->
            if trailing = 0 then tr
            else List.init trailing (fun _ -> Tok_space) |> List.fold_left (fun tr tok -> Tr.push tok tr) tr)
          r
        |> Option.some
      | _ -> None

    let newline env = function
      | R.Leaf _ as r ->
        R.replace_trivia
          ~leading:(fun tr ->
            let indents = Tok_newline :: List.init env.Env.current_indent (fun _ -> Tok_space) in
            List.fold_left (fun tr tok -> Tr.push tok tr) tr indents)
          r
        |> Option.some
      | _ -> None

    let choice rewriters env raw =
      let rewriter =
        match raw with
        | R.Leaf { kind; _ } ->
          rewriters
          |> List.find_opt (function
               | `leaf k, _ -> k = kind
               | _ -> false)
          |> Option.map snd
        | R.Node { kind; _ } ->
          rewriters
          |> List.find_opt (function
               | `node k, _ -> k = kind
               | _ -> false)
          |> Option.map snd
      in
      Option.bind rewriter (fun rewriter -> rewriter env raw)
  end :
    S)
