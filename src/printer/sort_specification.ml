open Types.Ast
open Intf

module type S = PRINTER with type t = ext sort_specification

module Make
    (V : GEN with type t = ext sort_key)
    (O : GEN with type t = ext ordering_specification)
    (N : GEN with type t = ext null_ordering) : S = struct
  type t = ext sort_specification

  let print f t ~option =
    match t with
    | Sort_specification (key, order, null, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f key;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module O = (val O.generate ()) in
          O.print ~option f v)
        order;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module N = (val N.generate ()) in
          N.print ~option f v)
        null
end
