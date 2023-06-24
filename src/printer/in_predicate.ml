open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext in_predicate

module Make
    (Q : GEN with type t = ext subquery)
    (Cve : GEN with type t = ext common_value_expression) : S = struct
  type t = ext in_predicate

  let print f t ~option =
    match t with
    | In_predicate (`query q, not_op, _) ->
      Option.iter
        (fun _ ->
          Printer_token.print f Kw_not ~option;
          Fmt.string f " ")
        not_op;

      let module Q = (val Q.generate ()) in
      Printer_token.print f Kw_in ~option;
      Fmt.string f " ";
      Q.print f q ~option
    | In_predicate (`values l, not_op, _) ->
      (Option.iter
         (fun _ ->
           Printer_token.print f Kw_not ~option;
           Fmt.string f " ")
         not_op;

       let module Cve = (val Cve.generate ()) in
       Printer_token.print f Kw_in ~option;
       Fmt.string f " ";
       Printer_token.print f Tok_lparen ~option;

       match l with
       | [] -> failwith "need least one element"
       | [ hd ] -> Cve.print f hd ~option
       | hd :: tail ->
         Cve.print f hd ~option;
         List.iter
           (fun v ->
             Printer_token.print f Tok_comma ~option;
             Fmt.string f " ";
             Cve.print f v ~option)
           tail);
      Printer_token.print f Tok_rparen ~option
end
