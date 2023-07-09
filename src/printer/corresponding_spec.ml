open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext corresponding_spec

module Make (V : GEN with type t = ext corresponding_column_list) : S = struct
  type t = ext corresponding_spec

  let print f t ~option =
    match t with
    | Corresponding_spec (v, _) ->
      Printer_token.print ~option f Kw_corresponding;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print ~option f Kw_by;
          Fmt.string f " ";
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f v)
            f ())
        v
end
