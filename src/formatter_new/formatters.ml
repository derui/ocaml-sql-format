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

and format_type_name () =
  let open M.Let_syntax in
  let module T = C.Type_name in
  Sp.iter (fun () ->
      let* _ = Sp.leaf ~trailing:Sp.nonbreak T.t_ident in
      let* _ = Sp.leaf T.t_lparen in
      let* _ = Sp.leaf T.t_plus in
      let* _ = Sp.leaf T.t_minus in
      let* _ = Sp.leaf T.t_numeric in
      let* _ = Sp.leaf T.t_comma in
      let* _ = Sp.leaf T.t_rparen in
      M.return ())

and format_filter_clause () =
  let open M.Let_syntax in
  let module F = C.Filter_clause in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.keyword F.kw_filter ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak in
        let* _ = Sp.leaf F.t_lparen ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.leaf F.t_rparen ~leading:(Sp.cut ()) in
        let* _ = Sp.keyword F.kw_where ~trailing:Sp.nonbreak in
        let* _ = Sp.node F.n_expr format_expr in
        M.return ())
  in
  Sp.hovbox p

and format_over_clause () =
  let open M.Let_syntax in
  let module O = C.Over_clause in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.keyword O.kw_over ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak in
        let* _ = Sp.leaf O.t_ident in
        let* _ = Sp.node O.n_window_defn format_window_defn in
        M.return ())
  in
  Sp.hovbox p

and format_window_defn () =
  let open M.Let_syntax in
  let module W = C.Window_defn in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.leaf W.t_ident in
        let* _ = Sp.keyword W.kw_partition ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak in
        let* _ = Sp.keyword W.kw_by ~trailing:Sp.nonbreak in
        let* _ = Sp.leaf W.t_comma ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.node W.n_expr format_expr in
        let* _ = Sp.node W.n_order_by_clause format_order_by_clause in
        let* _ = Sp.node W.n_frame_spec format_frame_spec in
        M.return ())
  in
  Sp.hovbox p

and format_expr () =
  let open M.Let_syntax in
  let module E = C.Expr in
  (* TODO implement *)
  let m =
    Sp.iter (fun () ->
        let* _ = Sp.leaf E.t_qmark in
        let* _ = Sp.leaf E.t_string in
        let* _ = Sp.leaf E.t_numeric in
        let* _ = Sp.leaf E.t_blob in
        let* _ = Sp.keyword E.kw_null in
        let* _ = Sp.keyword E.kw_true in
        let* _ = Sp.keyword E.kw_false in
        let* _ = Sp.keyword E.kw_current_date in
        let* _ = Sp.keyword E.kw_current_time in
        let* _ = Sp.keyword E.kw_current_timestamp in
        let* _ = Sp.node E.n_expr_name format_expr_name in
        let* _ = Sp.node E.n_expr_unary format_expr_unary in
        let* _ = Sp.node E.n_expr_function format_expr_function in
        let* _ = Sp.node E.n_expr_cast format_expr_cast in
        let* _ = Sp.node E.n_expr_collate format_expr_collate in
        let* _ = Sp.node E.n_expr_like format_expr_like in
        let* _ = Sp.node E.n_expr_in format_expr_in in
        let* _ = Sp.node E.n_expr_between format_expr_between in
        let* _ = Sp.node E.n_expr_glob format_expr_glob in
        let* _ = Sp.node E.n_expr_regexp format_expr_regexp in
        let* _ = Sp.node E.n_expr_match format_expr_match in
        let* _ = Sp.node E.n_expr_is format_expr_is in
        let* _ = Sp.node E.n_expr_exists format_expr_exists in
        let* _ = Sp.node E.n_expr_case format_expr_case in
        M.return ())
  in
  Sp.vbox m

and format_expr_name () =
  let open M.Let_syntax in
  let module E = C.Expr_name in
  Sp.iter (fun () ->
      let* _ = Sp.leaf E.t_ident in
      let* _ = Sp.leaf E.t_period in
      M.return ())

and format_expr_unary () =
  let open M.Let_syntax in
  let module E = C.Expr_unary in
  Sp.iter (fun () ->
      let* _ = Sp.leaf E.t_minus in
      let* _ = Sp.leaf E.t_plus in
      let* _ = Sp.leaf E.t_tilde in
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_not in
      let* _ = Sp.node E.n_expr format_expr in
      M.return ())

and format_expr_cast () =
  let open M.Let_syntax in
  let module E = C.Expr_cast in
  Sp.iter (fun () ->
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_cast in
      let* _ = Sp.leaf E.t_lparen in
      let* _ = Sp.node E.n_expr format_expr in
      let* _ = Sp.keyword ~leading:Sp.nonbreak ~trailing:Sp.nonbreak E.kw_as in
      let* _ = Sp.node E.n_type_name format_type_name in
      let* _ = Sp.leaf E.t_rparen in
      M.return ())

and format_expr_function () =
  let open M.Let_syntax in
  let module E = C.Expr_function in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.leaf E.t_ident in
        let* _ = Sp.leaf E.t_lparen ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.leaf E.kw_distinct ~trailing:Sp.nonbreak in
        let* _ = Sp.node E.n_expr format_expr in
        let* _ = Sp.leaf E.t_comma ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.leaf E.t_rparen in
        let* _ = Sp.node E.n_filter_clause format_filter_clause in
        let* _ = Sp.node E.n_over_clause format_over_clause in
        let* _ = Sp.node E.n_order_by_clause format_order_by_clause in
        M.return ())
  in
  Sp.hvbox p

and format_expr_collate () =
  let open M.Let_syntax in
  let module E = C.Expr_collate in
  Sp.iter (fun () ->
      let* _ = Sp.node E.n_expr format_expr in
      let* _ = Sp.keyword ~leading:Sp.nonbreak ~trailing:Sp.nonbreak E.kw_collate in
      let* _ = Sp.leaf E.t_ident in
      M.return ())

and format_expr_like () =
  let open M.Let_syntax in
  let module E = C.Expr_like in
  Sp.iter (fun () ->
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_not in
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_like in
      let* _ = Sp.keyword ~leading:Sp.nonbreak ~trailing:Sp.nonbreak E.kw_escape in
      let* _ = Sp.node E.n_expr format_expr in
      M.return ())

and format_expr_glob () =
  let open M.Let_syntax in
  let module E = C.Expr_glob in
  Sp.iter (fun () ->
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_not in
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_glob in
      let* _ = Sp.node E.n_expr format_expr in
      M.return ())

and format_expr_in () =
  let open M.Let_syntax in
  let module E = C.Expr_in in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_not in
        let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_in in
        let* _ = Sp.leaf E.t_ident in
        let* _ = Sp.leaf E.t_period in
        let* _ = Sp.node E.n_expr format_expr in
        let* _ = Sp.leaf E.t_lparen in
        let* _ = Sp.node E.n_select_stmt format_sql_stmt in
        let* _ = Sp.leaf ~leading:(Sp.cut ~indentation:true ()) E.t_comma in
        let* _ = Sp.leaf ~leading:(Sp.cut ()) E.t_rparen in
        M.return ())
  in
  Sp.hvbox p

and format_expr_between () =
  let open M.Let_syntax in
  let module E = C.Expr_between in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_not in
        let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_between in
        let* _ = Sp.node E.n_expr format_expr in
        let* _ = Sp.keyword ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak E.kw_and in
        let* _ = Sp.node E.n_expr format_expr in
        M.return ())
  in
  Sp.hvbox p

and format_expr_regexp () =
  let open M.Let_syntax in
  let module E = C.Expr_regexp in
  Sp.iter (fun () ->
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_not in
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_regexp in
      let* _ = Sp.node E.n_expr format_expr in
      M.return ())

and format_expr_match () =
  let open M.Let_syntax in
  let module E = C.Expr_match in
  Sp.iter (fun () ->
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_not in
      let* _ = Sp.keyword ~trailing:Sp.nonbreak E.kw_match in
      let* _ = Sp.node E.n_expr format_expr in
      M.return ())

and format_select_core () =
  let module S = C.Select_core in
  (* TODO implement *)
  let m = Sp.iter (fun () -> M.return ()) in
  Sp.vbox m

and format_create_index_stmt () = M.return ()
