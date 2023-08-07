open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext commit_statement

module Make () : S = struct
  type t = ext commit_statement

  let print f t ~option =
    match t with
    | Commit_statement (trans, _) ->
      let kw =
        match trans with
        | Some _ -> [ Kw_commit; Kw_transaction ]
        | None -> [ Kw_commit ]
      in
      Sfmt.keyword ~option f kw
end
