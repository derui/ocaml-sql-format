open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext frame_spec_between

module Make
    (V1 : GEN with type t = ext frame_spec_between_1)
    (V2 : GEN with type t = ext frame_spec_between_2) : S = struct
  type t = ext frame_spec_between

  let print f t ~option =
    match t with
    | Frame_spec_between (v1, v2, _) ->
      Sfmt.keyword ~option f [ Kw_between ];
      Fmt.string f " ";
      let module V1 = (val V1.generate ()) in
      V1.print ~option f v1;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_and ];
      Fmt.string f " ";
      let module V2 = (val V2.generate ()) in
      V2.print ~option f v2
end
