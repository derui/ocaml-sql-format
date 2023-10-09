open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext insert_statement

module Make
    (V : GEN with type t = ext with_clause)
    (Q : GEN with type t = ext qualified_table_name)
    (E : GEN with type t = ext expr)
    (S : GEN with type t = ext select_statement)
    (R : GEN with type t = ext returning_clause)
    (C : GEN with type t = ext column_name) : S = struct
  type t = ext insert_statement

  let print_exprs ~option f t =
    let e = List.hd t
    and es = List.tl t in

    Sfmt.parens ~option
      (fun f _ ->
        let module E = (val E.generate ()) in
        E.print ~option f e;

        List.iter
          (fun e ->
            Sfmt.comma ~option f ();
            E.print ~option f e)
          es)
      f ()

  let print_stmt ~option f = function
    | `select v ->
      let module S = (val S.generate ()) in
      S.print ~option f v
    | `values values ->
      Sfmt.keyword ~option f [ Kw_values ];
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let v = List.hd values in
          let vs = List.tl values in

          print_exprs ~option f v;

          List.iter
            (fun v ->
              Sfmt.comma ~option f ();
              Fmt.cut f ();
              print_exprs ~option f v)
            vs)
        f ()

  let print f t ~option =
    match t with
    | Insert_statement (w, q, cols, stmt, returning, _) ->
      Option.iter
        (fun v ->
          let module V = (val V.generate ()) in
          V.print ~option f v;
          Fmt.cut f ())
        w;

      Sfmt.keyword ~option f [ Kw_insert; Kw_into ];
      Fmt.string f " ";
      let module Q = (val Q.generate ()) in
      Q.print ~option f q;
      Fmt.string f " ";

      Option.iter
        (fun v ->
          Sfmt.parens_box ~option
            (fun f _ ->
              let e = List.hd v
              and es = List.tl v in

              let module C = (val C.generate ()) in
              C.print ~option f e;

              List.iter
                (fun v ->
                  Sfmt.comma ~option f ();
                  Fmt.cut f ();
                  C.print ~option f v)
                es)
            f ())
        cols;

      Fmt.cut f ();
      print_stmt ~option f stmt;

      Option.iter
        (fun v ->
          Fmt.cut f ();
          let module R = (val R.generate ()) in
          R.print ~option f v)
        returning
end
