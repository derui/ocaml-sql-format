open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_constraint

module Make
    (I : GEN with type t = ext identifier)
    (E : GEN with type t = ext expr)
    (C : GEN with type t = ext column_name)
    (FK : GEN with type t = ext foreign_key_clause) : S = struct
  type t = ext table_constraint

  let print f t ~option =
    match t with
    | Table_constraint (n, `primary_key cs, _) ->
      let module I = (val I.generate ()) in
      Option.iter
        (fun v ->
          Sfmt.keyword ~option f [ Kw_constraint ];
          Fmt.string f " ";
          I.print ~option f v)
        n;

      Sfmt.keyword ~option f [ Kw_primary; Kw_key ];
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let c = List.hd cs
          and cs = List.tl cs in
          I.print ~option f c;

          List.iter
            (fun c ->
              Sfmt.comma ~option f ();
              I.print ~option f c)
            cs)
        f ()
    | Table_constraint (n, `unique cs, _) ->
      let module I = (val I.generate ()) in
      Option.iter
        (fun v ->
          Sfmt.keyword ~option f [ Kw_constraint ];
          Fmt.string f " ";
          I.print ~option f v)
        n;

      Sfmt.keyword ~option f [ Kw_unique ];
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let c = List.hd cs
          and cs = List.tl cs in
          I.print ~option f c;

          List.iter
            (fun c ->
              Sfmt.comma ~option f ();
              I.print ~option f c)
            cs)
        f ()
    | Table_constraint (n, `check e, _) ->
      let module I = (val I.generate ()) in
      Option.iter
        (fun v ->
          Sfmt.keyword ~option f [ Kw_constraint ];
          Fmt.string f " ";
          I.print ~option f v)
        n;

      Sfmt.keyword ~option f [ Kw_check ];
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let module E = (val E.generate ()) in
          E.print ~option f e)
        f ()
    | Table_constraint (n, `foreign (cs, fk), _) ->
      Option.iter
        (fun v ->
          Sfmt.keyword ~option f [ Kw_constraint ];
          Fmt.string f " ";
          let module I = (val I.generate ()) in
          I.print ~option f v)
        n;

      let module C = (val C.generate ()) in
      Sfmt.keyword ~option f [ Kw_foreign; Kw_key ];
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let c = List.hd cs
          and cs = List.tl cs in
          C.print ~option f c;

          List.iter
            (fun c ->
              Sfmt.comma ~option f ();
              C.print ~option f c)
            cs)
        f ();

      Fmt.string f " ";
      let module FK = (val FK.generate ()) in
      FK.print ~option f fk
end
