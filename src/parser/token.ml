type token =
  | Kw_select of string
  | Kw_from of string
  | Kw_as of string
  | Kw_distinct of string
  | Kw_all of string
  | Tok_ident of string
  | Tok_asterisk
  | Tok_lparen
  | Tok_rparen
  | Tok_eof
[@@deriving show, eq]
