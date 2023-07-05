open Types.Ast
open Intf

module type S = PRINTER with type t = ext qualified_asterisk

module Make
    (Chain : GEN with type t = ext asterisked_identifier_chain)
    (All : GEN with type t = ext all_fields_reference) : S = struct
  type t = ext qualified_asterisk

  let print f t ~option =
    match t with
    | Qualified_asterisk (`chain c, _) ->
      let module Chain = (val Chain.generate ()) in
      Chain.print ~option f c
    | Qualified_asterisk (`all a, _) ->
      let module All = (val All.generate ()) in
      All.print f a ~option
end
