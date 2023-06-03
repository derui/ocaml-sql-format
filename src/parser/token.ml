type token =
  | Kw_select of string
  | Kw_from of string
  | Kw_as of string
  | Tok_ident of string
  | Tok_asterisk
  | Tok_lparen
  | Tok_rparen
  | Tok_space of string
  | Tok_eof
[@@deriving show, eq]
