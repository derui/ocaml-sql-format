%{
open Ast
%}

%token Tok_lparen
%token Tok_rparen
%token Tok_asterisk
%token <string> Tok_ident

(* keywords *)
%token Kw_select
%token Kw_from
%token Kw_as
%token Kw_distinct
%token Kw_all

%token Tok_eof

%start <Ast.statement list> statements

%%

statements:
  | list(statement); Tok_eof { $1 }

statement:
  | Kw_select; qualifier = option(set_qualifier); select_list = select_list { Stmt_select {qualifier; select_list} }

select_list:
  | Tok_asterisk { Ast.Sl_asterisk }

set_qualifier:
  | Kw_distinct {Ast.Distinct}
  | Kw_all { Ast.All }
