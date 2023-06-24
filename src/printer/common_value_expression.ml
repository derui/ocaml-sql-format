open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext common_value_expression

module Make (N : GEN with type t = ext numeric_value_expression) : S = struct
  type t = ext common_value_expression

  let print f t ~option =
    match t with
    | `Common_value_expression (exp, list, _) ->
      let module N = (val N.generate ()) in
      N.print f exp ~option;

      List.iter
        (fun (op, exp) ->
          (match op with
          | `amp -> Printer_token.print f Op_double_amp ~option
          | `concat -> Printer_token.print f Op_concat ~option);
          N.print f exp ~option)
        list
end
