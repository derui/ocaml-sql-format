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
        Printer_token.print ~option f Kw_with;
        Fmt.string f " ";
        let module W = (val W.generate ()) in
        W.print ~option f fst;
        List.iter
          (fun v ->
            Format.pp_force_newline f ();
            if option.need_newline_with_element then
              Format.pp_force_newline f ();
            Sfmt.comma ~option f ();
            W.print ~option f v)
          rest;
        Format.pp_force_newline f ());
      P.print ~option f e
end
