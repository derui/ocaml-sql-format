type token =
  | Kw_select
  | Kw_from
  | Kw_as
  | Kw_distinct
  | Kw_all
  | Kw_true
  | Kw_false
  | Kw_unknown
  | Kw_null
  | Kw_date
  | Kw_time
  | Kw_timestamp
  | Kw_into
  | Kw_or
  | Kw_not
  | Kw_and
  | Kw_union
  | Kw_except
  | Kw_intersect
  | Kw_group
  | Kw_by
  | Kw_rollup
  (* tokens *)
  | Tok_ident of string
  | Tok_all_in_group of string
  | Tok_string of string
  | Tok_typed_string of string
  | Tok_bin_string of string
  | Tok_unsigned_integer of Ast.Literal.unsigned_integer
  | Tok_approximate_numeric of Ast.Literal.approximate_numeric
  | Tok_decimal_numeric of Ast.Literal.decimal_numeric
  | Tok_lparen
  | Tok_rparen
  | Tok_period
  | Tok_comma
  | Tok_colon
  | Tok_dollar
  | Tok_lbrace
  | Tok_rbrace
  | Tok_lsbrace
  | Tok_rsbrace
  | Tok_qmark
  | Tok_semicolon
  (* operators *)
  | Op_plus
  | Op_minus
  | Op_star
  | Op_slash
  | Op_double_amp
  | Op_concat
  | Op_eq
  | Op_ge
  | Op_gt
  | Op_le
  | Op_lt
  | Op_ne
  | Op_ne2
  | Tok_eof
[@@deriving show, eq]
