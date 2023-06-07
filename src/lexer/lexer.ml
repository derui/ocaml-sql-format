open Parser.Token

let kw_select =
  [%sedlex.regexp?
    Chars "sS", Chars "eE", Chars "lL", Chars "eE", Chars "cC", Chars "tT"]

let kw_from = [%sedlex.regexp? Chars "fF", Chars "rR", Chars "oO", Chars "mM"]

let kw_as = [%sedlex.regexp? Chars "aA", Chars "sS"]

let kw_true = [%sedlex.regexp? Chars "tT", Chars "rR", Chars "uU", Chars "eE"]

let kw_false =
  [%sedlex.regexp? Chars "fF", Chars "aA", Chars "lL", Chars "sS", Chars "eE"]

let kw_unknown =
  [%sedlex.regexp?
    ( Chars "uU"
    , Chars "nN"
    , Chars "kK"
    , Chars "nN"
    , Chars "oO"
    , Chars "wW"
    , Chars "nN" )]

let kw_null = [%sedlex.regexp? Chars "nN", Chars "uU", Chars "lL", Chars "lL"]

let space = [%sedlex.regexp? Plus (Chars " \t")]

let newline = [%sedlex.regexp? "\r\n" | "\n" | "\r"]

let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z' | 0x0153 .. 0xfffd]

let digit = [%sedlex.regexp? '0' .. '9']

let id_part =
  [%sedlex.regexp? ('@' | '#' | letter), Star (letter | '_' | digit)]

let quoted_id =
  [%sedlex.regexp? id_part | '"', Star ("\"\"" | Sub (any, '"')), '"']

let string =
  [%sedlex.regexp? Opt (Chars "EN"), "'", Star ("''" | Sub (any, "'")), "'"]

let escaped_type = [%sedlex.regexp? '{', "d" | "t" | "ts" | "b"]

let bin_string = [%sedlex.regexp? escaped_type, string, '}']

let rec token buf =
  match%sedlex buf with
  | kw_select -> Kw_select
  | kw_from -> Kw_from
  | kw_as -> Kw_as
  | kw_true -> Kw_true
  | kw_false -> Kw_false
  | kw_unknown -> Kw_unknown
  | kw_null -> Kw_null
  | '*' -> Tok_asterisk
  | '(' -> Tok_lparen
  | ')' -> Tok_rparen
  | '.' -> Tok_period
  | ',' -> Tok_comma
  | '+' -> Op_plus
  | '-' -> Op_minus
  | '*' -> Op_star
  | '/' -> Op_slash
  | "||" -> Op_concat
  | "&&" -> Op_double_amp
  | eof -> Tok_eof
  | string -> Tok_string (Sedlexing.Utf8.lexeme buf)
  | bin_string -> Tok_bin_string (Sedlexing.Utf8.lexeme buf)
  | quoted_id -> Tok_ident (Sedlexing.Utf8.lexeme buf)
  | space -> token buf
  | newline ->
    Sedlexing.new_line buf;
    token buf
  | _ -> failwith "Malformed source"
