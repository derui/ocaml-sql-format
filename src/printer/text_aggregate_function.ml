open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext text_aggregate_function

module Make
    (Expr : GEN with type t = ext expression)
    (I : GEN with type t = ext identifier)
    (C : GEN with type t = ext character)
    (Order : GEN with type t = ext order_by_clause)
    (Derived : GEN with type t = ext derived_column) : S = struct
  type t = ext text_aggregate_function

  let print f t ~option =
    match t with
    | Text_aggregate_function (columns, delim, quote, encoding, order_by, _) ->
      Printer_token.print f Kw_textagg ~option;
      Fmt.string f " ";
      Printer_token.print f Tok_lparen ~option;
      Printer_token.print f Kw_for ~option;
      Fmt.string f " ";
      let module Derived = (val Derived.generate ()) in
      (match columns with
      | [] -> failwith "invalid syntax"
      | column :: rest ->
        Derived.print f column ~option;

        List.iter
          (fun v ->
            Printer_token.print f Tok_comma ~option;
            Fmt.string f " ";
            Derived.print f v ~option)
          rest);

      Option.iter
        (fun delim ->
          Fmt.string f " ";
          Printer_token.print f Kw_delimiter ~option;
          Fmt.string f " ";
          let module C = (val C.generate ()) in
          C.print f delim ~option)
        delim;
      Option.iter
        (fun quote ->
          Fmt.string f " ";
          match quote with
          | `quote c ->
            Printer_token.print f Kw_quote ~option;
            Fmt.string f " ";
            let module C = (val C.generate ()) in
            C.print f c ~option
          | `no_quote ->
            Printer_token.print f Kw_no ~option;
            Fmt.string f " ";
            Printer_token.print f Kw_quote ~option)
        quote;
      Option.iter
        (fun encoding ->
          Fmt.string f " ";
          Printer_token.print f Kw_encoding ~option;
          Fmt.string f " ";
          let module I = (val I.generate ()) in
          I.print f encoding ~option)
        encoding;
      Option.iter
        (fun order_by ->
          Fmt.string f " ";
          let module Order = (val Order.generate ()) in
          Order.print f order_by ~option)
        order_by;

      Printer_token.print f Tok_rparen ~option
end
