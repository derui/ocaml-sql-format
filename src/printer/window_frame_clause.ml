open Types.Ast
open Intf

module type S = PRINTER with type t = ext window_frame_clause

module Make
    (U : GEN with type t = ext window_frame_units)
    (Extent : GEN with type t = ext window_frame_extent)
    (Exclusion : GEN with type t = ext window_frame_exclusion) : S = struct
  type t = ext window_frame_clause

  let print f t ~option =
    match t with
    | Window_frame_clause (u, extent, exclusion, _) ->
      let module U = (val U.generate ()) in
      U.print ~option f u;
      Fmt.string f " ";
      let module Extent = (val Extent.generate ()) in
      Extent.print ~option f extent;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module Exclusion = (val Exclusion.generate ()) in
          Exclusion.print ~option f v)
        exclusion
end
