(** kind of node *)
type node =
  | N_expr
  | N_filter_clause
  | N_type_name
  | N_expr_collate
  | N_expr_unary
  | N_expr_wrap
  | N_expr_like
  | N_expr_glob
  | N_expr_regexp
  | N_expr_match
  | N_expr_literal
  | N_expr_is
  | N_expr_between
  | N_expr_in
  | N_expr_case
  | N_expr_when
  | N_select_core
  | N_from_clause
  | N_table_or_subquery
  | N_join_clause
  | N_where_clause
  | N_group_by_clause
  | N_having_clause
  | N_window_defn
  | N_order_by_clause
  | N_ordering_term
  | N_frame_spec
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
  | L_quote
  | L_plus
  | L_minus
  | L_star
  | L_slash
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
  | L_tilda
  | L_lshift
  | L_rshift
  | L_eof

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
  | Tok_quote -> L_quote
  | Tok_space | Tok_newline | Tok_line_comment _ | Tok_block_comment _ ->
    failwith "Invalid leaf"
  | Op_plus -> L_plus
  | Op_minus -> L_minus
  | Op_star -> L_star
  | Op_slash -> L_slash
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
  | Op_tilda -> L_tilda
  | Op_lshift -> L_lshift
  | Op_rshift -> L_rshift
  | Tok_eof -> L_eof
