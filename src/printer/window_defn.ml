open Types.Ast
open Intf

module type S = PRINTER with type t = ext window_defn

module Make
    (V : GEN with type t = ext base_window_name)
    (P : GEN with type t = ext partition_clause)
    (O : GEN with type t = ext order_by_clause)
    (F : GEN with type t = ext frame_spec) : S = struct
  type t = ext window_defn

  let print f t ~option =
    match t with
    | Window_defn (n, p, o, s, _) ->
      Sfmt.parens_box ~option
        (fun f _ ->
          Option.iter
            (fun v ->
              let module V = (val V.generate ()) in
              V.print ~option f v)
            n;

          Option.iter
            (fun v ->
              Fmt.cut f ();
              let module P = (val P.generate ()) in
              P.print ~option f v)
            p;

          Option.iter
            (fun v ->
              Fmt.cut f ();
              let module O = (val O.generate ()) in
              O.print ~option f v)
            o;

          Option.iter
            (fun v ->
              Fmt.cut f ();
              let module F = (val F.generate ()) in
              F.print ~option f v)
            s)
        f ()
end
