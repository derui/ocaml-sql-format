%{
open Ast
%}

%token Tok_lparen
%token Tok_rparen
%token Tok_asterisk
%token <string> Tok_ident

(* keywords *)
%token <string> Kw_select
%token <string> Kw_from
%token <string> Kw_as
%token <string> Kw_distinct
%token <string> Kw_all

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
