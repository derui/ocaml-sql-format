open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext approximate_numeric_type

module Make (V : GEN with type t = ext precision) : S = struct
  type t = ext approximate_numeric_type

  let print f t ~option =
    match t with
    | Approximate_numeric_type (`float v, _) ->
      Printer_token.print ~option f Kw_float;
      Option.iter
        (fun v ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f v)
            f ())
        v
    | Approximate_numeric_type (`real, _) ->
      Printer_token.print ~option f Kw_real
    | Approximate_numeric_type (`double, _) ->
      Printer_token.print ~option f Kw_double;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_precision
end
