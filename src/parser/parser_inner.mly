%{
open Types.Ast
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
%token Kw_exists
%token Kw_with
%token Kw_table
%token Kw_lateral
%token Kw_left
%token Kw_right
%token Kw_full
%token Kw_outer
%token Kw_inner
%token Kw_cross
%token Kw_join
%token Kw_on
%token Kw_case
%token Kw_when
%token Kw_then
%token Kw_end
%token Kw_else
%token Kw_textagg
%token Kw_for
%token Kw_delimiter
%token Kw_quote
%token Kw_no
%token Kw_header
%token Kw_encoding
%token Kw_count
%token Kw_count_big
%token Kw_sum
%token Kw_avg
%token Kw_min
%token Kw_max
%token Kw_every
%token Kw_stddev_pop
%token Kw_stddev_samp
%token Kw_var_samp
%token Kw_var_pop
%token Kw_filter
%token Kw_over
%token Kw_partition
%token Kw_range
%token Kw_unbounded
%token Kw_following
%token Kw_preceding
%token Kw_current
%token Kw_row_number
%token Kw_rank
%token Kw_dense_rank
%token Kw_percent_rank
%token Kw_cume_dist
%token Kw_string
%token Kw_varchar
%token Kw_boolean
%token Kw_byte
%token Kw_tinyint
%token Kw_short
%token Kw_smallint
%token Kw_char
%token Kw_integer
%token Kw_long
%token Kw_bigint
%token Kw_biginteger
%token Kw_float
%token Kw_real
%token Kw_double
%token Kw_bigdecimal
%token Kw_decimal
%token Kw_object
%token Kw_blob
%token Kw_clob
%token Kw_json
%token Kw_varbinary
%token Kw_geometry
%token Kw_geography
%token Kw_xml

%token Tok_eof

%start <Types.Ast.entry list> entries
%%

entries:
  | separated_nonempty_list(Tok_semicolon, entry) Tok_eof { $1 }
;;

entry:
                 | directly_executable_statement { $1 }
;;

directly_executable_statement:
                 | query_expression { Directly_executable_statement ($1, ()) }
;;

query_expression:
                 | query_expression_body { Query_expression ([], $1, ()) }
                 | Kw_with; l = separated_nonempty_list(Tok_comma, with_list_element); e = query_expression_body { Query_expression (l, e, ()) }
;;

with_list_element:
  | id = identifier; column_list =  option(column_list); Kw_as Tok_lparen; e = query_expression Tok_rparen {With_list_element (id, column_list, e, ())}
;;

column_list:
                 | Tok_lparen l = separated_nonempty_list(Tok_comma, identifier) Tok_rparen {Column_list (l, ())}
;;

                     (* A sub format to get terms in query_expression_body *)
sub_query_expression_body:
                 | Kw_union Kw_all query_term { (`Union, Some `All, $3) }
                 | Kw_union Kw_distinct query_term { (`Union, Some `Distinct, $3) }
                 | Kw_union query_term { (`Union, None, $2) }
                 | Kw_except Kw_all query_term { (`Except, Some `All, $3) }
                 | Kw_except Kw_distinct query_term { (`Except, Some `Distinct, $3) }
                 | Kw_except query_term { (`Except, None, $2) }
;;

query_expression_body:
  | query_term; terms = list(sub_query_expression_body); order_by = option(order_by_clause);
    limit = option(limit_clause) {
                Query_expression_body ({
                    term = $1;
                    terms;
                    order_by;
                    limit;
                  }, ())
              }
;;

order_by_clause:
  | Kw_order Kw_by; list = separated_nonempty_list(Tok_comma, sort_specification) { Order_by_clause (list, ()) }
;;

sort_specification_order:
  | Kw_asc {`asc}
  | Kw_desc {`desc}
;;

sort_specification_null:
  | Kw_null Kw_first {`null_first }
  | Kw_null Kw_last {`null_last}
;;

sort_specification:
  | sort_key option(sort_specification_order) option(sort_specification_null) { Sort_specification ($1, $2, $3, ())}
;;

limit_clause:
  | Kw_limit; count =  integer_parameter {Limit_clause (`limit {count; offset = None}, ())}
  | Kw_limit; count =  integer_parameter; Tok_comma; start =  integer_parameter {Limit_clause (`limit {count; offset = Some(`comma start)}, ())}
  | Kw_limit; count =  integer_parameter; Kw_offset; start =  integer_parameter; {Limit_clause (`limit {count; offset = Some (`keyword start)}, ())}
  | Kw_offset; start =  integer_parameter; rows = row; fetch = option(fetch_clause) {Limit_clause (`offset ({start; fetch}, rows), ())}
  | fetch_clause {Limit_clause (`fetch $1, ())}
;;

fetch_clause:
  | Kw_fetch Kw_first; param = option(integer_parameter); rows = row; Kw_only {Fetch_clause ({position = `first; param}, rows, ())}
  | Kw_fetch Kw_next; param = option(integer_parameter); rows = row; Kw_only {Fetch_clause ({position = `next; param}, rows, ())}
;;

integer_parameter:
  | Tok_unsigned_integer {Integer_parameter (`unsigned_integer $1, ())}
  | unsigned_value_expression_primary {Integer_parameter (`expression $1, ())}
;;

row:
  | Kw_row {`row}
  | Kw_rows {`rows}
;;

sort_key:
  | expression { Sort_key ($1, ()) }
;;

sub_query_term:
  | Kw_intersect query_primary { (None, $2) }
  | Kw_intersect Kw_all query_primary { (Some `All, $3) }
  | Kw_intersect Kw_distinct query_primary { (Some `Distinct, $3) }
;;

query_term:
  | query_primary list(sub_query_term) { Query_term ($1, $2, ()) }
;;

query_primary:
  | query {Query_primary ($1, ())}
;;

query:
  | select_clause; into = option(into_clause); from = option(sub_select_clause) { Query ($1, into, from, ()) }
;;

select_clause:
  | Kw_select; select_list = select_list { Select_clause (None, select_list,())}
  | Kw_select; Kw_all select_list = select_list { Select_clause (Some `All, select_list, ()) }
  | Kw_select; Kw_distinct select_list = select_list { Select_clause (Some `Distinct, select_list, ()) }
;;

into_clause:
  | Kw_into identifier {Into_clause ($2, ())}
;;

sub_select_clause:
  | from_clause; where = option(where_clause); group_by = option(group_by_clause); having = option(having_clause) { From_clause ({tables = $1; where; having; group_by}, ()) }
;;

from_clause:
  | Kw_from separated_nonempty_list(Tok_comma, table_reference)  { $2 }
;;

group_by_clause:
  | Kw_group Kw_by Kw_rollup Tok_lparen; exp = separated_nonempty_list(Tok_comma, expression); Tok_rparen { Group_by_clause (`rollup exp, ()) }
  | Kw_group Kw_by; exp = separated_nonempty_list(Tok_comma, expression) { Group_by_clause (`default exp, ()) }
;;

having_clause:
  | Kw_having condition { Having_clause ($2, ()) }
;;

where_clause:
  | Kw_where condition { Where_clause ($2, ()) }
;;

      (* table reference *)
table_reference:
  | joined_table { Table_reference ($1, ()) }
;;

joined_table:
  | table_primary list(sub_joined_table) { Joined_table ($1, $2, ()) }
;;

sub_joined_table:
  | Kw_cross Kw_join p = table_primary { `cross (`cross, p) }
  | Kw_union Kw_join p = table_primary { `cross (`union, p) }
  | Kw_join p = table_reference Kw_on c = condition { `qualified (None, p, c) }
  | Kw_right pair(option(Kw_outer), Kw_join) p = table_reference Kw_on c = condition { `qualified (Some `right, p, c) }
  | Kw_left pair(option(Kw_outer), Kw_join) p = table_reference Kw_on c = condition { `qualified (Some `left, p, c) }
  | Kw_full pair(option(Kw_outer), Kw_join) p = table_reference Kw_on c = condition { `qualified (Some `full, p, c) }
  | Kw_inner Kw_join p = table_reference Kw_on c = condition { `qualified (Some `inner, p, c) }
;;

table_primary:
  | table_name { Table_primary (`table_name $1, ()) }
  | table_subquery { Table_primary (`table_subquery $1, ()) }
  | Tok_lparen jt = joined_table Tok_rparen { Table_primary (`joined jt, ()) }
;;

table_subquery:
  | Kw_table Tok_lparen; e = query_expression; Tok_rparen option(Kw_as); ident = identifier {Table_subquery (Some `table, e, ident, ())}
  | Kw_lateral Tok_lparen; e = query_expression; Tok_rparen option(Kw_as); ident = identifier {Table_subquery (Some `lateral, e, ident, ())}
  | Tok_lparen; e = query_expression; Tok_rparen option(Kw_as); ident = identifier {Table_subquery (None, e, ident, ())}
;;

table_name:
  | identifier pair(option(Kw_as), identifier) { ($1, Some (snd $2)) }
  | identifier { ($1, None) }
    (* end table reference *)
;;

select_list:
  | Op_star { `asterisk }
  | separated_nonempty_list(Tok_comma, select_sublist) { `select_list $1 }
;;

select_sublist:
  | Tok_all_in_group {Select_sublist (`All_in_group $1, ())}
  | expression option(pair(option(Kw_as), identifier)) {
        let alias = match $2 with
          | None -> None
          | Some (_, ident) -> Some ident
        in
        Select_sublist (`Select_derived_column ($1, alias), ()) }
;;

derived_column:
  | expression alias = option(pair(Kw_as, identifier)) {Derived_column ($1, Option.map snd alias, ()) }
;;

expression:
  | condition { Expression ($1, ())}
;;

condition:
  | boolean_value_expression { Condition ($1, ())}
;;

(* boolean expression *)
boolean_value_expression:
  | separated_nonempty_list(Kw_or, boolean_term) { Boolean_value_expression (List.hd $1, List.tl $1, ()) }
;;

boolean_term:
  | separated_nonempty_list(Kw_and, boolean_factor) { Boolean_term (List.hd $1, List.tl $1, ()) }
;;

boolean_factor:
  | option(Kw_not) boolean_primary { match $1 with
                                     | None -> Boolean_factor ($2, None, ())
                                     | Some _ -> Boolean_factor ($2, Some `not', ())
      }
;;

      (* 他のASTの実装も必要 *)
boolean_primary:
  | common_value_expression { Boolean_primary ($1, None, ())}
  | common_value_expression comparison_predicate { Boolean_primary ($1, Some (`comparison $2), ())}
  | common_value_expression is_null_predicate { Boolean_primary ($1, Some (`is_null $2), ())}
  | common_value_expression between_predicate { Boolean_primary ($1, Some (`between $2), ())}
  | common_value_expression like_regex_predicate { Boolean_primary ($1, Some (`like_regex $2), ())}
  | common_value_expression match_predicate { Boolean_primary ($1, Some (`match' $2), ())}
  | common_value_expression quantified_comparison_predicate { Boolean_primary ($1, Some (`quantified $2), ())}
  | common_value_expression in_predicate { Boolean_primary ($1, Some (`in' $2), ())}
  | common_value_expression is_distinct { Boolean_primary ($1, Some (`is_distinct $2), ())}
  | common_value_expression exists_predicate { Boolean_primary ($1, Some (`exists $2), ())}
;;

exists_predicate:
  | Kw_exists q = subquery { Exists_predicate (q, ()) }
;;

in_predicate:
  | Kw_in q = subquery { In_predicate (`query q, None,()) }
  | Kw_in Tok_lparen;l = separated_nonempty_list(Tok_comma, common_value_expression); Tok_rparen { In_predicate (`values l, None, ()) }
  | Kw_not Kw_in q = subquery { In_predicate (`query q, Some `not', ()) }
  | Kw_not Kw_in Tok_lparen; l = separated_nonempty_list(Tok_comma, common_value_expression); Tok_rparen { In_predicate (`values l, Some `not', ()) }
;;

subquery:
  | Tok_lparen; q = query_expression; Tok_rparen { Subquery (`query q, ()) }
;;

quantified_comparison_predicate:
  | comparison_operator Kw_any;  q = subquery  { Quantified_comparison_predicate ($1, `any, `query q, ()) }
  | comparison_operator Kw_some;  q = subquery  { Quantified_comparison_predicate ($1, `some, `query q, ()) }
  | comparison_operator Kw_all;  q = subquery  { Quantified_comparison_predicate ($1, `all, `query q, ()) }
  | comparison_operator Kw_any Tok_lparen e = expression Tok_rparen { Quantified_comparison_predicate ($1, `any, `expr e, ()) }
  | comparison_operator Kw_some Tok_lparen e = expression Tok_rparen { Quantified_comparison_predicate ($1, `some, `expr e, ()) }
  | comparison_operator Kw_all Tok_lparen e = expression Tok_rparen { Quantified_comparison_predicate ($1, `all, `expr e, ()) }
;;

character:
  | Tok_string { Character ($1, ())}
;;

match_predicate_escape:
  | Kw_escape c = character { c }
  | Tok_lbrace Kw_escape c = character Tok_rbrace { c }
;;

match_predicate:
  | Kw_like; e = common_value_expression; escape = option(match_predicate_escape) { Match_predicate (`like, e, escape, None, ()) }
  | Kw_not Kw_like; e = common_value_expression; escape = option(match_predicate_escape) { Match_predicate (`like, e, escape, Some `not', ()) }
  | Kw_similar Kw_to; e = common_value_expression; escape = option(match_predicate_escape) { Match_predicate (`similar, e, escape, None, ()) }
  | Kw_not Kw_similar Kw_to; e = common_value_expression; escape = option(match_predicate_escape) { Match_predicate (`similar, e, escape, Some `not', ()) }
;;

like_regex_predicate:
  | Kw_like_regex; s = common_value_expression { Like_regex_predicate (s, None, ()) }
  | Kw_not Kw_like_regex; s = common_value_expression { Like_regex_predicate (s, Some `not', ()) }
;;

between_predicate:
  | Kw_between; s = common_value_expression; Kw_and; e = common_value_expression { Between_predicate (s, e,None, ()) }
  | Kw_not Kw_between; s = common_value_expression; Kw_and; e = common_value_expression { Between_predicate (s, e, Some `not', ()) }
;;

is_distinct:
  | Kw_is Kw_distinct Kw_from; s = common_value_expression { Is_distinct (s, None, ()) }
  |  Kw_is Kw_not Kw_distinct Kw_from; s = common_value_expression { Is_distinct (s, Some `not', ()) }
;;

is_null_predicate:
  | Kw_is Kw_null { Is_null_predicate (None, ()) }
  | Kw_is Kw_not Kw_null { Is_null_predicate (Some `not', ()) }
;;

comparison_predicate:
  | comparison_operator common_value_expression { Comparison_predicate ($1, $2, ()) }
;;

comparison_operator:
  | Op_eq { Comparison_operator (`eq, ()) }
  | Op_ne { Comparison_operator (`ne, ()) }
  | Op_ne2 { Comparison_operator (`ne2, ()) }
  | Op_ge { Comparison_operator (`ge, ()) }
  | Op_gt { Comparison_operator (`gt, ()) }
  | Op_le { Comparison_operator (`le, ()) }
  | Op_lt { Comparison_operator (`lt, ()) }
;;

      (* common value expression *)
amp_or_concat:
  | Op_double_amp { `amp }
  | Op_concat { `concat }
;;

plus_or_minus:
  | Op_minus { `minus }
  | Op_plus { `plus }
;;

star_or_slash:
  | Op_star {`star}
  | Op_slash {`slash}
;;

common_value_expression:
  | numeric_value_expression list(pair(amp_or_concat, numeric_value_expression)) { Common_value_expression ($1, $2, ()) }
;;

numeric_value_expression:
  | term list(pair(plus_or_minus, term)) { Numeric_value_expression ($1, $2, ()) }
;;

term:
  | value_expression_primary list(pair(star_or_slash, value_expression_primary)) { Term ($1, $2, ()) }
;;

(* value expressions *)
value_expression_primary:
  | non_numeric_literal { Value_expression_primary (`non_numeric_literal $1, ())}
  | option(plus_or_minus) unsigned_numeric_literal { Value_expression_primary (`unsigned_numeric_literal ($1, $2), ()) }
  | unsigned_value_expression_primary list(delimited(Tok_lsbrace, numeric_value_expression, Tok_rsbrace)) { Value_expression_primary (`unsigned_value_expression_primary ($1, $2), ()) }
;;

unsigned_value_expression_primary:
  | Tok_qmark { Unsigned_value_expression_primary (`parameter_qmark , ()) }
  | Tok_dollar Tok_unsigned_integer { Unsigned_value_expression_primary (`parameter_dollar $2, ())  }
  | identifier { Unsigned_value_expression_primary (`parameter_identifier $1, ()) }
  | subquery { Unsigned_value_expression_primary (`parameter_subquery $1, ()) }
  | case_expression { Unsigned_value_expression_primary (`case_expression $1, ()) }
  | searched_case_expression { Unsigned_value_expression_primary (`searched_case_expression $1, ()) }
  | nested_expression { Unsigned_value_expression_primary (`nested_expression $1, ()) }
  | f = unescaped_function { Unsigned_value_expression_primary (`unescaped_function f, ()) }
      (* need implementation:
         - escaped function
         - unescaped Function
         - array expression constructor
         - case expression
       *)
      (* end value expressions *)
;;

sub_case_expression:
  | Kw_when w = expression Kw_then t = expression {(w, t)}
;;

case_expression:
  | Kw_case; e = expression; list = nonempty_list(sub_case_expression) els = option(pair(Kw_else, expression)) Kw_end { Case_expression (e, list, Option.map (fun (_, e) -> e) els, ()) }
;;

searched_case_expression:
  | Kw_case; list = nonempty_list(sub_case_expression) els = option(pair(Kw_else, expression)) Kw_end { Searched_case_expression (list, Option.map (fun (_, e) -> e) els, ()) }
;;

nested_expression:
  | Tok_lparen; list = separated_nonempty_list(Tok_comma, expression) option(Tok_comma) Tok_rparen { Nested_expression (list, ()) }
;;

unescaped_function:
| f = text_aggregate_function; filter = option(filter_clause); window = option(window_specification) {Unescaped_function (`text_aggregate_function (f, filter, window))}
| f = standard_aggregate_function; filter = option(filter_clause); window = option(window_specification) {Unescaped_function (`standard_aggregate_function (f, filter, window))}
| f = analytic_aggregate_function; filter = option(filter_clause); window = window_specification {Unescaped_function (`analytic_aggregate_function (f, filter, window))}
;;

text_aggregate_function:
  | Kw_textagg Tok_lparen option(Kw_for); columns = separated_nonempty_list(Tok_comma, derived_column);
    delimiter = option(pair(Kw_delimiter, character));
    option(Kw_header);
    encoding = option(pair(Kw_encoding, identifier));
    order_by = option(order_by_clause); Tok_rparen
    { Text_aggregate_function (columns,
                                Option.map snd delimiter,
                                None,
                                Option.map snd encoding,
                                order_by,
                                ()) }
  | Kw_textagg Tok_lparen option(Kw_for); columns = separated_nonempty_list(Tok_comma, derived_column);
    delimiter = option(pair(Kw_delimiter, character));
    quote = pair(Kw_quote, character);
    option(Kw_header);
    encoding = option(pair(Kw_encoding, identifier));
    order_by = option(order_by_clause); Tok_rparen
    { Text_aggregate_function (columns,
                                Option.map snd delimiter,
                                Some (`quote (snd quote)),
                                Option.map snd encoding,
                                order_by,
                                ()) }
  | Kw_textagg Tok_lparen option(Kw_for); columns = separated_nonempty_list(Tok_comma, derived_column);
    delimiter = option(pair(Kw_delimiter, character));
    pair(Kw_no, Kw_quote);
    option(Kw_header);
    encoding = option(pair(Kw_encoding, identifier));
    order_by = option(order_by_clause); Tok_rparen
    { Text_aggregate_function (columns,
                                Option.map snd delimiter,
                                Some `no_quote,
                                Option.map snd encoding,
                                order_by,
                                ()) }
;;

standard_aggregate_function:
| Kw_count Tok_lparen Op_star Tok_rparen { Standard_aggregate_function (`count_star, ())}
| Kw_count_big Tok_lparen Op_star Tok_rparen { Standard_aggregate_function (`count_big_star, ())}
| kw = standard_aggregate_function_name Tok_lparen e = expression Tok_rparen { Standard_aggregate_function (`call (kw, None, e), ())}
| kw = standard_aggregate_function_name Tok_lparen Kw_all e = expression Tok_rparen { Standard_aggregate_function (`call (kw, Some `All, e), ())}
| kw = standard_aggregate_function_name; Tok_lparen Kw_distinct e = expression Tok_rparen { Standard_aggregate_function (`call (kw, Some `Distinct, e), ())}
;;

%inline standard_aggregate_function_name:
| Kw_count {`count}
| Kw_count_big {`count_big}
| Kw_sum {`sum}
| Kw_avg {`avg}
| Kw_min {`min}
| Kw_max {`max}
| Kw_every {`every}
| Kw_stddev_pop {`stddev_pop}
| Kw_stddev_samp {`stddev_samp}
| Kw_var_samp {`var_samp}
| Kw_var_pop {`var_pop}
| Kw_some {`some}
| Kw_any {`any}
;;

filter_clause:
  | Kw_filter Tok_lparen Kw_where e = boolean_primary Tok_rparen {Filter_clause (e, ())}
;;

window_specification:
| Kw_over Tok_lparen; Kw_partition Kw_by; expr = separated_nonempty_list(Tok_comma, expression);
  order_by = option(order_by_clause);
  frame = option(window_frame) Tok_rparen {
              Window_specification (expr, order_by, frame, ())
            }

| Kw_over Tok_lparen; order_by = option(order_by_clause); frame = option(window_frame) Tok_rparen {
                                                                      Window_specification ([], order_by, frame, ())
                                                                    }
;;

window_frame:
| Kw_range Kw_between; s = window_frame_bound; Kw_and; e = window_frame_bound { Window_frame {
                                                                                    typ = `range;
                                                                                    bound = `between (s, e);
                                                                                    metadata = ()
                                                             } }
| Kw_rows Kw_between; s = window_frame_bound; Kw_and; e = window_frame_bound { Window_frame {
                                                                                    typ = `rows;
                                                                                    bound = `between (s, e);
                                                                                    metadata = ()
                                                             } }
| Kw_range bound = window_frame_bound { Window_frame {
                                           typ = `range;
                                           bound =`raw bound;
                                           metadata= ()
                    } }
| Kw_rows bound = window_frame_bound { Window_frame {
                                           typ = `rows;
                                           bound = `raw bound;
                                           metadata = ()
                    } }
;;

window_frame_bound:
| Kw_unbounded Kw_following {Window_frame_bound (`bounding (`unbounded, `following), ())}
| Kw_unbounded Kw_preceding {Window_frame_bound (`bounding (`unbounded, `preceding), ())}
| i = unsigned_integer Kw_following {Window_frame_bound (`bounding (`bounded i, `following), ())}
| i = unsigned_integer Kw_preceding {Window_frame_bound (`bounding (`bounded i, `preceding), ())}
| Kw_current Kw_row {Window_frame_bound (`current, ())}
;;

analytic_aggregate_function:
| kw = analytic_aggregate_function_name Tok_lparen Tok_rparen { Analytic_aggregate_function (kw, ())}
;;

%inline analytic_aggregate_function_name:
| Kw_row_number {`row_number}
| Kw_rank {`rank}
| Kw_dense_rank {`dense_rank}
| Kw_percent_rank {`percent_rank}
| Kw_cume_dist {`cume_dist}
;;

simple_data_type:
  | Kw_string { Simple_data_type (`string None) }
  | Kw_string Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`string (Some ui)) }
  | Kw_varchar { Simple_data_type (`varchar None) }
  | Kw_varchar Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`varchar (Some ui)) }
  | Kw_boolean { Simple_data_type `boolean }
  | Kw_byte { Simple_data_type `byte }
  | Kw_tinyint { Simple_data_type `tinyint }
  | Kw_short { Simple_data_type `short }
  | Kw_smallint { Simple_data_type `smallint }
  | Kw_char { Simple_data_type (`char None) }
  | Kw_char Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`char (Some ui)) }
  | Kw_integer { Simple_data_type `integer }
  | Kw_long { Simple_data_type `long }
  | Kw_bigint { Simple_data_type `bigint }
  | Kw_biginteger { Simple_data_type (`biginteger None) }
  | Kw_biginteger Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`biginteger (Some ui)) }
  | Kw_float { Simple_data_type `float }
  | Kw_real { Simple_data_type `real }
  | Kw_double { Simple_data_type `double }
  | Kw_bigdecimal { Simple_data_type (`bigdecimal (None, None)) }
  | Kw_bigdecimal Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`bigdecimal (Some ui, None)) }
  | Kw_bigdecimal Tok_lparen ui = unsigned_integer Tok_comma prec = unsigned_integer Tok_rparen { Simple_data_type (`bigdecimal (Some ui, Some prec)) }
  | Kw_decimal { Simple_data_type (`decimal (None, None)) }
  | Kw_decimal Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`decimal (Some ui, None)) }
  | Kw_decimal Tok_lparen ui = unsigned_integer Tok_comma prec = unsigned_integer Tok_rparen { Simple_data_type (`decimal (Some ui, Some prec)) }
  | Kw_date { Simple_data_type `date }
  | Kw_time { Simple_data_type `time }
  | Kw_timestamp { Simple_data_type (`timestamp None) }
  | Kw_timestamp Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`timestamp (Some ui)) }
  | Kw_object { Simple_data_type (`object' None) }
  | Kw_object Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`object' (Some ui)) }
  | Kw_blob { Simple_data_type (`blob None) }
  | Kw_blob Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`blob (Some ui)) }
  | Kw_clob { Simple_data_type (`clob None) }
  | Kw_clob Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`clob (Some ui)) }
  | Kw_json { Simple_data_type `json }
  | Kw_varbinary { Simple_data_type (`varbinary None) }
  | Kw_varbinary Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`varbinary (Some ui)) }
  | Kw_geometry { Simple_data_type `geometry }
  | Kw_geography { Simple_data_type `geography }
  | Kw_xml { Simple_data_type `xml }
;;

basic_data_type:
  | typ = simple_data_type; ary = option(pair(Tok_lbrace, Tok_rbrace)) {
                                      let ary = Option.map (fun _ -> true) ary |> Option.value ~default:false in
                                      Basic_data_type (typ, ary, ())
                                    }
;;
data_type:
  | typ = basic_data_type { Data_type (`basic typ, ())}
  | typ = identifier; ary = option(pair(Tok_lbrace, Tok_rbrace)) {
                                      let ary = Option.map (fun _ -> true) ary |> Option.value ~default:false in
                                      Basic_data_type (`other (typ, ary), ())
                                    }
;;
      (* literals *)
unsigned_integer:
| Tok_unsigned_integer { Unsigned_integer ($1, ()) }
;;

non_numeric_literal:
  | Tok_string { Non_numeric_literal (`string $1, ())}
  | Tok_typed_string {Non_numeric_literal (`typed_string $1, ())}
  | Tok_bin_string {Non_numeric_literal (`bin_string $1, ())}
  | Kw_date Tok_string {Non_numeric_literal (`datetime_string (`date $2), ())}
  | Kw_time Tok_string {Non_numeric_literal (`datetime_string (`time $2), ())}
  | Kw_timestamp Tok_string {Non_numeric_literal (`datetime_string (`timestamp $2), ())}
  | Kw_true {Non_numeric_literal (`TRUE, ()) }
  | Kw_false {Non_numeric_literal (`FALSE, ()) }
  | Kw_unknown {Non_numeric_literal (`UNKNOWN, ())}
  | Kw_null { Non_numeric_literal (`NULL, ()) }
;;

unsigned_numeric_literal:
  | Tok_unsigned_integer { Unsigned_numeric_literal (`unsigned $1, ()) }
  | Tok_approximate_numeric { Unsigned_numeric_literal (`approximate $1, ()) }
  | Tok_decimal_numeric { Unsigned_numeric_literal (`decimal $1, ()) }
;;

identifier:
  | Tok_ident { Identifier ($1, ())}
;;
