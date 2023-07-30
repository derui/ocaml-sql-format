open Types.Ast
open Intf

module type S = PRINTER with type t = ext join_clause

module Make
    (V : GEN with type t = ext table_or_subquery)
    (O : GEN with type t = ext join_operator)
    (C : GEN with type t = ext join_constraint) : S = struct
  type t = ext join_clause

  let print f t ~option =
    match t with
    | Join_clause (q, js, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f q;

      List.iter
        (fun (op, t, c) ->
          Fmt.cut f ();
          let module O = (val O.generate ()) in
          O.print ~option f op;

          Fmt.string f " ";

          V.print ~option f t;
          Option.iter
            (fun c ->
              Sfmt.force_vbox option.indent_size
                (fun f _ ->
                  let module C = (val C.generate ()) in
                  C.print ~option f c)
                f ())
            c)
        js
end
