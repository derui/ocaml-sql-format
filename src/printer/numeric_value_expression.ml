open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext numeric_value_expression

module Make (Term : GEN with type t = ext term) : S = struct
  type t = ext numeric_value_expression

  let print f t ~option =
    match t with
    | Numeric_value_expression (term, terms, _) ->
      let pf f _ =
        let module Term = (val Term.generate ()) in
        Term.print f term ~option;

        List.iter
          (fun (op, term) ->
            let kw =
              match op with
              | `plus -> Op_plus
              | `minus -> Op_minus
            in
            Fmt.sp f ();
            Printer_token.print ~option f kw;
            Fmt.string f " ";
            Term.print f term ~option)
          terms
      in
      Sfmt.term_box pf f ()
end
