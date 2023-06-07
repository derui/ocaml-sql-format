open Parser.Token
include Printer_intf

let as_keyword original = function
  | `Upper -> String.uppercase_ascii original
  | `Lower -> String.lowercase_ascii original

include (
  struct
    type t = token

    let print f t ~option:{ Options.keyword; _ } =
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
      | Tok_asterisk -> Fmt.string f "*"
      | Tok_lparen -> Fmt.string f "("
      | Tok_rparen -> Fmt.string f ")"
      | Tok_ident v -> Fmt.string f v
      | Tok_string v -> Fmt.string f v
      | Tok_bin_string v -> Fmt.string f v
      | Tok_period -> Fmt.string f "."
      | Tok_comma -> Fmt.string f ","
      | Op_plus -> Fmt.string f "+"
      | Op_minus -> Fmt.string f "-"
      | Op_star -> Fmt.string f "*"
      | Op_slash -> Fmt.string f "/"
      | Op_concat -> Fmt.string f "||"
      | Op_double_amp -> Fmt.string f "&&"
      | Tok_eof -> failwith "Can not stringify EOF"
  end :
    S with type t = token)
