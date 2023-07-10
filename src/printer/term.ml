open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext term

module Make (V : GEN with type t = ext factor) : S = struct
  type t = ext term

  let print f t ~option =
    match t with
    | Term (`single v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Term (`asterisk (v1, v2), _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v1;
      Fmt.sp f ();
      Printer_token.print ~option f Op_star;
      Fmt.sp f ();
      V.print ~option f v2
    | Term (`solidus (v1, v2), _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v1;
      Fmt.sp f ();
      Printer_token.print ~option f Op_slash;
      Fmt.sp f ();
      V.print ~option f v2
end
