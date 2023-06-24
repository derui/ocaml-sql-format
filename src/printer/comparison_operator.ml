open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext comparison_operator

module Make () : S = struct
  type t = ext comparison_operator

  let print f (`Comparison_operator (t, _)) ~option =
    let op =
      match t with
      | `eq -> Op_eq
      | `ne -> Op_ne
      | `ne2 -> Op_ne2
      | `gt -> Op_gt
      | `ge -> Op_ge
      | `lt -> Op_lt
      | `le -> Op_le
    in
    Printer_token.print f op ~option
end
