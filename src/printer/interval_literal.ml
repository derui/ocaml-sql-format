open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = unit interval_literal

module Make (Q : GEN with type t = unit interval_qualifier) : S = struct
  type t = unit interval_literal

  let print f t ~option =
    match t with
    | Interval_literal (sign, s, q, _) ->
      Printer_token.print ~option f Kw_interval;
      Fmt.string f " ";
      Option.iter
        (function
          | `plus -> Printer_token.print ~option f Op_plus
          | `minus -> Printer_token.print ~option f Op_minus)
        sign;
      Fmt.string f s;
      Fmt.string f " ";
      let module Q = (val Q.generate ()) in
      Q.print ~option f q
end
