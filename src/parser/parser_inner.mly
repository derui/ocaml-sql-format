%{
open Ast
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
%token <string> Tok_ident
%token <string> Tok_string
%token <string> Tok_typed_string
%token <string> Tok_bin_string
%token <string> Tok_all_in_group
%token <Literal.unsigned_integer> Tok_unsigned_integer
%token <Literal.approximate_numeric> Tok_approximate_numeric
%token <Literal.decimal_numeric> Tok_decimal_numeric

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

(* keywords *)
%token Kw_select
%token Kw_from
%token Kw_as
%token Kw_distinct
%token Kw_all
%token Kw_true
%token Kw_false
%token Kw_unknown
%token Kw_null
%token Kw_date
%token Kw_time
%token Kw_timestamp
%token Kw_into
%token Kw_or
%token Kw_not
%token Kw_and
%token Kw_union
%token Kw_except
%token Kw_intersect
%token Kw_group
%token Kw_by
%token Kw_rollup
%token Kw_having
%token Kw_where
%token Kw_order
%token Kw_asc
%token Kw_desc
%token Kw_first
%token Kw_last
%token Kw_limit
%token Kw_offset
%token Kw_row
%token Kw_rows
%token Kw_fetch
%token Kw_next
%token Kw_only

%token Tok_eof

%start <Ast.entry list> entries
%%

entries:
  | separated_nonempty_list(Tok_semicolon, entry) Tok_eof { $1 }

entry:
                 | directly_executable_statement { Directly_executable_statement $1 }

directly_executable_statement:
                 | query_expression { Query_expression $1 }

query_expression:
                 | query_expression_body { {with_list = []; body = $1} }


sub_query_expression_body:
                 | joiner option(set_qualifier) query_term { ($1, $2, $3) }

query_expression_body:
  | query_term; terms = list(sub_query_expression_body); order_by = option(order_by_clause);
    limit = option(limit_clause) {
                Query_expression_body {
                    term = $1;
                    terms;
                    order_by;
                    limit;
                  }
              }

order_by_clause:
  | Kw_order Kw_by; list = separated_nonempty_list(Tok_comma, sort_specification) { Order_by_clause list }

sort_specification_order:
  | Kw_asc {`asc}
  | Kw_desc {`desc}

sort_specification_null:
  | Kw_null Kw_first {`null_first }
  | Kw_null Kw_last {`null_last}

sort_specification:
  | sort_key option(sort_specification_order) option(sort_specification_null) { Sort_specification {key = $1;
                                                                                                 order = $2;
                                                                                                 null_order = $3
      } }

limit_clause:
  | Kw_limit; count =  integer_parameter {Limit_clause_limit {count; offset = None}}
  | Kw_limit; count =  integer_parameter; Tok_comma; start =  integer_parameter {Limit_clause_limit {count; offset = Some(`comma start)}}
  | Kw_limit; count =  integer_parameter; Kw_offset; start =  integer_parameter; {Limit_clause_limit {count; offset = Some (`keyword start)}}
  | Kw_offset; start =  integer_parameter; rows = row; fetch = option(fetch_clause) {Limit_clause_offset {start; rows; fetch}}
  | fetch_clause {Limit_clause_fetch $1}

fetch_clause:
  | Kw_fetch Kw_first; param = option(integer_parameter); rows = row; Kw_only {Fetch_clause {position = `first; param; rows}}
  | Kw_fetch Kw_next; param = option(integer_parameter); rows = row; Kw_only {Fetch_clause {position = `next; param; rows}}

integer_parameter:
  | Tok_unsigned_integer {`unsigned_integer $1}
  | unsigned_value_expression_primary {`expression $1}

row:
  | Kw_row {`row}
  | Kw_rows {`rows}

sort_key:
  | expression { $1 }

sub_query_term:
  | Kw_intersect option(set_qualifier) query_primary { ($2, $3) }

query_term:
  | query_primary list(sub_query_term) { ($1, $2) }

query_primary:
  | query {Query $1}

query:
  | select_clause; into = option(into_clause); from = option(sub_select_clause) { {clause = $1; into; from } }

select_clause:
  | Kw_select; qualifier = option(set_qualifier); select_list = select_list { {qualifier; select_list} }

into_clause:
  | Kw_into identifier {Ast.Into_clause $2}

sub_select_clause:
  | from_clause; where = option(where_clause); group_by = option(group_by_clause); having = option(having_clause) { {tables = $1; where; having; group_by} }

from_clause:
  | Kw_from separated_nonempty_list(Tok_comma, table_reference)  { $2 }

group_by_clause:
  | Kw_group Kw_by Kw_rollup Tok_lparen; exp = separated_nonempty_list(Tok_comma, expression); Tok_rparen { Group_by_clause (`rollup exp) }
  | Kw_group Kw_by; exp = separated_nonempty_list(Tok_comma, expression) { Group_by_clause (`default exp) }

having_clause:
  | Kw_having condition { Having_clause $2 }

where_clause:
  | Kw_where condition { Where_clause $2 }

      (* table reference *)
table_reference:
  | joined_table { Joined_table $1 }

joined_table:
  | table_primary { $1 }

table_primary:
  | table_name { `table_name $1 }

table_name:
  | identifier option(Kw_as) identifier { ($1, Some $3) }
  | identifier { ($1, None) }
    (* end table reference *)

select_list:
  | Op_star { `asterisk }
  | separated_nonempty_list(Tok_comma, select_sublist) { `select_list $1 }

set_qualifier:
  | Kw_distinct {Ast.Distinct}
  | Kw_all { Ast.All }

joiner:
  | Kw_union {Ast.Union}
  | Kw_except { Ast.Except }

select_sublist:
  | Tok_all_in_group {Ast.All_in_group $1}
  | expression option(pair(option(Kw_as), identifier)) {
        let alias = match $2 with
          | None -> None
          | Some (_, ident) -> Some ident in
        Ast.Select_derived_column {exp = $1; alias} }

expression:
  | condition {$1}

condition:
  | boolean_value_expression {$1}

(* boolean expression *)
boolean_value_expression:
  | separated_nonempty_list(Kw_or, boolean_term) { (List.hd $1, List.tl $1) }

boolean_term:
  | separated_nonempty_list(Kw_and, boolean_factor) { (List.hd $1, List.tl $1) }

boolean_factor:
  | option(Kw_not) boolean_primary { match $1 with
                                     | None -> `Normal $2
                                     | Some _ -> `Not $2}

      (* 他のASTの実装も必要 *)
boolean_primary:
  | common_value_expression { Boolean_primary {value = $1}}

      (* common value expression *)
amp_or_concat:
  | Op_double_amp { `amp }
  | Op_concat { `concat }

plus_or_minus:
  | Op_minus { `minus }
  | Op_plus { `plus }

star_or_slash:
  | Op_star {`star}
  | Op_slash {`slash}

common_value_expression:
  | numeric_value_expression list(pair(amp_or_concat, numeric_value_expression)) {($1, $2) }

numeric_value_expression:
  | term list(pair(plus_or_minus, term)) { ($1, $2) }

term:
  | value_expression_primary list(pair(star_or_slash, value_expression_primary)) { ($1, $2) }

(* value expressions *)
value_expression_primary:
  | non_numeric_literal {Ast.Non_numeric_literal $1}
  | option(plus_or_minus) unsigned_numeric_literal { Ast.Unsigned_numeric_literal ($1, $2) }
  | unsigned_value_expression_primary list(delimited(Tok_lsbrace, numeric_value_expression, Tok_rsbrace)) { Unsigned_value_expression_primary {exp = $1; indices = $2} }

unsigned_value_expression_primary:
  | Tok_qmark { `parameter_qmark  }
  | Tok_dollar Tok_unsigned_integer { `parameter_dollar $2  }
  | identifier { `identifier $1 }
      (* need implementation:
         - escaped function
         - unescaped Function
         - subquery
         - nested expression
         - array expression constructor
         - searched case expression
         - case expression
       *)
      (* end value expressions *)

      (* literals *)
non_numeric_literal:
  | Tok_string {`string $1}
  | Tok_typed_string {`typed_string $1}
  | Kw_date Tok_string {`datetime_string (`date $2)}
  | Kw_time Tok_string {`datetime_string (`time $2)}
  | Kw_timestamp Tok_string {`datetime_string (`timestamp $2)}
  | Kw_true {`TRUE }
  | Kw_false {`FALSE }
  | Kw_unknown {`UNKNOWN}
  | Kw_null {`NULL }

unsigned_numeric_literal:
  | Tok_unsigned_integer { `unsigned $1 }
  | Tok_approximate_numeric { `approximate $1 }
  | Tok_decimal_numeric { `decimal $1 }

identifier:
  | Tok_ident {Ast.Ident $1}
