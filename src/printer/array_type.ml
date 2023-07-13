open Types.Ast
open Types.Token
open Types.Literal
open Intf

module type S = PRINTER with type t = ext array_type

module Make
    (V : GEN with type t = ext data_type)
    (I : GEN with type t = ext unsigned_integer) : S = struct
  type t = ext array_type

  let print f t ~option =
    match t with
    | Array_type (e, i, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_array;

      Option.iter
        (fun i ->
          Printer_token.print ~option f Tok_lsbrace;
          let module I = (val I.generate ()) in
          I.print ~option f i;

          Printer_token.print ~option f Tok_rsbrace)
        i
end
