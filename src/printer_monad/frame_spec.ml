open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext frame_spec

module Make
    (V : GEN with type t = ext frame_spec_core)
    (E : GEN with type t = ext frame_spec_excluding) : S = struct
  type t = ext frame_spec

  let print f t ~option =
    match t with
    | Frame_spec (kw, c, e, _) ->
      let kw =
        match kw with
        | `range -> Kw_range
        | `rows -> Kw_rows
        | `groups -> Kw_groups
      in
      Sfmt.keyword ~option f [ kw ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f c;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module E = (val E.generate ()) in
          E.print ~option f v)
        e
end
