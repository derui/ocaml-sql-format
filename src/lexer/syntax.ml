type keyword =
  | Ky_select of string
  | Ky_asterisk
  | Ky_from of string
[@@deriving show, eq]

and syntax =
  | Sy_keyword of keyword
  | Sy_ident of string
[@@deriving show, eq]
