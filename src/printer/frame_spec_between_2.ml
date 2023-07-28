open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext frame_spec_between_2

module Make (V : GEN with type t = ext expr) : S = struct
  type t = ext frame_spec_between_2

  let print f t ~option =
    match t with
    | Frame_spec_between_2 (`unbounded, _) ->
      Sfmt.keyword ~option f [ Kw_unbounded; Kw_following ]
    | Frame_spec_between_2 (`preceding expr, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f expr;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_preceding ]
    | Frame_spec_between_2 (`following expr, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f expr;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_following ]
    | Frame_spec_between_2 (`current_row, _) ->
      Sfmt.keyword ~option f [ Kw_current; Kw_row ]
end
