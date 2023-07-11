open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext datetime_value_expression

module Make
    (V : GEN with type t = ext datetime_term)
    (IVE : GEN with type t = ext interval_value_expression)
    (IT : GEN with type t = ext interval_term) : S = struct
  type t = ext datetime_value_expression

  let rec print f t ~option =
    match t with
    | Datetime_value_expression (`term v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Datetime_value_expression (`plus_interval (v, term), _) ->
      Sfmt.term_box
        (fun f _ ->
          let module IVE = (val IVE.generate ()) in
          IVE.print ~option f v;
          Fmt.sp f " ";
          Printer_token.print ~option f Op_plus;
          Fmt.sp f " ";
          let module V = (val V.generate ()) in
          V.print ~option f term)
        f ()
    | Datetime_value_expression (`plus_datetime (v, term), _) ->
      Sfmt.term_box
        (fun f _ ->
          print ~option f v;
          Fmt.sp f " ";
          Printer_token.print ~option f Op_plus;
          Fmt.sp f " ";
          let module IT = (val IT.generate ()) in
          IT.print ~option f term)
        f ()
    | Datetime_value_expression (`minus (v, term), _) ->
      Sfmt.term_box
        (fun f _ ->
          print ~option f v;
          Fmt.sp f " ";
          Printer_token.print ~option f Op_minus;
          Fmt.sp f " ";
          let module IT = (val IT.generate ()) in
          IT.print ~option f term)
        f ()
end
