open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_or_subquery

module Make
    (V : GEN with type t = ext schema_name)
    (T : GEN with type t = ext table_name)
    (I : GEN with type t = ext identifier)
    (Statement : GEN with type t = ext select_statement)
    (Join : GEN with type t = ext join_clause) : S = struct
  type t = ext table_or_subquery

  let rec print f t ~option =
    match t with
    | Table_or_subquery (`name (sname, tname, alias), _) ->
      Option.iter
        (fun v ->
          let module V = (val V.generate ()) in
          V.print ~option f v;
          Token.print ~option f Tok_period)
        sname;

      let module T = (val T.generate ()) in
      T.print ~option f tname;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_as ];
          Fmt.string f " ";
          let module I = (val I.generate ()) in
          I.print ~option f v)
        alias
    | Table_or_subquery (`statement (v, alias), _) ->
      Sfmt.parens ~indent:() ~option
        (fun f _ ->
          let module Statement = (val Statement.generate ()) in
          Statement.print ~option f v)
        f ();

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module I = (val I.generate ()) in
          I.print ~option f v)
        alias
    | Table_or_subquery (`nested vs, _) ->
      Sfmt.parens ~indent:() ~option
        (fun f _ ->
          let v = List.hd vs in
          let vs = List.tl vs in

          print ~option f v;

          List.iter
            (fun v ->
              Token.print ~option f Tok_comma;
              Fmt.cut f ();
              print ~option f v)
            vs)
        f ()
    | Table_or_subquery (`join v, _) ->
      Sfmt.parens ~indent:() ~option
        (fun f _ ->
          let module Join = (val Join.generate ()) in
          Join.print ~option f v)
        f ()
end
