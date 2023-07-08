open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext ordinary_grouping_set_list

module Make (R : GEN with type t = ext ordinary_grouping_set) : S = struct
  type t = ext ordinary_grouping_set_list

  let print f t ~option =
    match t with
    | Ordinary_grouping_set_list (fl, rest, _) ->
      let module R = (val R.generate ()) in
      R.print f ~option fl;

      List.iter
        (fun r ->
          Printer_token.print ~option f Tok_comma;
          Fmt.cut f ();
          R.print f ~option r)
        rest
end
