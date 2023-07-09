open Types.Ast
open Types.Token
open Intf

module type S =
  PRINTER with type t = ext contextually_typed_table_value_constructor

module Make
    (V : GEN with type t = ext contextually_typed_row_value_expression_list) :
  S = struct
  type t = ext contextually_typed_table_value_constructor

  let print f t ~option =
    match t with
    | Contextually_typed_table_value_constructor (v, _) ->
      Printer_token.print ~option f Kw_values;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f v
end
