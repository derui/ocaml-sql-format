open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_primary

module Make
    (I : GEN with type t = ext identifier)
    (Subquery : GEN with type t = ext table_subquery)
    (JT : GEN with type t = ext joined_table) : S = struct
  type t = ext table_primary

  let print f t ~option =
    match t with
    | Table_primary (`table_name (ident, alias), _) ->
      let module I = (val I.generate ()) in
      I.print f ident ~option;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print f ~option Kw_as;
          Fmt.string f " ";
          I.print f v ~option)
        alias
    | Table_primary (`table_subquery s, _) ->
      let module Subquery = (val Subquery.generate ()) in
      Subquery.print f s ~option
    | Table_primary (`joined joined, _) ->
      Printer_token.print f Tok_lparen ~option;
      let module JT = (val JT.generate ()) in
      JT.print f joined ~option;
      Printer_token.print f Tok_rparen ~option
end
