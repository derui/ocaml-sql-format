open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext concatenation

module Make
    (V : GEN with type t = ext character_value_expression)
    (C : GEN with type t = ext character_factor) : S = struct
  type t = ext concatenation

  let print f t ~option =
    match t with
    | Concatenation (e, c, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.sp f " ";
      Printer_token.print ~option f Op_concat;
      Fmt.sp f " ";
      let module C = (val C.generate ()) in
      C.print ~option f c
end
