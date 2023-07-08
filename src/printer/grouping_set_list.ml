open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext grouping_set_list

module Make (G : GEN with type t = ext grouping_set) : S = struct
  type t = ext grouping_set_list

  let print f t ~option =
    match t with
    | Grouping_set_list (fl, rest, _) ->
      let module G = (val G.generate ()) in
      G.print f ~option fl;

      List.iter
        (fun r ->
          Printer_token.print ~option f Tok_comma;
          Fmt.cut f ();
          G.print f ~option r)
        rest
end
