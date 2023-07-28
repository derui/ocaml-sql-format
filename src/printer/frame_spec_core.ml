open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext frame_spec_core

module Make
    (V : GEN with type t = ext expr)
    (B : GEN with type t = ext frame_spec_between) : S = struct
  type t = ext frame_spec_core

  let print f t ~option =
    match t with
    | Frame_spec_core (`unbounded, _) ->
      Sfmt.keyword ~option f [ Kw_unbounded; Kw_preceding ]
    | Frame_spec_core (`current_row, _) ->
      Sfmt.keyword ~option f [ Kw_current; Kw_row ]
    | Frame_spec_core (`preceding e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_preceding ]
    | Frame_spec_core (`between v, _) ->
      let module B = (val B.generate ()) in
      B.print ~option f v
end
