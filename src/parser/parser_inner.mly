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
%token Kw_is
%token Kw_between
%token Kw_like_regex
%token Kw_similar
%token Kw_to
%token Kw_escape
%token Kw_like
%token Kw_any
%token Kw_some
%token Kw_in

%token Tok_eof

%start <Ast.entry list> entries
%%

entries:
  | separated_nonempty_list(Tok_semicolon, entry) Tok_eof { $1 }

entry:
                 | directly_executable_statement { $1 }

directly_executable_statement:
                 | query_expression { `Directly_executable_statement ($1, ()) }

query_expression:
                 | query_expression_body { `Query_expression ([], $1, ()) }

                     (* A sub format to get terms in query_expression_body *)
sub_query_expression_body:
                 | Kw_union Kw_all query_term { (`Union, Some `All, $3) }
                 | Kw_union Kw_distinct query_term { (`Union, Some `Distinct, $3) }
                 | Kw_union query_term { (`Union, None, $2) }
                 | Kw_except Kw_all query_term { (`Except, Some `All, $3) }
                 | Kw_except Kw_distinct query_term { (`Except, Some `Distinct, $3) }
                 | Kw_except query_term { (`Except, None, $2) }

query_expression_body:
  | query_term; terms = list(sub_query_expression_body); order_by = option(order_by_clause);
    limit = option(limit_clause) {
                `Query_expression_body ({
                    term = $1;
                    terms;
                    order_by;
                    limit;
                  }, ())
              }

order_by_clause:
  | Kw_order Kw_by; list = separated_nonempty_list(Tok_comma, sort_specification) { `Order_by_clause (list, ()) }

sort_specification_order:
  | Kw_asc {`asc}
  | Kw_desc {`desc}

sort_specification_null:
  | Kw_null Kw_first {`null_first }
  | Kw_null Kw_last {`null_last}

sort_specification:
  | sort_key option(sort_specification_order) option(sort_specification_null) { `Sort_specification ($1, $2, $3, ())}

limit_clause:
  | Kw_limit; count =  integer_parameter {`Limit_clause (`limit {count; offset = None}, ())}
  | Kw_limit; count =  integer_parameter; Tok_comma; start =  integer_parameter {`Limit_clause (`limit {count; offset = Some(`comma start)}, ())}
  | Kw_limit; count =  integer_parameter; Kw_offset; start =  integer_parameter; {`Limit_clause (`limit {count; offset = Some (`keyword start)}, ())}
  | Kw_offset; start =  integer_parameter; rows = row; fetch = option(fetch_clause) {`Limit_clause (`offset ({start; fetch}, rows), ())}
  | fetch_clause {`Limit_clause (`fetch $1, ())}

fetch_clause:
  | Kw_fetch Kw_first; param = option(integer_parameter); rows = row; Kw_only {`Fetch_clause ({position = `first; param}, rows, ())}
  | Kw_fetch Kw_next; param = option(integer_parameter); rows = row; Kw_only {`Fetch_clause ({position = `next; param}, rows, ())}

integer_parameter:
  | Tok_unsigned_integer {`Integer_parameter (`unsigned_integer $1, ())}
  | unsigned_value_expression_primary {`Integer_parameter (`expression $1, ())}

row:
  | Kw_row {`row}
  | Kw_rows {`rows}

sort_key:
  | expression { `Sort_key ($1, ()) }

sub_query_term:
  | Kw_intersect query_primary { (None, $2) }
  | Kw_intersect Kw_all query_primary { (Some `All, $3) }
  | Kw_intersect Kw_distinct query_primary { (Some `Distinct, $3) }

query_term:
  | query_primary list(sub_query_term) { `Query_term ($1, $2, ()) }

query_primary:
  | query {`Query_primary ($1, ())}

query:
  | select_clause; into = option(into_clause); from = option(sub_select_clause) { `Query ($1, into, from, ()) }

select_clause:
  | Kw_select; select_list = select_list { `Select_clause (None, select_list,())}
  | Kw_select; Kw_all select_list = select_list { `Select_clause (Some `All, select_list, ()) }
  | Kw_select; Kw_distinct select_list = select_list { `Select_clause (Some `Distinct, select_list, ()) }

into_clause:
  | Kw_into identifier {`Into_clause ($2, ())}

sub_select_clause:
  | from_clause; where = option(where_clause); group_by = option(group_by_clause); having = option(having_clause) { `From_clause ({tables = $1; where; having; group_by}, ()) }

from_clause:
  | Kw_from separated_nonempty_list(Tok_comma, table_reference)  { $2 }

group_by_clause:
  | Kw_group Kw_by Kw_rollup Tok_lparen; exp = separated_nonempty_list(Tok_comma, expression); Tok_rparen { `Group_by_clause (`rollup exp, ()) }
  | Kw_group Kw_by; exp = separated_nonempty_list(Tok_comma, expression) { `Group_by_clause (`default exp, ()) }

having_clause:
  | Kw_having condition { `Having_clause ($2, ()) }

where_clause:
  | Kw_where condition { `Where_clause ($2, ()) }

      (* table reference *)
table_reference:
  | joined_table { `Table_reference ($1, ()) }

joined_table:
  | table_primary { `Joined_table ($1, ()) }

table_primary:
  | table_name { `Table_primary (`table_name $1, ()) }

table_name:
  | identifier option(Kw_as) identifier { ($1, Some $3) }
  | identifier { ($1, None) }
    (* end table reference *)

select_list:
  | Op_star { `asterisk }
  | separated_nonempty_list(Tok_comma, select_sublist) { `select_list $1 }

select_sublist:
  | Tok_all_in_group {`Select_sublist (`All_in_group $1, ())}
  | expression option(pair(option(Kw_as), identifier)) {
        let alias = match $2 with
          | None -> None
          | Some (_, ident) -> Some ident
        in
        `Select_sublist (`Derived_column ($1, alias), ()) }

expression:
  | condition { `Expression ($1, ())}

condition:
  | boolean_value_expression { `Condition ($1, ())}

(* boolean expression *)
boolean_value_expression:
  | separated_nonempty_list(Kw_or, boolean_term) { `Boolean_value_expression (List.hd $1, List.tl $1, ()) }

boolean_term:
  | separated_nonempty_list(Kw_and, boolean_factor) { `Boolean_term (List.hd $1, List.tl $1, ()) }

boolean_factor:
  | option(Kw_not) boolean_primary { match $1 with
                                     | None -> `Boolean_factor ($2, None, ())
                                     | Some _ -> `Boolean_factor ($2, Some `not', ())
      }

      (* 他のASTの実装も必要 *)
boolean_primary:
  | common_value_expression { `Boolean_primary ($1, None, ())}
  | common_value_expression comparison_predicate { `Boolean_primary ($1, Some (`comparison $2), ())}
  | common_value_expression is_null_predicate { `Boolean_primary ($1, Some (`is_null $2), ())}
  | common_value_expression between_predicate { `Boolean_primary ($1, Some (`between $2), ())}
  | common_value_expression like_regex_predicate { `Boolean_primary ($1, Some (`like_regex $2), ())}
  | common_value_expression match_predicate { `Boolean_primary ($1, Some (`match' $2), ())}
  | common_value_expression quantified_comparison_predicate { `Boolean_primary ($1, Some (`quantified $2), ())}
  | common_value_expression in_predicate { `Boolean_primary ($1, Some (`in' $2), ())}
  | common_value_expression is_distinct { `Boolean_primary ($1, Some (`is_distinct $2), ())}

in_predicate:
  | Kw_in q = subquery { `In_predicate (`query q, None,()) }
  | Kw_in Tok_lparen;l = separated_nonempty_list(Tok_comma, common_value_expression); Tok_rparen { `In_predicate (`values l, None, ()) }
  | Kw_not Kw_in q = subquery { `In_predicate (`query q, Some `not', ()) }
  | Kw_not Kw_in Tok_lparen; l = separated_nonempty_list(Tok_comma, common_value_expression); Tok_rparen { `In_predicate (`values l, Some `not', ()) }

subquery:
  | Tok_lparen; q = query_expression; Tok_rparen { `Subquery (`query q, ()) }

quantified_comparison_predicate:
  | comparison_operator Kw_any;  q = subquery  { `Quantified_comparison_predicate ($1, `any, `query q, ()) }
  | comparison_operator Kw_some;  q = subquery  { `Quantified_comparison_predicate ($1, `some, `query q, ()) }
  | comparison_operator Kw_all;  q = subquery  { `Quantified_comparison_predicate ($1, `all, `query q, ()) }
  | comparison_operator Kw_any Tok_lparen e = expression Tok_rparen { `Quantified_comparison_predicate ($1, `any, `expr e, ()) }
  | comparison_operator Kw_some Tok_lparen e = expression Tok_rparen { `Quantified_comparison_predicate ($1, `some, `expr e, ()) }
  | comparison_operator Kw_all Tok_lparen e = expression Tok_rparen { `Quantified_comparison_predicate ($1, `all, `expr e, ()) }

character:
  | Tok_string { `Character ($1, ())}

match_predicate_escape:
  | Kw_escape c = character { c }
  | Tok_lbrace Kw_escape c = character Tok_rbrace { c }

match_predicate:
  | Kw_like; e = common_value_expression; escape = option(match_predicate_escape) { `Match_predicate (`like, e, escape, None, ()) }
  | Kw_not Kw_like; e = common_value_expression; escape = option(match_predicate_escape) { `Match_predicate (`like, e, escape, Some `not', ()) }
  | Kw_similar Kw_to; e = common_value_expression; escape = option(match_predicate_escape) { `Match_predicate (`similar, e, escape, None, ()) }
  | Kw_not Kw_similar Kw_to; e = common_value_expression; escape = option(match_predicate_escape) { `Match_predicate (`similar, e, escape, Some `not', ()) }

like_regex_predicate:
  | Kw_like_regex; s = common_value_expression { `Like_regex_predicate (s, None, ()) }
  | Kw_not Kw_like_regex; s = common_value_expression { `Like_regex_predicate (s, Some `not', ()) }

between_predicate:
  | Kw_between; s = common_value_expression; Kw_and; e = common_value_expression { `Between_predicate (s, e,None, ()) }
  | Kw_not Kw_between; s = common_value_expression; Kw_and; e = common_value_expression { `Between_predicate (s, e, Some `not', ()) }

is_distinct:
  | Kw_is Kw_distinct Kw_from; s = common_value_expression { `Is_distinct (s, None, ()) }
  |  Kw_is Kw_not Kw_distinct Kw_from; s = common_value_expression { `Is_distinct (s, Some `not', ()) }

is_null_predicate:
  | Kw_is Kw_null { `Is_null_predicate (None, ()) }
  | Kw_is Kw_not Kw_null { `Is_null_predicate (Some `not', ()) }

comparison_predicate:
  | comparison_operator common_value_expression { `Comparison_predicate ($1, $2, ()) }

comparison_operator:
  | Op_eq { `Comparison_operator (`eq, ()) }
  | Op_ne { `Comparison_operator (`ne, ()) }
  | Op_ne2 { `Comparison_operator (`ne2, ()) }
  | Op_ge { `Comparison_operator (`ge, ()) }
  | Op_gt { `Comparison_operator (`gt, ()) }
  | Op_le { `Comparison_operator (`le, ()) }
  | Op_lt { `Comparison_operator (`lt, ()) }

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
  | numeric_value_expression list(pair(amp_or_concat, numeric_value_expression)) { `Common_value_expression ($1, $2, ()) }

numeric_value_expression:
  | term list(pair(plus_or_minus, term)) { `Numeric_value_expression ($1, $2, ()) }

term:
  | value_expression_primary list(pair(star_or_slash, value_expression_primary)) { `Term ($1, $2, ()) }

(* value expressions *)
value_expression_primary:
  | non_numeric_literal { `Value_expression_primary (`non_numeric_literal $1, ())}
  | option(plus_or_minus) unsigned_numeric_literal { `Value_expression_primary (`unsigned_numeric_literal ($1, $2), ()) }
  | unsigned_value_expression_primary list(delimited(Tok_lsbrace, numeric_value_expression, Tok_rsbrace)) { `Value_expression_primary (`unsigned_value_expression_primary ($1, $2), ()) }

unsigned_value_expression_primary:
  | Tok_qmark { `Unsigned_value_expression_primary (`parameter_qmark , ()) }
  | Tok_dollar Tok_unsigned_integer { `Unsigned_value_expression_primary (`parameter_dollar $2, ())  }
  | identifier { `Unsigned_value_expression_primary (`parameter_identifier $1, ()) }
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
  | Tok_string { `Non_numeric_literal (`string $1, ())}
  | Tok_typed_string {`Non_numeric_literal (`typed_string $1, ())}
  | Tok_bin_string {`Non_numeric_literal (`bin_string $1, ())}
  | Kw_date Tok_string {`Non_numeric_literal (`datetime_string (`date $2), ())}
  | Kw_time Tok_string {`Non_numeric_literal (`datetime_string (`time $2), ())}
  | Kw_timestamp Tok_string {`Non_numeric_literal (`datetime_string (`timestamp $2), ())}
  | Kw_true {`Non_numeric_literal (`TRUE, ()) }
  | Kw_false {`Non_numeric_literal (`FALSE, ()) }
  | Kw_unknown {`Non_numeric_literal (`UNKNOWN, ())}
  | Kw_null { `Non_numeric_literal (`NULL, ()) }

unsigned_numeric_literal:
  | Tok_unsigned_integer { `Unsigned_numeric_literal (`unsigned $1, ()) }
  | Tok_approximate_numeric { `Unsigned_numeric_literal (`approximate $1, ()) }
  | Tok_decimal_numeric { `Unsigned_numeric_literal (`decimal $1, ()) }

identifier:
  | Tok_ident { `Identifier ($1, ())}
