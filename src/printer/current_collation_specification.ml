open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext current_collation_specification

module Make (V : GEN with type t = ext string_value_expression) : S = struct
  type t = ext current_collation_specification

  let print f t ~option =
    match t with
    | Current_collation_specification (e, _) ->
      Sfmt.keyword ~option f [ Kw_current; Kw_collation ];
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ()
end
