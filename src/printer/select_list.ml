open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext select_list

module Make (Sub : GEN with type t = ext select_sublist) : S = struct
  type t = ext select_list

  let print f t ~option =
    match t with
    | Select_list (`asterisk, _) -> Printer_token.print ~option f Op_star
    | Select_list (`list (c, cl), _) ->
      let module Sub = (val Sub.generate ()) in
      Sub.print ~option f c;

      List.iter
        (fun c ->
          Printer_token.print ~option f Tok_comma;
          Sfmt.newline f ();
          Sub.print ~option f c)
        cl
end
