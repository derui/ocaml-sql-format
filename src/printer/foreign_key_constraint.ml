open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext foreign_key_constraint

module Make
    (V : GEN with type t = ext qualified_table_name)
    (C : GEN with type t = ext column_name) : S = struct
  type t = ext foreign_key_constraint

  let print f t ~option =
    match t with
    | Foreign_key_constraint (n, cs, _) ->
      Sfmt.keyword ~option f [ Kw_references ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f n;

      Option.iter
        (fun v ->
          let c = List.hd v
          and cs = List.tl v in

          Fmt.string f " ";

          Sfmt.parens ~option
            (fun f _ ->
              let module C = (val C.generate ()) in
              C.print ~option f c;

              List.iter
                (fun c ->
                  Sfmt.comma ~option f ();
                  C.print ~option f c)
                cs)
            f ())
        cs
end
