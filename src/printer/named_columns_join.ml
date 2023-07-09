open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext named_columns_join

module Make (C : GEN with type t = ext join_column_list) : S = struct
  type t = ext named_columns_join

  let print f t ~option =
    match t with
    | Named_columns_join (c, _) ->
      Printer_token.print ~option f Kw_using;
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let module C = (val C.generate ()) in
          C.print ~option f c)
        f ()
end
