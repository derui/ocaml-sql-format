type t =
  (* tokens *)
  | Tok_ident of string
  | Tok_string of string
  | Tok_blob of string
  | Tok_numeric of string
  | Tok_keyword of string * Keyword.t
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
  | Tok_quote
  | Tok_space
  | Tok_newline
  | Tok_line_comment of string
  | Tok_block_comment of string
  (* operators *)
  | Op_plus
  | Op_minus
  | Op_star
  | Op_slash
  | Op_amp
  | Op_pipe
  | Op_concat
  | Op_eq
  | Op_eq2
  | Op_ge
  | Op_gt
  | Op_le
  | Op_lt
  | Op_ne
  | Op_ne2
  | Op_extract
  | Op_extract_2
  | Op_tilda
  | Op_lshift
  | Op_rshift
  | Tok_eof
[@@deriving show, eq]

let show = function
  (* tokens *)
  | Tok_ident t -> t
  | Tok_string t -> t
  | Tok_blob t -> t
  | Tok_numeric t -> t
  | Tok_keyword (t, _) -> t
  | Tok_lparen -> "("
  | Tok_rparen -> ")"
  | Tok_period -> "."
  | Tok_comma -> "."
  | Tok_colon -> ":"
  | Tok_dollar -> "$"
  | Tok_lbrace -> "{"
  | Tok_rbrace -> "}"
  | Tok_lsbrace -> "["
  | Tok_rsbrace -> "]"
  | Tok_qmark -> "?"
  | Tok_semicolon -> ";"
  | Tok_quote -> "'"
  | Tok_space -> " "
  | Tok_newline -> "\n"
  | Tok_line_comment t -> t
  | Tok_block_comment t -> t
  | Op_plus -> "+"
  | Op_minus -> "-"
  | Op_star -> "*"
  | Op_slash -> "/"
  | Op_amp -> "&"
  | Op_pipe -> "|"
  | Op_concat -> "||"
  | Op_eq -> "="
  | Op_eq2 -> "=="
  | Op_ge -> ">="
  | Op_gt -> ">"
  | Op_le -> "<="
  | Op_lt -> "<"
  | Op_ne -> "<>"
  | Op_ne2 -> "!="
  | Op_extract -> "->"
  | Op_extract_2 -> "->>"
  | Op_tilda -> "~"
  | Op_lshift -> "<<"
  | Op_rshift -> ">>"
  | Tok_eof -> ""

let pp fmt t = Format.fprintf fmt "%s" @@ show t
