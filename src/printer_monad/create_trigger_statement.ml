open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext create_trigger_statement

module Make
    (V : GEN with type t = ext qualified_table_name)
    (C : GEN with type t = ext column_name)
    (T : GEN with type t = ext table_name)
    (Expr : GEN with type t = ext expr)
    (Update : GEN with type t = ext update_statement)
    (Delete : GEN with type t = ext delete_statement)
    (Insert : GEN with type t = ext insert_statement)
    (Select : GEN with type t = ext select_statement) : S = struct
  type t = ext create_trigger_statement

  let print_timing ~option f = function
    | `before -> Sfmt.keyword ~option f [ Kw_before ]
    | `after -> Sfmt.keyword ~option f [ Kw_after ]
    | `instead -> Sfmt.keyword ~option f [ Kw_instead; Kw_of ]

  let print_method ~option f = function
    | `delete -> Sfmt.keyword ~option f [ Kw_delete ]
    | `insert -> Sfmt.keyword ~option f [ Kw_insert ]
    | `update cl ->
      Sfmt.keyword ~option f [ Kw_update ];

      Option.iter
        (fun cl ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_of ];
          Fmt.string f " ";

          Sfmt.parens ~option
            (fun f _ ->
              let module C = (val C.generate ()) in
              let c = List.hd cl
              and cs = List.tl cl in

              C.print ~option f c;
              List.iter
                (fun c ->
                  Sfmt.comma ~option f ();
                  C.print ~option f c)
                cs)
            f ())
        cl

  let print_for_each ~option f =
    Option.iter (fun _ ->
        Fmt.string f " ";
        Sfmt.keyword ~option f [ Kw_for; Kw_each; Kw_row ])

  let print_expr ~option f =
    Option.iter (fun e ->
        Fmt.string f " ";
        Sfmt.keyword ~option f [ Kw_when ];
        Fmt.string f " ";
        let module Expr = (val Expr.generate ()) in
        Expr.print ~option f e)

  let print_stmt ~option f = function
    | `update s ->
      let module Update = (val Update.generate ()) in
      Update.print ~option f s;
      Fmt.string f ";"
    | `insert s ->
      let module Insert = (val Insert.generate ()) in
      Insert.print ~option f s;
      Fmt.string f ";"
    | `delete s ->
      let module Delete = (val Delete.generate ()) in
      Delete.print ~option f s;
      Fmt.string f ";"
    | `select s ->
      let module Select = (val Select.generate ()) in
      Select.print ~option f s;
      Fmt.string f ";"

  let print f t ~option =
    match t with
    | Create_trigger_statement
        (temp, exists, qname, timing, met, tname, for_each, expr, stmts, _) ->
      let kw =
        match temp with
        | Some _ -> [ Kw_create; Kw_temporary; Kw_trigger ]
        | None -> [ Kw_create; Kw_trigger ]
      in
      let kw =
        match exists with
        | Some _ -> kw @ [ Kw_if; Kw_not; Kw_exists ]
        | None -> kw
      in
      Sfmt.keyword ~option f kw;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f qname;
      Fmt.cut f ();
      print_timing ~option f timing;
      Fmt.string f " ";
      print_method ~option f met;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_on ];
      Fmt.string f " ";
      let module T = (val T.generate ()) in
      T.print ~option f tname;
      print_for_each ~option f for_each;
      print_expr ~option f expr;
      Fmt.cut f ();
      Sfmt.keyword ~option f [ Kw_begin ];

      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let stmt = List.hd stmts
          and ss = List.tl stmts in

          print_stmt ~option f stmt;
          List.iter
            (fun s ->
              Fmt.cut f ();
              Fmt.cut f ();
              print_stmt ~option f s)
            ss)
        f ();

      Fmt.cut f ();
      Sfmt.keyword ~option f [ Kw_end ]
end
