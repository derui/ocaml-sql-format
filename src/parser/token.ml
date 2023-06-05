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
  | Tok_eof
[@@deriving show, eq]
