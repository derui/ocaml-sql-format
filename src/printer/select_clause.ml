open Types.Ast
open Intf

module type S = PRINTER with type t = ext select_clause

module Make (SS : GEN with type t = ext select_sublist) : S = struct
  type t = ext select_clause

  let print f t ~option =
    match t with
    | `Select_clause (qualifier, select_list, _) -> (
      Printer_token.print f ~option Types.Token.Kw_select;
      Fmt.string f " ";

      Option.iter
        (fun v ->
          let kw =
            match v with
            | `All -> Types.Token.Kw_all
            | `Distinct -> Types.Token.Kw_distinct
          in
          Printer_token.print f ~option kw;
          Fmt.string f " ")
        qualifier;

      match select_list with
      | `asterisk -> Fmt.string f "*"
      | `select_list [ fst ] ->
        let module SS = (val SS.generate ()) in
        SS.print f ~option fst
      | `select_list (fst :: rest) ->
        let module SS = (val SS.generate ()) in
        SS.print f ~option fst;
        List.iter
          (fun v ->
            Printer_token.print f ~option Types.Token.Tok_comma;
            SS.print f ~option v)
          rest
      | `select_list [] -> assert false)
end
