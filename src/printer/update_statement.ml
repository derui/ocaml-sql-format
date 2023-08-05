open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext update_statement

module Make
    (V : GEN with type t = ext column_name)
    (Q : GEN with type t = ext qualified_table_name)
    (E : GEN with type t = ext expr)
    (From : GEN with type t = ext from_clause)
    (Where : GEN with type t = ext where_clause)
    (Returning : GEN with type t = ext returning_clause) : S = struct
  type t = ext update_statement

  let print_opt ~option f = function
    | `abort -> Sfmt.keyword ~option f [ Kw_or; Kw_abort ]
    | `fail -> Sfmt.keyword ~option f [ Kw_or; Kw_fail ]
    | `ignore -> Sfmt.keyword ~option f [ Kw_or; Kw_ignore ]
    | `replace -> Sfmt.keyword ~option f [ Kw_or; Kw_replace ]
    | `rollback -> Sfmt.keyword ~option f [ Kw_or; Kw_rollback ]

  let print_col ~option f = function
    | `column (c, e) ->
      let module V = (val V.generate ()) in
      V.print ~option f c;
      Fmt.string f " ";
      Token.print ~option f Op_eq;
      Fmt.string f " ";
      let module E = (val E.generate ()) in
      E.print ~option f e
    | `list (cl, e) ->
      let module V = (val V.generate ()) in
      let c = List.hd cl
      and cs = List.tl cl in

      Sfmt.parens ~option
        (fun f _ ->
          V.print ~option f c;

          List.iter
            (fun c ->
              Sfmt.comma ~option f ();
              V.print ~option f c)
            cs)
        f ();

      Fmt.string f " ";
      Token.print ~option f Op_eq;
      Fmt.string f " ";
      let module E = (val E.generate ()) in
      E.print ~option f e

  let print f t ~option =
    match t with
    | Update_statement (opt, qname, cols, from, where, returning, _) ->
      Sfmt.keyword ~option f [ Kw_update ];
      Fmt.string f " ";

      Option.iter
        (fun opt ->
          print_opt ~option f opt;
          Fmt.string f " ")
        opt;

      let module Q = (val Q.generate ()) in
      Q.print ~option f qname;
      Fmt.cut f ();
      Sfmt.keyword ~option f [ Kw_set ];
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let c = List.hd cols
          and cs = List.tl cols in

          print_col ~option f c;

          List.iter
            (fun c ->
              Sfmt.comma ~option f ();
              Fmt.cut f ();
              print_col ~option f c)
            cs)
        f ();

      Option.iter
        (fun v ->
          let module From = (val From.generate ()) in
          From.print ~option f v)
        from;

      Option.iter
        (fun v ->
          let module Where = (val Where.generate ()) in
          Where.print ~option f v)
        where;

      Option.iter
        (fun v ->
          let module Returning = (val Returning.generate ()) in
          Returning.print ~option f v)
        returning
end
