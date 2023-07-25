%{
open Types.Ast
open Types.Literal
open Types.Token

let is_kw kw = function
  | `keyword kw' -> kw = kw'
  | `raw _ -> false

exception Invalid_token of token
%}

%token Tok_lparen
%token Tok_rparen
%token Tok_period
%token Tok_comma
%token Tok_colon
%token Tok_dollar
%token Tok_lbrace
%token Tok_rbrace
%token Tok_lsbrace
%token Tok_rsbrace
%token Tok_qmark
%token Tok_semicolon
%token Tok_quote
%token <string> Tok_ident
%token <string> Tok_string
%token <string> Tok_blob
%token <string> Tok_numeric

(* operators *)
(* %token Op_plus *)
(* %token Op_minus *)
(* %token Op_star *)
(* %token Op_slash *)
(* %token Op_double_amp *)
(* %token Op_concat *)
(* %token Op_eq *)
(* %token Op_ge *)
(* %token Op_gt *)
(* %token Op_le *)
(* %token Op_lt *)
(* %token Op_ne *)
(* %token Op_ne2 *)
(* %token Op_dereference *)

%token Tok_eof

%start <Types.Statement.t list> statements

%%

statements:
  | v = separated_nonempty_list(Tok_semicolon, entry) Tok_eof { [] }
;;

entry:
                 | { }
;;

let identifier := Tok_ident

let literal_value :=
  | v = numeric_literal; { Literal_value (`numeric v, ())}
  | v = string_literal; { Literal_value (`string v, ())}
  | v = blob_literal; { Literal_value (`blob v, ())}
  | v = identifier; { match v with
                      | Tok_ident (`keyword Kw_null) -> Literal_value (`null, ())
                      | Tok_ident (`keyword Kw_true) -> Literal_value (`true', ())
                      | Tok_ident (`keyword Kw_false) -> Literal_value (`false', ())
                      | Tok_ident (`keyword Kw_current_date) -> Literal_value (`current_date, ())
                      | Tok_ident (`keyword Kw_current_time) -> Literal_value (`current_time, ())
                      | Tok_ident (`keyword Kw_current_timestamp) -> Literal_value (`current_timestamp, ())
                      | _ -> raise Invalid_token
                    }

let numeric_literal :=
  | v = Tok_numeric; { Numeric_literal (v, ()) }

let string_literal :=
  | v = Tok_string ;{ String_literal (v, ()) }

let blob_literal :=
  | v = Tok_blob; { Blob_literal (v, ()) }

let bind_parameter :=
| Tok_qmark; {Bind_parameter ()}
