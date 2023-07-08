open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext window_specification_detail

module Make
    (I : GEN with type t = ext identifier)
    (P : GEN with type t = ext window_partition_clause)
    (O : GEN with type t = ext window_order_clause)
    (F : GEN with type t = ext window_frame_clause) : S = struct
  type t = ext window_specification_detail

  let print f t ~option =
    match t with
    | Window_specification_detail (i, p, o, frame, _) ->
      Option.iter
        (fun i ->
          let module I = (val I.generate ()) in
          I.print ~option f i)
        i;
      Option.iter
        (fun i ->
          Fmt.string f " ";
          let module P = (val P.generate ()) in
          P.print ~option f i)
        p;
      Option.iter
        (fun i ->
          Fmt.string f " ";
          let module O = (val O.generate ()) in
          O.print ~option f i)
        o;
      Option.iter
        (fun i ->
          Fmt.string f " ";
          let module F = (val F.generate ()) in
          F.print ~option f i)
        frame
end
