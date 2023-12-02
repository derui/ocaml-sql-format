(** support functions to rewrite *)

open Support_intf

include (
  struct
    module R = Sql_syntax.Raw
    module Tr = Sql_syntax.Trivia

    module Syntax = struct
      let ( >>= ) = Option.bind
    end

    let map ~rewriter r =
      let ret = ref [] in
      match r with
      | R.Leaf _ -> []
      | R.Node { layouts; _ } ->
        List.iter
          (fun r ->
            match rewriter r with
            | None -> ret := r :: !ret
            | Some r -> ret := r :: !ret)
          layouts;
        !ret

    let when_leaf kind rewriter = function
      | R.Leaf { kind = kind'; _ } as r when kind' = kind -> rewriter r
      | _ -> None

    let should_be_node kind r =
      match r with
      | R.Node { kind = kind'; _ } -> assert (kind = kind') |> ignore
      | _ -> assert false |> ignore

    let space ?(leading = 0) ?(trailing = 0) = function
      | R.Leaf _ as r ->
        assert (leading >= 0 && trailing >= 0);

        R.replace_trivia
          ~leading:(fun tr -> if leading = 0 then tr else Tr.unshift (Tr.Tr_space leading) tr)
          ~trailing:(fun tr -> if trailing = 0 then tr else Tr.push (Tr.Tr_space trailing) tr)
          r
        |> Option.some
      | _ -> None

    let shrink = function
      | R.Leaf _ as r -> R.replace_trivia ~leading:Tr.shrink ~trailing:Tr.shrink r |> Option.some
      | _ -> None

    let choice rewriters raw =
      let rewriter =
        match raw with
        | R.Leaf { kind; _ } ->
          rewriters
          |> List.find_opt (function
               | `leaf k, _ -> k = kind
               | `any, _ -> true
               | _ -> false)
          |> Option.map snd
        | R.Node { kind; _ } ->
          rewriters
          |> List.find_opt (function
               | `node k, _ -> k = kind
               | `any, _ -> true
               | _ -> false)
          |> Option.map snd
      in
      Option.bind rewriter (fun rewriter -> rewriter raw)
  end :
    S)
