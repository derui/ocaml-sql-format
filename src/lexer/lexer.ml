open Parser.Token
module L = Parser.Ast.Literal

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

let kw_date = [%sedlex.regexp? Chars "dD", Chars "aA", Chars "tT", Chars "eE"]

let kw_time = [%sedlex.regexp? Chars "tT", Chars "iI", Chars "mM", Chars "eE"]

let kw_timestamp =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "iI"
    , Chars "mM"
    , Chars "eE"
    , Chars "sS"
    , Chars "tT"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP" )]

let kw_into = [%sedlex.regexp? Chars "iI", Chars "nN", Chars "tT", Chars "oO"]

let kw_or = [%sedlex.regexp? Chars "oO", Chars "rR"]

let kw_not = [%sedlex.regexp? Chars "nN", Chars "oO", Chars "tT"]

let kw_union =
  [%sedlex.regexp? Chars "uU", Chars "nN", Chars "iI", Chars "oO", Chars "nN"]

let kw_except =
  [%sedlex.regexp?
    Chars "eE", Chars "xX", Chars "cC", Chars "eE", Chars "pP", Chars "tT"]

let kw_intersect =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "nN"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR"
    , Chars "sS"
    , Chars "eE"
    , Chars "cC"
    , Chars "tT" )]

let space = [%sedlex.regexp? Plus (Chars " \t")]

let newline = [%sedlex.regexp? "\r\n" | "\n" | "\r"]

let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z' | 0x0153 .. 0xfffd]

let digit = [%sedlex.regexp? '0' .. '9']

let unsigned_integer = [%sedlex.regexp? Plus digit]

let approximate_numeric =
  [%sedlex.regexp?
    digit, '.', unsigned_integer, Chars "eE", Opt (Chars "+-"), unsigned_integer]

let decimal_numeric = [%sedlex.regexp? Star digit, '.', unsigned_integer]

let id_part =
  [%sedlex.regexp? ('@' | '#' | letter), Star (letter | '_' | digit)]

let quoted_id =
  [%sedlex.regexp? id_part | '"', Star ("\"\"" | Sub (any, '"')), '"']

let identifier = [%sedlex.regexp? quoted_id, Star ('.', quoted_id)]

let all_in_group = [%sedlex.regexp? identifier, '.', '*']

let string =
  [%sedlex.regexp? Opt (Chars "EN"), "'", Star ("''" | Sub (any, "'")), "'"]

let escaped_type = [%sedlex.regexp? '{', "d" | "t" | "ts" | "b"]

let typed_string = [%sedlex.regexp? escaped_type, string, '}']

let hexit = [%sedlex.regexp? 'a' .. 'f' | 'A' .. 'F' | '0' .. '9']

let bin_string = [%sedlex.regexp? Chars "xX", '"', Star (hexit, hexit), '"']

let rec token buf =
  match%sedlex buf with
  | kw_select -> Kw_select
  | kw_from -> Kw_from
  | kw_as -> Kw_as
  | kw_true -> Kw_true
  | kw_false -> Kw_false
  | kw_unknown -> Kw_unknown
  | kw_null -> Kw_null
  | kw_date -> Kw_date
  | kw_time -> Kw_time
  | kw_timestamp -> Kw_timestamp
  | kw_into -> Kw_into
  | kw_or -> Kw_or
  | kw_not -> Kw_not
  | kw_union -> Kw_union
  | kw_except -> Kw_except
  | kw_intersect -> Kw_intersect
  | '(' -> Tok_lparen
  | ')' -> Tok_rparen
  | '.' -> Tok_period
  | ',' -> Tok_comma
  | ':' -> Tok_colon
  | '$' -> Tok_dollar
  | '{' -> Tok_lbrace
  | '}' -> Tok_rbrace
  | '[' -> Tok_lsbrace
  | ']' -> Tok_rsbrace
  | '?' -> Tok_qmark
  | ';' -> Tok_semicolon
  | '+' -> Op_plus
  | '-' -> Op_minus
  | '*' -> Op_star
  | '/' -> Op_slash
  | "||" -> Op_concat
  | "&&" -> Op_double_amp
  | '=' -> Op_eq
  | ">=" -> Op_ge
  | '>' -> Op_gt
  | "<=" -> Op_le
  | '<' -> Op_lt
  | "<>" -> Op_ne
  | "!=" -> Op_ne2
  | eof -> Tok_eof
  | string -> Tok_string (Sedlexing.Utf8.lexeme buf)
  | typed_string -> Tok_typed_string (Sedlexing.Utf8.lexeme buf)
  | bin_string -> Tok_bin_string (Sedlexing.Utf8.lexeme buf)
  | all_in_group -> Tok_all_in_group (Sedlexing.Utf8.lexeme buf)
  | identifier -> Tok_ident (Sedlexing.Utf8.lexeme buf)
  | unsigned_integer ->
    Tok_unsigned_integer (L.Unsigned_integer (Sedlexing.Utf8.lexeme buf))
  | approximate_numeric ->
    Tok_approximate_numeric (L.Approximate_numeric (Sedlexing.Utf8.lexeme buf))
  | decimal_numeric ->
    Tok_decimal_numeric (L.Decimal_numeric (Sedlexing.Utf8.lexeme buf))
  | space -> token buf
  | newline ->
    Sedlexing.new_line buf;
    token buf
  | _ -> failwith "Malformed source"
