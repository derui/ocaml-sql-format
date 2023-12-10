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
        (* let* _ = Sp.node C.Sql_stmt.n_create_index_stmt format_create_index_stmt in *)
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
    let* _ =
      Sp.iter (fun () ->
          let* _ = Sp.leaf ~trailing:(Sp.cut ()) S.t_comma in
          let* _ = Sp.node S.n_result_column format_result_column in
          M.return ())
    in
    Sp.cut ()
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

and format_frame_spec () =
  let open M.Let_syntax in
  let module F = C.Frame_spec in
  Sp.iter (fun () ->
      let* _ = Sp.keyword F.kw_rows ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_range ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_groups ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_between ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_unbounded ~leading:(Sp.sp ()) in
      let* _ = Sp.keyword F.kw_preceding ~leading:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_following ~leading:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_current ~leading:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_row ~leading:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_and ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_no ~leading:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_others ~leading:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_ties ~leading:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_group ~leading:Sp.nonbreak in
      let* _ = Sp.keyword F.kw_exclude ~leading:Sp.nonbreak in
      let* _ = Sp.node F.n_expr format_expr in
      M.return ())

and format_order_by_clause () =
  let open M.Let_syntax in
  let module O = C.Order_by_clause in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.keyword O.kw_order ~leading:(Sp.sp ()) ~trailing:Sp.nonbreak in
        let* _ = Sp.keyword O.kw_by ~trailing:Sp.nonbreak in
        let* _ = Sp.node O.n_ordering_term format_ordering_term in
        let* _ = Sp.leaf O.t_comma ~trailing:(Sp.cut ~indentation:true ()) in
        M.return ())
  in
  Sp.hvbox p

and format_ordering_term () =
  let open M.Let_syntax in
  let module O = C.Ordering_term in
  Sp.iter (fun () ->
      let* _ = Sp.node O.n_expr format_expr in
      let* _ = Sp.keyword O.kw_asc ~leading:Sp.nonbreak in

      let* _ = Sp.keyword O.kw_desc ~leading:Sp.nonbreak in
      let* _ = Sp.keyword O.kw_nulls ~leading:Sp.nonbreak in
      let* _ = Sp.keyword O.kw_first ~leading:Sp.nonbreak in
      let* _ = Sp.keyword O.kw_last ~leading:Sp.nonbreak in
      M.return ())

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

and format_expr_is () =
  let open M.Let_syntax in
  let module E = C.Expr_is in
  Sp.iter (fun () ->
      let* _ = Sp.keyword E.kw_is ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword E.kw_not ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword E.kw_distinct ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword E.kw_from ~trailing:Sp.nonbreak in
      let* _ = Sp.node E.n_expr format_expr in
      M.return ())

and format_expr_exists () =
  let open M.Let_syntax in
  let module E = C.Expr_exists in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.keyword E.kw_exists ~trailing:Sp.nonbreak in
        let* _ = Sp.keyword E.kw_not ~trailing:Sp.nonbreak in
        let* _ = Sp.node E.n_select_stmt format_sql_stmt in
        let* _ = Sp.leaf E.t_lparen ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.leaf E.t_rparen ~leading:(Sp.cut ()) in
        M.return ())
  in
  Sp.hovbox p

and format_expr_case () =
  let open M.Let_syntax in
  let module E = C.Expr_case in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.keyword E.kw_case ~trailing:Sp.nonbreak in
        let* _ = Sp.node E.n_expr format_expr in
        let* _ = Sp.keyword E.kw_when ~leading:(Sp.cut ()) ~trailing:(Sp.sp ()) in
        let* _ = Sp.keyword E.kw_then ~leading:(Sp.sp ()) ~trailing:(Sp.sp ()) in
        let* _ = Sp.keyword E.kw_else ~leading:(Sp.cut ()) ~trailing:Sp.nonbreak in
        let* _ = Sp.keyword E.kw_end ~leading:(Sp.cut ()) in
        M.return ())
  in
  Sp.hvbox p

and format_select_core () =
  let open M.Let_syntax in
  let module S = C.Select_core in
  let p =
    let* distinct_contained = Sp.Condition.contains S.kw_distinct in
    let* all_contained = Sp.Condition.contains S.kw_all in
    Sp.iter (fun () ->
        let* _ =
          if distinct_contained || all_contained then Sp.keyword S.kw_select ~trailing:Sp.nonbreak
          else Sp.keyword S.kw_select ~trailing:(Sp.cut ~indentation:true ())
        in
        let* _ = Sp.keyword S.kw_distinct ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.keyword S.kw_all ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.node S.n_result_column_list format_result_column_list in
        let* _ = Sp.node S.n_from_clause format_from_clause in
        let* _ = Sp.node S.n_where_clause format_where_clause in
        let* _ = Sp.node S.n_group_by_clause format_group_by_clause in
        let* _ = Sp.node S.n_having_clause format_having_clause in
        M.return ())
  in
  Sp.vbox p

and format_where_clause () =
  let open M.Let_syntax in
  let module W = C.Where_clause in
  Sp.iter (fun () ->
      let* _ = Sp.keyword W.kw_where ~trailing:(Sp.cut ~indentation:true ()) in
      let* _ = Sp.node W.n_expr format_expr in
      M.return ())

and format_group_by_clause () =
  let open M.Let_syntax in
  let module G = C.Group_by_clause in
  let p =
    let* _ =
      Sp.iter (fun () ->
          let* _ = Sp.keyword G.kw_group ~trailing:Sp.nonbreak in
          let* _ = Sp.keyword G.kw_by ~trailing:(Sp.cut ~indentation:true ()) in
          let* _ = Sp.node G.n_expr format_expr in
          let* _ = Sp.leaf G.t_comma ~trailing:(Sp.cut ~indentation:true ()) in
          M.return ())
    in
    Sp.cut ()
  in
  Sp.hvbox p

and format_having_clause () =
  let open M.Let_syntax in
  let module H = C.Having_clause in
  Sp.iter (fun () ->
      let* _ = Sp.keyword H.kw_having ~trailing:(Sp.cut ~indentation:true ()) in
      let* _ = Sp.node H.n_expr format_expr in
      M.return ())

and format_from_clause () =
  let open M.Let_syntax in
  let module F = C.From_clause in
  let p =
    let* _ =
      Sp.iter (fun () ->
          let* _ = Sp.keyword F.kw_from ~leading:(Sp.cut ()) ~trailing:(Sp.cut ~indentation:true ()) in
          M.return ())
    in
    let p' =
      Sp.iter (fun () ->
          let* _ = Sp.node F.n_table_or_subquery format_table_or_subquery in
          let* _ = Sp.leaf F.t_comma ~trailing:(Sp.cut ~indentation:true ()) in
          let* _ = Sp.node F.n_join_clause format_join_clause in
          M.return ())
    in
    let* _ = Sp.hvbox p' in
    Sp.cut ()
  in
  p

and format_table_or_subquery () =
  let open M.Let_syntax in
  let module T = C.Table_or_subquery in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.node T.n_table_name format_table_or_subquery_table_name in
        let* _ = Sp.node T.n_table_function format_table_or_subquery_table_function in
        let* _ = Sp.node T.n_join_clause format_join_clause in
        M.return ())
  in
  Sp.vbox p

and format_table_or_subquery_table_name () =
  let open M.Let_syntax in
  let module T = C.Table_or_subquery_table_name in
  Sp.iter (fun () ->
      let* _ = Sp.leaf T.t_ident in
      let* _ = Sp.leaf T.t_period in
      let* _ = Sp.keyword T.kw_as ~trailing:Sp.nonbreak ~leading:Sp.nonbreak in
      M.return ())

and format_table_or_subquery_table_function () =
  let open M.Let_syntax in
  let module T = C.Table_or_subquery_table_function in
  let p =
    Sp.iter (fun () ->
        let* _ = Sp.leaf T.t_ident in
        let* _ = Sp.leaf T.t_lparen ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.node T.n_expr format_expr in
        let* _ = Sp.leaf T.t_comma ~trailing:(Sp.cut ~indentation:true ()) in
        let* _ = Sp.leaf T.t_rparen ~leading:(Sp.cut ()) in
        let* _ = Sp.keyword T.kw_as ~trailing:Sp.nonbreak ~leading:Sp.nonbreak in
        M.return ())
  in
  Sp.hvbox p

and format_join_clause () =
  let open M.Let_syntax in
  let module J = C.Join_clause in
  Sp.iter (fun () ->
      let* _ = Sp.node J.n_table_or_subquery format_table_or_subquery in
      let* _ = Sp.node J.n_join_operator format_join_operator in
      let* _ = Sp.node J.n_join_constraint format_join_constraint in
      M.return ())

and format_join_operator () =
  let open M.Let_syntax in
  let module J = C.Join_operator in
  let* natural_head = Sp.Condition.contains J.kw_natural in
  let leading_after_natural = if natural_head then None else Some (Sp.cut ()) in
  Sp.iter (fun () ->
      let* _ = Sp.keyword J.t_comma ~leading:(Sp.cut ()) in
      let* _ = Sp.keyword J.kw_cross ~leading:(Sp.cut ()) ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword J.kw_natural ~leading:(Sp.cut ()) ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword J.kw_left ?leading:leading_after_natural ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword J.kw_right ?leading:leading_after_natural ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword J.kw_full ?leading:leading_after_natural ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword J.kw_inner ?leading:leading_after_natural ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword J.kw_outer ~trailing:Sp.nonbreak in
      let* _ = Sp.keyword J.kw_join ~trailing:Sp.nonbreak in
      M.return ())

and format_join_constraint () =
  let open M.Let_syntax in
  let module J = C.Join_constraint in
  let p =
    let* _ =
      Sp.iter (fun () ->
          let* _ = Sp.keyword J.kw_on ~trailing:(Sp.cut ~indentation:true ()) in
          let* _ = Sp.node J.n_expr format_expr in
          let* _ = Sp.keyword J.kw_using ~trailing:Sp.nonbreak in
          let* _ = Sp.leaf J.t_lparen ~trailing:(Sp.cut ~indentation:true ()) in
          let* _ = Sp.leaf J.t_ident in
          let* _ = Sp.leaf J.t_comma ~trailing:(Sp.sp ()) in
          let* _ = Sp.leaf J.t_rparen in
          M.return ())
    in
    Sp.cut ()
  in
  Sp.hvbox p
