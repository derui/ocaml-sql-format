(** Define a formatter for each kind *)
module M = Monad

module C = Sql_syntax.CST
module Sp = Support

(* formatter entry point *)
let rec format pp options language =
  let module L = Sql_syntax.Language in
  L.walk ~f:(fun r -> M.Run.run (format_sql_stmt_list ()) options pp r |> Option.some) language

and format_sql_stmt_list () =
  let open M.Let_syntax in
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.node C.Sql_stmt_list.n_sql_stmt format_sql_stmt in
        let* _ = Sp.leaf C.Sql_stmt_list.t_semicolon in
        Sp.cut ())
  in
  Sp.vbox m

and format_sql_stmt () =
  let open M.Let_syntax in
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.keyword ~trailing:Sp.nonbreak C.Sql_stmt.kw_explain in
        let* _ = Sp.keyword ~trailing:Sp.nonbreak C.Sql_stmt.kw_analyze in
        let* _ = Sp.node C.Sql_stmt.n_begin_stmt format_begin_stmt in
        let* _ = Sp.node C.Sql_stmt.n_rollback_stmt format_rollback_stmt in
        let* _ = Sp.node C.Sql_stmt.n_select_stmt format_select_stmt in
        let* _ = Sp.node C.Sql_stmt.n_create_index_stmt format_create_index_stmt in
        M.return ())
  in
  Sp.vbox m

and format_begin_stmt () =
  let open M.Let_syntax in
  Sp.iter (fun () ->
      let* _ = Sp.keyword C.Begin_stmt.kw_begin in
      let* _ = Sp.keyword ~leading:Sp.nonbreak C.Begin_stmt.kw_transaction in
      M.return ())

and format_rollback_stmt () =
  let open M.Let_syntax in
  Sp.iter (fun () ->
      let* _ = Sp.keyword C.Rollback_stmt.kw_rollback in
      let* _ = Sp.keyword ~leading:Sp.nonbreak C.Rollback_stmt.kw_transaction in
      M.return ())

and format_select_stmt () =
  let open M.Let_syntax in
  let module S = C.Select_stmt in
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.node S.n_with_clause format_with_clause in
        let* _ = Sp.node S.n_select_core format_select_core in
        M.return ())
  in
  Sp.vbox m

and format_with_clause () =
  let open M.Let_syntax in
  let module W = C.With_clause in
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.keyword W.kw_with in
        let* _ = Sp.keyword ~leading:Sp.nonbreak W.kw_recursive in
        let* _ = Sp.node W.n_common_table_expression format_common_table_expression in
        let* _ = Sp.leaf ~leading:Sp.nonbreak W.kw_recursive in
        let* _ = Sp.leaf ~trailing:(Sp.cut ()) ~leading:(Sp.cut ()) W.t_comma in
        M.return ())
  in
  Sp.vbox m

and format_common_table_expression () =
  let open M.Let_syntax in
  let module C = C.Common_table_expression in
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.leaf C.t_ident in
        let* _ = Sp.leaf ~trailing:(Sp.cut ~indentation:true ()) C.t_lparen in
        let* _ = Sp.node C.n_column_name_list format_column_name_list in
        let* _ = Sp.leaf ~leading:(Sp.cut ()) ~trailing:Sp.nonbreak C.t_rparen in
        let* _ = Sp.keyword ~trailing:Sp.nonbreak C.kw_as in
        let* _ = Sp.keyword ~trailing:Sp.nonbreak C.kw_not in
        let* _ = Sp.keyword ~trailing:Sp.nonbreak C.kw_materialized in
        let* _ = Sp.node C.n_select_stmt format_select_stmt in
        M.return ())
  in
  Sp.vbox m

and format_column_name_list () =
  let open M.Let_syntax in
  let module C = C.Column_name_list in
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.leaf C.t_ident in
        let* _ = Sp.leaf ~trailing:(Sp.cut ()) C.t_comma in
        M.return ())
  in
  Sp.vbox m

and format_result_column_list () =
  let open M.Let_syntax in
  let module S = C.Result_column_list in
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.leaf ~trailing:(Sp.cut ()) S.t_comma in
        let* _ = Sp.node S.n_result_column format_result_column in
        M.return ())
  in
  Sp.hvbox m

and format_result_column () =
  let open M.Let_syntax in
  let module R = C.Result_column in
  Sp.iter (fun () ->
      let* _ = Sp.node R.n_alias format_result_column_alias in
      let* _ = Sp.node R.n_table_name format_result_column_table_name in
      let* _ = Sp.leaf R.t_star in
      M.return ())

and format_result_column_alias () =
  let open M.Let_syntax in
  let module R = C.Result_column_alias in
  Sp.iter (fun () ->
      let* _ = Sp.node R.n_expr format_expr in
      let* _ = Sp.keyword ~leading:Sp.nonbreak R.kw_as in
      let* _ = Sp.leaf ~leading:Sp.nonbreak R.t_ident in
      M.return ())

and format_result_column_table_name () =
  let open M.Let_syntax in
  let module R = C.Result_column_table_name in
  Sp.iter (fun () ->
      let* _ = Sp.leaf R.t_ident in
      let* _ = Sp.leaf R.t_period in
      let* _ = Sp.leaf R.t_star in
      M.return ())

and format_expr () =
  let open M.Let_syntax in
  let module E = C.Expr in
  let m = Sp.iter (fun () -> M.return ()) in
  Sp.vbox m

and format_select_core () =
  let open M.Let_syntax in
  let module S = C.Select_core in
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.keyword S.kw_select in
        let* _ = Sp.node S.n_result_column_list format_result_column_list in
        let* _ = Sp.node S.n_from_clause format_from_clause in
        let* _ = Sp.node S.n_where_clause format_where_clause in
        let* _ = Sp.node S.n_group_by_clause format_group_by_clause in
        let* _ = Sp.node S.n_order_by_clause format_order_by_clause in
        let* _ = Sp.node S.n_limit_clause format_limit_clause in
        M.return ())
  in
  Sp.vbox m

and format_create_index_stmt () = M.return ()
