open Parser.Token
include Printer_intf

let as_keyword original = function
  | `Upper -> String.uppercase_ascii original
  | `Lower -> String.lowercase_ascii original

include (
  struct
    type t = token

    let print f t ~option:{ Options.keyword; _ } =
      let module L = Parser.Ast.Literal in
      match t with
      | Kw_all -> Fmt.string f @@ as_keyword "all" keyword
      | Kw_select -> Fmt.string f @@ as_keyword "select" keyword
      | Kw_as -> Fmt.string f @@ as_keyword "as" keyword
      | Kw_from -> Fmt.string f @@ as_keyword "from" keyword
      | Kw_distinct -> Fmt.string f @@ as_keyword "distinct" keyword
      | Kw_true -> Fmt.string f @@ as_keyword "true" keyword
      | Kw_false -> Fmt.string f @@ as_keyword "false" keyword
      | Kw_unknown -> Fmt.string f @@ as_keyword "unknown" keyword
      | Kw_null -> Fmt.string f @@ as_keyword "null" keyword
      | Kw_date -> Fmt.string f @@ as_keyword "date" keyword
      | Kw_time -> Fmt.string f @@ as_keyword "time" keyword
      | Kw_timestamp -> Fmt.string f @@ as_keyword "timestamp" keyword
      | Kw_or -> Fmt.string f @@ as_keyword "or" keyword
      | Kw_not -> Fmt.string f @@ as_keyword "not" keyword
      | Kw_and -> Fmt.string f @@ as_keyword "and" keyword
      | Kw_into -> Fmt.string f @@ as_keyword "into" keyword
      | Kw_union -> Fmt.string f @@ as_keyword "union" keyword
      | Kw_except -> Fmt.string f @@ as_keyword "except" keyword
      | Kw_intersect -> Fmt.string f @@ as_keyword "intersect" keyword
      | Kw_by -> Fmt.string f @@ as_keyword "by" keyword
      | Kw_group -> Fmt.string f @@ as_keyword "group" keyword
      | Kw_rollup -> Fmt.string f @@ as_keyword "rollup" keyword
      | Kw_having -> Fmt.string f @@ as_keyword "having" keyword
      | Kw_where -> Fmt.string f @@ as_keyword "where" keyword
      | Kw_order -> Fmt.string f @@ as_keyword "order" keyword
      | Kw_asc -> Fmt.string f @@ as_keyword "asc" keyword
      | Kw_desc -> Fmt.string f @@ as_keyword "desc" keyword
      | Kw_first -> Fmt.string f @@ as_keyword "first" keyword
      | Kw_last -> Fmt.string f @@ as_keyword "last" keyword
      | Kw_limit -> Fmt.string f @@ as_keyword "limit" keyword
      | Kw_offset -> Fmt.string f @@ as_keyword "offset" keyword
      | Kw_row -> Fmt.string f @@ as_keyword "row" keyword
      | Kw_rows -> Fmt.string f @@ as_keyword "rows" keyword
      | Kw_fetch -> Fmt.string f @@ as_keyword "fetch" keyword
      | Kw_next -> Fmt.string f @@ as_keyword "next" keyword
      | Kw_only -> Fmt.string f @@ as_keyword "only" keyword
      | Tok_lparen -> Fmt.string f "("
      | Tok_rparen -> Fmt.string f ")"
      | Tok_ident v -> Fmt.string f v
      | Tok_all_in_group v -> Fmt.string f v
      | Tok_string v -> Fmt.string f v
      | Tok_typed_string v -> Fmt.string f v
      | Tok_bin_string v -> Fmt.string f v
      | Tok_unsigned_integer (L.Unsigned_integer v) -> Fmt.string f v
      | Tok_approximate_numeric (L.Approximate_numeric v) -> Fmt.string f v
      | Tok_decimal_numeric (L.Decimal_numeric v) -> Fmt.string f v
      | Tok_period -> Fmt.string f "."
      | Tok_comma -> Fmt.string f ","
      | Tok_colon -> Fmt.string f ":"
      | Tok_dollar -> Fmt.string f "$"
      | Tok_lbrace -> Fmt.string f "{"
      | Tok_rbrace -> Fmt.string f "}"
      | Tok_lsbrace -> Fmt.string f "["
      | Tok_rsbrace -> Fmt.string f "]"
      | Tok_qmark -> Fmt.string f "?"
      | Tok_semicolon -> Fmt.string f ";"
      | Op_plus -> Fmt.string f "+"
      | Op_minus -> Fmt.string f "-"
      | Op_star -> Fmt.string f "*"
      | Op_slash -> Fmt.string f "/"
      | Op_concat -> Fmt.string f "||"
      | Op_double_amp -> Fmt.string f "&&"
      | Op_eq -> Fmt.string f "="
      | Op_ge -> Fmt.string f ">="
      | Op_gt -> Fmt.string f ">"
      | Op_le -> Fmt.string f "<="
      | Op_lt -> Fmt.string f "<"
      | Op_ne -> Fmt.string f "<>"
      | Op_ne2 -> Fmt.string f "!="
      | Tok_eof -> failwith "Can not stringify EOF"
  end :
    S with type t = token)
