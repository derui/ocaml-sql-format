open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_condition

module Make (S : GEN with type t = ext search_condition) : S = struct
  type t = ext join_condition

  let print f t ~option =
    match t with
    | Join_condition (s, _) ->
      Printer_token.print ~option f Kw_on;
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let module S = (val S.generate ()) in
          S.print ~option f s)
        f ()
end
