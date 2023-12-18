(** kind of node *)
type node =
  | N_expr
  | N_expr_function
  | N_expr_literal
  | N_expr_bind_parameter
  | N_expr_name
  | N_expr_cast
  | N_filter_clause
  | N_type_name
  | N_expr_collate
  | N_expr_unary
  | N_expr_wrap
  | N_expr_like
  | N_expr_glob
  | N_expr_regexp
  | N_expr_match
  | N_expr_is
  | N_expr_between
  | N_expr_between_predicand
  | N_expr_in
  | N_expr_case
  | N_expr_case_when
  | N_expr_case_case
  | N_expr_case_else
  | N_expr_exists
  | N_expr_binary_op
  | N_expr_logical_op
  | N_select_core
  | N_from_clause
  | N_table_or_subquery
  | N_table_or_subquery_table_name
  | N_table_or_subquery_table_function
  | N_join_clause
  | N_join_operator
  | N_join_constraint
  | N_where_clause
  | N_group_by_clause
  | N_having_clause
  | N_window_defn
  | N_order_by_clause
  | N_ordering_term
  | N_frame_spec
  | N_window_clause
  | N_result_column
  | N_result_column_alias
  | N_result_column_table_name
  | N_over_clause
  | N_limit_clause
  | N_common_table_expression
  | N_with_clause
  | N_indexed_column
  | N_qualified_table_name
  | N_returning_clause
  | N_column_name_list
  | N_result_column_list
  | N_common_value_expression
  | N_numeric_value_expression
  | N_numeric_value_expression_term
  | N_value_expression_primary
  | N_non_numeric_literal
  | N_unsigned_numeric_literal
  | N_unsigned_value_expression_primary
  (* uvep is short term of unsigned_value_expression_primary *)
  | N_uvep_subquery
  | N_uvep_parameter_reference
  | N_uvep_nested_expression
  | N_uvep_case_expression
  | N_uvep_function
  | N_uvep_ident
  (* statements *)
  | N_sql_stmt
  | N_sql_stmt_list
  | N_select_stmt
  | N_begin_stmt
  | N_rollback_stmt
  | N_commit_stmt
  | N_create_index_stmt
  | N_delete_stmt
[@@deriving ord, show]

(** kind of leaf *)
type leaf =
  | L_ident
  | L_string
  | L_blob
  | L_numeric
  | L_keyword
  | L_lparen
  | L_rparen
  | L_period
  | L_comma
  | L_colon
  | L_dollar
  | L_lbrace
  | L_rbrace
  | L_lsbrace
  | L_rsbrace
  | L_qmark
  | L_semicolon
  | L_plus
  | L_minus
  | L_star
  | L_slash
  | L_modulo
  | L_amp
  | L_pipe
  | L_concat
  | L_eq
  | L_eq2
  | L_ge
  | L_gt
  | L_le
  | L_lt
  | L_ne
  | L_ne2
  | L_extract
  | L_extract_2
  | L_tilde
  | L_lshift
  | L_rshift
  | L_eof
[@@deriving show]

let token_to_leaf = function
  | Types.Token.Tok_ident _ -> L_ident
  | Tok_string _ -> L_string
  | Tok_blob _ -> L_blob
  | Tok_numeric _ -> L_numeric
  | Tok_keyword _ -> L_keyword
  | Tok_lparen -> L_lparen
  | Tok_rparen -> L_rparen
  | Tok_period -> L_period
  | Tok_comma -> L_comma
  | Tok_colon -> L_colon
  | Tok_dollar -> L_dollar
  | Tok_lbrace -> L_lbrace
  | Tok_rbrace -> L_rbrace
  | Tok_lsbrace -> L_lsbrace
  | Tok_rsbrace -> L_rsbrace
  | Tok_qmark -> L_qmark
  | Tok_semicolon -> L_semicolon
  | Tok_space | Tok_newline | Tok_line_comment _ | Tok_block_comment _ -> failwith "Invalid leaf"
  | Op_plus -> L_plus
  | Op_minus -> L_minus
  | Op_star -> L_star
  | Op_slash -> L_slash
  | Op_modulo -> L_modulo
  | Op_amp -> L_amp
  | Op_pipe -> L_pipe
  | Op_concat -> L_concat
  | Op_eq -> L_eq
  | Op_eq2 -> L_eq2
  | Op_ge -> L_ge
  | Op_gt -> L_gt
  | Op_le -> L_le
  | Op_lt -> L_lt
  | Op_ne -> L_ne
  | Op_ne2 -> L_ne2
  | Op_extract -> L_extract
  | Op_extract_2 -> L_extract
  | Op_tilde -> L_tilde
  | Op_lshift -> L_lshift
  | Op_rshift -> L_rshift
  | Tok_eof -> L_eof
