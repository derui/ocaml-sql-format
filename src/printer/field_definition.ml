open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext field_definition

module Make
    (V : GEN with type t = ext identifier)
    (D : GEN with type t = ext data_type) : S = struct
  type t = ext field_definition

  let print f t ~option =
    match t with
    | Field_definition (name, d, _, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f name;
      Fmt.string f " ";
      let module D = (val D.generate ()) in
      D.print ~option f d
end
