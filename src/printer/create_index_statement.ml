open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext create_index_statement

module Make
    (V : GEN with type t = ext qualified_table_name)
    (T : GEN with type t = ext table_name)
    (I : GEN with type t = ext identifier)
    (Expr : GEN with type t = ext expr) : S = struct
  type t = ext create_index_statement

  let print f t ~option =
    match t with
    | Create_index_statement (uniq, exists, name, tname, cols, expr, _) ->
      let kw =
        match uniq with
        | Some _ -> [ Kw_create; Kw_unique; Kw_index ]
        | None -> [ Kw_create; Kw_index ]
      in
      let kw =
        match exists with
        | Some _ -> List.append kw [ Kw_if; Kw_not; Kw_exists ]
        | None -> kw
      in
      Sfmt.keyword ~option f kw;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f name;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_on ];
      Fmt.string f " ";
      let module T = (val T.generate ()) in
      T.print ~option f tname;
      Fmt.string f " ";

      Sfmt.parens_box ~option
        (fun f _ ->
          let c = List.hd cols
          and cs = List.tl cols in

          let module I = (val I.generate ()) in
          I.print ~option f c;

          List.iter
            (fun c ->
              Sfmt.comma ~option f ();
              Fmt.cut f ();
              I.print ~option f c)
            cs)
        f ();

      Option.iter
        (fun e ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_where ];
          Sfmt.force_vbox option.indent_size
            (fun f _ ->
              let module Expr = (val Expr.generate ()) in
              Expr.print ~option f e)
            f ())
        expr
end
