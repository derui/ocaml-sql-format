open Types.Ast
open Types.Token
open Types.Literal
open Intf

module type S = PRINTER with type t = ext interval_value_expression

module Make
    (V : GEN with type t = ext interval_term)
    (E1 : GEN with type t = ext interval_value_expression_1)
    (T1 : GEN with type t = ext interval_term_1)
    (DE : GEN with type t = ext datetime_value_expression)
    (DT : GEN with type t = ext datetime_term)
    (IQ : GEN with type t = ext interval_qualifier) : S = struct
  type t = ext interval_value_expression

  let print f t ~option =
    match t with
    | Interval_value_expression (`term v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Interval_value_expression (`plus (e, v), _) ->
      Sfmt.term_box
        (fun f _ ->
          let module E1 = (val E1.generate ()) in
          E1.print ~option f e;
          Fmt.sp f ();
          Printer_token.print ~option f Op_plus;
          Fmt.sp f ();
          let module T1 = (val T1.generate ()) in
          T1.print ~option f v)
        f ()
    | Interval_value_expression (`minus (e, v), _) ->
      Sfmt.term_box
        (fun f _ ->
          let module E1 = (val E1.generate ()) in
          E1.print ~option f e;
          Fmt.sp f ();
          Printer_token.print ~option f Op_minus;
          Fmt.sp f ();
          let module T1 = (val T1.generate ()) in
          T1.print ~option f v)
        f ()
    | Interval_value_expression (`qualifier (e, v, iq), _) ->
      Sfmt.parens ~option
        (fun f _ ->
          let module DE = (val DE.generate ()) in
          DE.print ~option f e;
          Fmt.sp f ();
          Printer_token.print ~option f Op_minus;
          Fmt.sp f ();
          let module DT = (val DT.generate ()) in
          DT.print ~option f v)
        f ();
      Fmt.string f " ";
      let module IQ = (val IQ.generate ()) in
      IQ.print ~option f iq
end
