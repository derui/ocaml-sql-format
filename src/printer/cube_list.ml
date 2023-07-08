open Types.Ast
open Intf

module type S = PRINTER with type t = ext cube_list

module Make (L : GEN with type t = ext ordinary_grouping_set_list) : S = struct
  type t = ext cube_list

  let print f t ~option =
    match t with
    | Cube_list (l, _) ->
      Printer_token.print f ~option Types.Token.Kw_cube;
      Fmt.string f " ";

      let module L = (val L.generate ()) in
      L.print f ~option l
end
