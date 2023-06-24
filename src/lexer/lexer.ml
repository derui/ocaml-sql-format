open Types.Token
module L = Types.Ast.Literal

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

let kw_table =
  [%sedlex.regexp? Chars "tT", Chars "aA", Chars "bB", Chars "lL", Chars "eE"]

let kw_lateral =
  [%sedlex.regexp?
    ( Chars "lL"
    , Chars "aA"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR"
    , Chars "aA"
    , Chars "lL" )]

let kw_left = [%sedlex.regexp? Chars "lL", Chars "eE", Chars "fF", Chars "tT"]

let kw_right =
  [%sedlex.regexp? Chars "rR", Chars "iI", Chars "gG", Chars "hH", Chars "tT"]

let kw_full = [%sedlex.regexp? Chars "fF", Chars "uU", Chars "lL", Chars "lL"]

let kw_outer =
  [%sedlex.regexp? Chars "oO", Chars "uU", Chars "tT", Chars "eE", Chars "rR"]

let kw_inner =
  [%sedlex.regexp? Chars "iI", Chars "nN", Chars "nN", Chars "eE", Chars "rR"]

let kw_cross =
  [%sedlex.regexp? Chars "cC", Chars "rR", Chars "oO", Chars "sS", Chars "sS"]

let kw_join = [%sedlex.regexp? Chars "jJ", Chars "oO", Chars "iI", Chars "nN"]

let kw_on = [%sedlex.regexp? Chars "oO", Chars "nN"]

let kw_case = [%sedlex.regexp? Chars "cC", Chars "aA", Chars "sS", Chars "eE"]

let kw_when = [%sedlex.regexp? Chars "wW", Chars "hH", Chars "eE", Chars "nN"]

let kw_then = [%sedlex.regexp? Chars "tT", Chars "hH", Chars "eE", Chars "nN"]

let kw_end = [%sedlex.regexp? Chars "eE", Chars "nN", Chars "dD"]

let kw_else = [%sedlex.regexp? Chars "eE", Chars "lL", Chars "sS", Chars "eE"]

let kw_textagg =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "eE"
    , Chars "xX"
    , Chars "tT"
    , Chars "aA"
    , Chars "gG"
    , Chars "gG" )]

let kw_for = [%sedlex.regexp? Chars "fF", Chars "oO", Chars "rR"]

let kw_delimiter =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "eE"
    , Chars "lL"
    , Chars "iI"
    , Chars "mM"
    , Chars "iI"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR" )]

let kw_quote =
  [%sedlex.regexp? Chars "qQ", Chars "uU", Chars "oO", Chars "tT", Chars "eE"]

let kw_no = [%sedlex.regexp? Chars "nN", Chars "oO"]

let kw_header =
  [%sedlex.regexp?
    Chars "hH", Chars "eE", Chars "aA", Chars "dD", Chars "eE", Chars "rR"]

let kw_encoding =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "nN"
    , Chars "cC"
    , Chars "oO"
    , Chars "dD"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_count =
  [%sedlex.regexp? Chars "cC", Chars "oO", Chars "uU", Chars "nN", Chars "tT"]

let kw_count_big =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "uU"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "bB"
    , Chars "iI"
    , Chars "gG" )]

let kw_sum = [%sedlex.regexp? Chars "sS", Chars "uU", Chars "mM"]

let kw_avg = [%sedlex.regexp? Chars "aA", Chars "vV", Chars "gG"]

let kw_min = [%sedlex.regexp? Chars "mM", Chars "iI", Chars "nN"]

let kw_max = [%sedlex.regexp? Chars "mM", Chars "aA", Chars "xX"]

let kw_every =
  [%sedlex.regexp? Chars "eE", Chars "vV", Chars "eE", Chars "rR", Chars "yY"]

let kw_stddev_pop =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "tT"
    , Chars "dD"
    , Chars "dD"
    , Chars "eE"
    , Chars "vV"
    , '_'
    , Chars "pP"
    , Chars "oO"
    , Chars "pP" )]

let kw_stddev_samp =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "tT"
    , Chars "dD"
    , Chars "dD"
    , Chars "eE"
    , Chars "vV"
    , '_'
    , Chars "sS"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP" )]

let kw_var_samp =
  [%sedlex.regexp?
    ( Chars "vV"
    , Chars "aA"
    , Chars "rR"
    , '_'
    , Chars "sS"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP" )]

let kw_var_pop =
  [%sedlex.regexp?
    Chars "vV", Chars "aA", Chars "rR", '_', Chars "pP", Chars "oO", Chars "pP"]

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
  | kw_table -> Kw_table
  | kw_lateral -> Kw_lateral
  | kw_left -> Kw_left
  | kw_right -> Kw_right
  | kw_full -> Kw_full
  | kw_outer -> Kw_outer
  | kw_inner -> Kw_inner
  | kw_cross -> Kw_cross
  | kw_join -> Kw_join
  | kw_on -> Kw_on
  | kw_case -> Kw_case
  | kw_when -> Kw_when
  | kw_then -> Kw_then
  | kw_end -> Kw_end
  | kw_else -> Kw_else
  | kw_textagg -> Kw_textagg
  | kw_for -> Kw_for
  | kw_delimiter -> Kw_delimiter
  | kw_quote -> Kw_quote
  | kw_no -> Kw_no
  | kw_header -> Kw_header
  | kw_encoding -> Kw_encoding
  | kw_count -> Kw_count
  | kw_count_big -> Kw_count_big
  | kw_avg -> Kw_avg
  | kw_sum -> Kw_sum
  | kw_min -> Kw_min
  | kw_max -> Kw_max
  | kw_every -> Kw_every
  | kw_stddev_pop -> Kw_stddev_pop
  | kw_stddev_samp -> Kw_stddev_samp
  | kw_var_samp -> Kw_var_samp
  | kw_var_pop -> Kw_var_pop
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
