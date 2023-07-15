open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext sort_specification_list

module Make (V : GEN with type t = ext sort_specification) : S = struct
  type t = ext sort_specification_list

  let print f t ~option =
    match t with
    | Sort_specification_list (fl, list, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f fl;

      List.iter
        (fun v ->
          Printer_token.print ~option f Tok_comma;
          Fmt.sp f ();
          V.print ~option f v)
        list
end
