open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext query_expression

module Make
    (P : GEN with type t = ext query_expression_body)
    (W : GEN with type t = ext with_list_element) : S = struct
  type t = ext query_expression

  let print f t ~option =
    match t with
    | Query_expression (with_list, e, ()) ->
      let module P = (val P.generate ()) in
      (match with_list with
      | [] -> ()
      | fst :: rest ->
        Printer_token.print f Kw_with ~option;
        Fmt.string f " ";
        let module W = (val W.generate ()) in
        W.print f fst ~option;
        List.iter
          (fun v ->
            Printer_token.print f Tok_comma ~option;
            W.print f v ~option)
          rest;
        Fmt.string f " ");
      P.print f e ~option
end
