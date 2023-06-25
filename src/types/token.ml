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
  | Kw_having
  | Kw_where
  | Kw_order
  | Kw_asc
  | Kw_desc
  | Kw_first
  | Kw_last
  | Kw_limit
  | Kw_offset
  | Kw_row
  | Kw_rows
  | Kw_fetch
  | Kw_next
  | Kw_only
  | Kw_is
  | Kw_between
  | Kw_like_regex
  | Kw_similar
  | Kw_to
  | Kw_escape
  | Kw_like
  | Kw_any
  | Kw_some
  | Kw_in
  | Kw_exists
  | Kw_with
  | Kw_table
  | Kw_lateral
  | Kw_left
  | Kw_right
  | Kw_full
  | Kw_outer
  | Kw_inner
  | Kw_cross
  | Kw_join
  | Kw_on
  | Kw_case
  | Kw_when
  | Kw_then
  | Kw_end
  | Kw_else
  | Kw_textagg
  | Kw_for
  | Kw_delimiter
  | Kw_quote
  | Kw_no
  | Kw_header
  | Kw_encoding
  | Kw_count
  | Kw_count_big
  | Kw_sum
  | Kw_avg
  | Kw_min
  | Kw_max
  | Kw_every
  | Kw_stddev_pop
  | Kw_stddev_samp
  | Kw_var_samp
  | Kw_var_pop
  | Kw_filter
  | Kw_over
  | Kw_partition
  | Kw_range
  | Kw_unbounded
  | Kw_following
  | Kw_preceding
  | Kw_current
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
