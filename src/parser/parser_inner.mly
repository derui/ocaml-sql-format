%{
open Ast
%}

%token Tok_lparen
%token Tok_rparen
%token Tok_asterisk
%token Tok_period
%token Tok_comma
%token <string> Tok_ident

(* operators *)
%token Op_plus
%token Op_minus
%token Op_star
%token Op_slash
%token Op_double_amp
%token Op_concat

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
  | separated_nonempty_list(Tok_comma, select_sublist) { Ast.Sl_sublists $1 }

as_clause:
  | Kw_as identifier { $2 }

set_qualifier:
  | Kw_distinct {Ast.Distinct}
  | Kw_all { Ast.All }

select_sublist:
  | first = separated_nonempty_list(Tok_period, identifier);Tok_period Tok_asterisk {Ast.Ss_qualified_asterisk first}
  | value_expression option(as_clause) { Ast.Ss_derived_column {exp = $1; as_clause = $2} }

(* value expressions *)
value_expression:
  | value_expression_primary { $1 }

value_expression_primary:
  | Tok_lparen value_expression Tok_rparen {Ast.Exp_parenthesized $2}
  | separated_nonempty_list(Tok_period, identifier) {Ast.Exp_nonparenthesized ( Ast.Vep_column $1 )}

      (* end value expressions *)

identifier:
  | Tok_ident {Ast.Ident $1}
