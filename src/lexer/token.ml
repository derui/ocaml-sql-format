type keyword =
  | Ky_select of string
  | Ky_from of string
  | Ky_as of string
[@@deriving show, eq]

and token =
  | Tok_keyword of keyword
  | Tok_ident of string
  | Tok_asterisk
  | Tok_lparen
  | Tok_rparen
[@@deriving show, eq]
