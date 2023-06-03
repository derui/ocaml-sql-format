type keyword =
  | Kw_select of string
  | Kw_from of string
  | Kw_as of string
[@@deriving show, eq]

and t =
  | Tok_keyword of keyword
  | Tok_ident of string
  | Tok_asterisk
  | Tok_lparen
  | Tok_rparen
[@@deriving show, eq]
