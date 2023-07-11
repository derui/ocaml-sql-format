open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext interval_absolute_value_function

module Make (V : GEN with type t = ext interval_value_expression) : S = struct
  type t = ext interval_absolute_value_function

  let print f t ~option =
    match t with
    | Interval_absolute_value_function (e, _) ->
      Printer_token.print ~option f Kw_abs;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ()
end
