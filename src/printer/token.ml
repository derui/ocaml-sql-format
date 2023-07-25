open Types.Token
open Intf

include (
  struct
    type t = token

    let print f t ~option =
      match t with
      (* 'token *)
      | Tok_lparen -> Fmt.string f "("
      | Tok_rparen -> Fmt.string f ")"
      | Tok_ident v -> (
        match v with
        | `keyword v -> Keyword.print ~option f v
        | `raw v -> Fmt.string f v)
      | Tok_string v -> Fmt.string f v
      | Tok_numeric v -> Fmt.string f v
      | Tok_blob v -> Fmt.string f v
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
      | Tok_quote -> Fmt.string f "'"
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
      | Op_dereference -> Fmt.string f "->"
      | Tok_eof -> failwith "Can not stringify EOF"
  end :
    PRINTER with type t = token)
