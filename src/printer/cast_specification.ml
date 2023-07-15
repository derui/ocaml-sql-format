open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext cast_specification

module Make
    (V : GEN with type t = ext cast_operand)
    (T : GEN with type t = ext cast_target) : S = struct
  type t = ext cast_specification

  let print f t ~option =
    match t with
    | Cast_specification (operand, target, _) ->
      Printer_token.print ~option f Kw_cast;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f operand;
          Fmt.string f " ";
          Printer_token.print ~option f Kw_as;
          Fmt.string f " ";
          let module T = (val T.generate ()) in
          T.print ~option f target)
        f ()
end
