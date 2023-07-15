open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext case_abbreviation

module Make (V : GEN with type t = ext value_expression) : S = struct
  type t = ext case_abbreviation

  let print f t ~option =
    match t with
    | Case_abbreviation (`nullif (first, s), _) ->
      Printer_token.print ~option f Kw_nullif;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f first;
          Sfmt.comma ~option f ();
          V.print ~option f s)
        f ()
    | Case_abbreviation (`coalesce (first, list), _) ->
      Printer_token.print ~option f Kw_coalesce;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f first;
          List.iter
            (fun v ->
              Sfmt.comma ~option f ();
              V.print ~option f v)
            list)
        f ()
end
