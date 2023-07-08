open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext collate_clause

module Make (Q : GEN with type t = ext collate_name) : S = struct
  type t = ext collate_clause

  let print f t ~option =
    match t with
    | Collate_clause (n, _) ->
      Printer_token.print ~option f Kw_collate;
      Fmt.string f " ";
      let module Q = (val Q.generate ()) in
      Q.print f ~option n
end
