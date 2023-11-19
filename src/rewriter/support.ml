(** support functions to rewrite *)

open Support_intf

include (
  struct
    module R = Sql_syntax.Raw
    module Tr = Sql_syntax.Trivia
    open Types.Token

    let map ~rewriter env r =
      let ret = ref [] in

      R.walk
        ~f:(fun r ->
          match rewriter env r with
          | None -> ()
          | Some r -> ret := r :: !ret)
        r;

      !ret

    let when_leaf kind rewriter env = function
      | R.Leaf { kind = kind'; _ } as r when kind' = kind -> rewriter env r |> Option.some
      | _ -> None

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
  end :
    S)
