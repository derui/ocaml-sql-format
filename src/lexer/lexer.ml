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

let kw_and = [%sedlex.regexp? Chars "aA", Chars "nN", Chars "dD"]

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

let kw_into = [%sedlex.regexp? Chars "iI", Chars "nN", Chars "tT", Chars "oO"]

let kw_or = [%sedlex.regexp? Chars "oO", Chars "rR"]

let kw_group =
  [%sedlex.regexp? Chars "gG", Chars "rR", Chars "oO", Chars "uU", Chars "pP"]

let kw_rollup =
  [%sedlex.regexp?
    Chars "rR", Chars "oO", Chars "lL", Chars "lL", Chars "uU", Chars "pP"]

let kw_having =
  [%sedlex.regexp?
    Chars "hH", Chars "aA", Chars "vV", Chars "iI", Chars "nN", Chars "gG"]

let kw_where =
  [%sedlex.regexp? Chars "wW", Chars "hH", Chars "eE", Chars "rR", Chars "eE"]

let kw_by = [%sedlex.regexp? Chars "bB", Chars "yY"]

let kw_order =
  [%sedlex.regexp? Chars "oO", Chars "rR", Chars "dD", Chars "eE", Chars "rR"]

let kw_asc = [%sedlex.regexp? Chars "aA", Chars "sS", Chars "cC"]

let kw_desc = [%sedlex.regexp? Chars "dD", Chars "eE", Chars "sS", Chars "cC"]

let kw_first =
  [%sedlex.regexp? Chars "fF", Chars "iI", Chars "rR", Chars "sS", Chars "tT"]

let kw_last = [%sedlex.regexp? Chars "lL", Chars "aA", Chars "sS", Chars "tT"]

let kw_limit =
  [%sedlex.regexp? Chars "lL", Chars "iI", Chars "mM", Chars "iI", Chars "tT"]

let kw_offset =
  [%sedlex.regexp?
    Chars "oO", Chars "fF", Chars "fF", Chars "sS", Chars "eE", Chars "tT"]

let kw_row = [%sedlex.regexp? Chars "rR", Chars "oO", Chars "wW"]

let kw_rows = [%sedlex.regexp? Chars "rR", Chars "oO", Chars "wW", Chars "sS"]

let kw_fetch =
  [%sedlex.regexp? Chars "fF", Chars "eE", Chars "tT", Chars "cC", Chars "hH"]

let kw_next = [%sedlex.regexp? Chars "nN", Chars "eE", Chars "xX", Chars "tT"]

let kw_only = [%sedlex.regexp? Chars "oO", Chars "nN", Chars "lL", Chars "yY"]

let kw_all = [%sedlex.regexp? Chars "aA", Chars "lL", Chars "lL"]

let kw_distinct =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "iI"
    , Chars "sS"
    , Chars "tT"
    , Chars "iI"
    , Chars "nN"
    , Chars "cC"
    , Chars "tT" )]

let kw_is = [%sedlex.regexp? Chars "iI", Chars "sS"]

let kw_between =
  [%sedlex.regexp?
    ( Chars "bB"
    , Chars "eE"
    , Chars "tT"
    , Chars "wW"
    , Chars "eE"
    , Chars "eE"
    , Chars "nN" )]

let kw_like_regex =
  [%sedlex.regexp?
    ( Chars "lL"
    , Chars "iI"
    , Chars "kK"
    , Chars "eE"
    , '_'
    , Chars "rR"
    , Chars "eE"
    , Chars "gG"
    , Chars "eE"
    , Chars "xX" )]

let kw_similar =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "iI"
    , Chars "mM"
    , Chars "iI"
    , Chars "lL"
    , Chars "aA"
    , Chars "rR" )]

let kw_to = [%sedlex.regexp? Chars "tT", Chars "oO"]

let kw_escape =
  [%sedlex.regexp?
    Chars "eE", Chars "sS", Chars "cC", Chars "aA", Chars "pP", Chars "eE"]

let kw_like = [%sedlex.regexp? Chars "lL", Chars "iI", Chars "kK", Chars "eE"]

let kw_any = [%sedlex.regexp? Chars "aA", Chars "nN", Chars "yY"]

let kw_some = [%sedlex.regexp? Chars "sS", Chars "oO", Chars "mM", Chars "eE"]

let kw_in = [%sedlex.regexp? Chars "iI", Chars "nN"]

let kw_exists =
  [%sedlex.regexp?
    Chars "eE", Chars "xX", Chars "iI", Chars "sS", Chars "tT", Chars "sS"]

let kw_with = [%sedlex.regexp? Chars "wW", Chars "iI", Chars "tT", Chars "hH"]

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
  | kw_and -> Kw_and
  | kw_group -> Kw_group
  | kw_by -> Kw_by
  | kw_rollup -> Kw_rollup
  | kw_having -> Kw_having
  | kw_where -> Kw_where
  | kw_order -> Kw_order
  | kw_asc -> Kw_asc
  | kw_desc -> Kw_desc
  | kw_first -> Kw_first
  | kw_last -> Kw_last
  | kw_limit -> Kw_limit
  | kw_offset -> Kw_offset
  | kw_row -> Kw_row
  | kw_rows -> Kw_rows
  | kw_fetch -> Kw_fetch
  | kw_next -> Kw_next
  | kw_only -> Kw_only
  | kw_all -> Kw_all
  | kw_distinct -> Kw_distinct
  | kw_is -> Kw_is
  | kw_between -> Kw_between
  | kw_like_regex -> Kw_like_regex
  | kw_similar -> Kw_similar
  | kw_to -> Kw_to
  | kw_escape -> Kw_escape
  | kw_like -> Kw_like
  | kw_any -> Kw_any
  | kw_some -> Kw_some
  | kw_in -> Kw_in
  | kw_exists -> Kw_exists
  | kw_with -> Kw_with
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
