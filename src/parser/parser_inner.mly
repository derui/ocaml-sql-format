%{
open Ast
%}

%token Tok_lparen
%token Tok_rparen
%token Tok_eof

(* keywords *)
%token <string> Kw_select
%token <string> Kw_from
%token <string> Kw_as
%token <string> Tok_ident

%start <Ast.statement list> statements

%%

statements:
  | list(expr); Tok_eof { [] }

expr:
  | Kw_select { Stmt_select }
