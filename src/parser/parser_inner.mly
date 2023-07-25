%{
open Types.Ast
open Types.Literal
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
%token Op_plus
%token Op_minus
%token Op_star
%token Op_slash
%token Op_double_amp
%token Op_concat
%token Op_eq
%token Op_ge
%token Op_gt
%token Op_le
%token Op_lt
%token Op_ne
%token Op_ne2
%token Op_dereference

(* keywords *)
%token Kw_null
%token Kw_true
%token Kw_false
%token Kw_current_date
%token Kw_current_time
%token Kw_current_timestamp

%token Tok_eof

%start <Types.Statement.t list> statements

%%

statements:
  | v = separated_nonempty_list(Tok_semicolon, entry) Tok_eof { [] }
;;

entry:
                 | { }
;;

literal_value:
  | v = numeric_literal { Literal_value (`numeric v, ())}
  | v = string_literal { Literal_value (`string v, ())}
  | v = blob_literal { Literal_value (`blob v, ())}
  | Kw_null { Literal_value (`null, ()) }
  | Kw_true { Literal_value (`true', ()) }
  | Kw_false { Literal_value (`false', ()) }
  | Kw_current_date { Literal_value (`current_date, ()) }
  | Kw_current_time { Literal_value (`current_time, ()) }
  | Kw_current_timestamp { Literal_value (`current_timestamp, ()) }
;;
numeric_literal:
  | v = Tok_numeric { Numeric_literal (v, ()) }
;;
string_literal:
  | v = Tok_string { String_literal (v, ()) }
;;
blob_literal:
  | v = Tok_blob { Blob_literal (v, ()) }
;;

bind_parameter:
| Tok_qmark {Bind_parameter ()}
;;
