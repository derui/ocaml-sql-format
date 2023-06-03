type keyword =
  | Ky_select of string
  | Ky_from of string
  | Ky_as of string
[@@deriving show, eq]

and syntax =
  | Sy_keyword of keyword
  | Sy_ident of string
  | Sy_asterisk
  | Sy_lparen
  | Sy_rparen
[@@deriving show, eq]
