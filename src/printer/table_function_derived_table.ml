open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_function_derived_table

module Make (CVE : GEN with type t = ext collection_value_expression) : S =
struct
  type t = ext table_function_derived_table

  let print f t ~option =
    match t with
    | Table_function_derived_table (e, _) ->
      Printer_token.print ~option f Kw_unnest;
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let module CVE = (val CVE.generate ()) in
          CVE.print ~option f e)
        f ()
end
