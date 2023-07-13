open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext scope_clause

module Make (V : GEN with type t = ext table_name) : S = struct
  type t = ext scope_clause

  let print f t ~option =
    match t with
    | Scope_clause (e, _) ->
      Printer_token.print ~option f Kw_scope;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e
end
