type token =
  | Kw_select
  | Kw_from
  | Kw_as
  | Kw_distinct
  | Kw_all
  | Tok_ident of string
  | Tok_asterisk
  | Tok_lparen
  | Tok_rparen
  | Tok_period
  | Tok_comma
  | Op_plus
  | Op_minus
  | Op_star
  | Op_slash
  | Op_double_amp
  | Op_concat
  | Tok_eof
[@@deriving show, eq]
