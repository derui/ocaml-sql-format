open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext interval_term

module Make
    (V : GEN with type t = ext interval_factor)
    (F : GEN with type t = ext factor)
    (T : GEN with type t = ext term)
    (T2 : GEN with type t = ext interval_term_2) : S = struct
  type t = ext interval_term

  let print f t ~option =
    match t with
    | Interval_term (`factor v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Interval_term (`asterisk (v, factor), _) ->
      let module T2 = (val T2.generate ()) in
      T2.print ~option f v;

      Fmt.string f " ";
      Printer_token.print ~option f Op_star;
      Fmt.string f " ";
      let module F = (val F.generate ()) in
      F.print ~option f factor
    | Interval_term (`solidus (v, factor), _) ->
      let module T2 = (val T2.generate ()) in
      T2.print ~option f v;

      Fmt.string f " ";
      Printer_token.print ~option f Op_slash;
      Fmt.string f " ";
      let module F = (val F.generate ()) in
      F.print ~option f factor
    | Interval_term (`term (term, factor), _) ->
      let module T = (val T.generate ()) in
      T.print ~option f term;

      Fmt.string f " ";
      Printer_token.print ~option f Op_star;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f factor
end
