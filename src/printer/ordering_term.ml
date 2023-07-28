open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext ordering_term

module Make
    (V : GEN with type t = ext expr)
    (C : GEN with type t = ext collation_name) : S = struct
  type t = ext ordering_term

  let print f t ~option =
    match t with
    | Ordering_term (e, c, o, n, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module C = (val C.generate ()) in
          C.print ~option f v)
        c;

      Option.iter
        (fun v ->
          let kw =
            match v with
            | `asc -> Kw_asc
            | `desc -> Kw_desc
          in
          Fmt.string f " ";
          Sfmt.keyword ~option f [ kw ])
        o;

      Option.iter
        (fun v ->
          let kw =
            match v with
            | `first -> [ Kw_null; Kw_first ]
            | `last -> [ Kw_null; Kw_last ]
          in
          Fmt.string f " ";
          Sfmt.keyword ~option f kw)
        n
end
