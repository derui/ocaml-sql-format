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
%token Tok_quote
%token <string> Tok_ident
%token <string> Tok_string
%token <string> Tok_national_string
%token <string> Tok_unicode_string
%token <string> Tok_typed_string
%token <string> Tok_bin_string
%token <string> Tok_all_in_group
%token <string> Tok_exact_numeric_literal
%token <string> Tok_approximate_numeric_literal
%token <string> Tok_unsigned_integer

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
%token Kw_convert
%token Kw_cast
%token Kw_substring
%token Kw_extract
%token Kw_year
%token Kw_month
%token Kw_day
%token Kw_hour
%token Kw_minute
%token Kw_second
%token Kw_quarter
%token Kw_epoch
%token Kw_dow
%token Kw_doy
%token Kw_leading
%token Kw_trailing
%token Kw_both
%token Kw_trim
%token Kw_to_chars
%token Kw_to_bytes
%token Kw_sql_tsi_frac_second
%token Kw_sql_tsi_second
%token Kw_sql_tsi_minute
%token Kw_sql_tsi_hour
%token Kw_sql_tsi_day
%token Kw_sql_tsi_week
%token Kw_sql_tsi_month
%token Kw_sql_tsi_quarter
%token Kw_sql_tsi_year
%token Kw_timestampadd
%token Kw_timestampdiff
%token Kw_user
%token Kw_xmlconcat
%token Kw_xmlcomment
%token Kw_xmltext
%token Kw_insert
%token Kw_translate
%token Kw_position
%token Kw_listagg
%token Kw_within
%token Kw_current_date
%token Kw_current_timestamp
%token Kw_current_time
%token Kw_exception
%token Kw_serial
%token Kw_index
%token Kw_instead
%token Kw_view
%token Kw_enabled
%token Kw_disabled
%token Kw_key
%token Kw_document
%token Kw_content
%token Kw_empty
%token Kw_ordinality
%token Kw_path
%token Kw_querystring
%token Kw_namespace
%token Kw_result
%token Kw_accesspattern
%token Kw_auto_increment
%token Kw_wellformed
%token Kw_texttable
%token Kw_arraytable
%token Kw_jsontable
%token Kw_selector
%token Kw_skip
%token Kw_width
%token Kw_passing
%token Kw_name
%token Kw_columns
%token Kw_nulls
%token Kw_objecttable
%token Kw_version
%token Kw_including
%token Kw_excluding
%token Kw_xmldeclaration
%token Kw_variadic
%token Kw_raise
%token Kw_chain
%token Kw_jsonarray_agg
%token Kw_jsonobject
%token Kw_preserve
%token Kw_upsert
%token Kw_after
%token Kw_type
%token Kw_translator
%token Kw_jaas
%token Kw_condition
%token Kw_mask
%token Kw_access
%token Kw_control
%token Kw_none
%token Kw_data
%token Kw_database
%token Kw_privileges
%token Kw_role
%token Kw_schema
%token Kw_use
%token Kw_repository
%token Kw_rename
%token Kw_domain
%token Kw_usage
%token Kw_explain
%token Kw_analyze
%token Kw_text
%token Kw_format
%token Kw_yaml
%token Kw_policy
%token Kw_session_user
%token Kw_interval
%token Kw_tablesample
%token Kw_bernoulli
%token Kw_system
%token Kw_repeatable
%token Kw_unnest

%token Tok_eof

%start <Types.Ast.entry list> entries
%%

entries:
  | separated_nonempty_list(Tok_semicolon, entry) Tok_eof { $1 }
;;

entry:
                 | directly_executable_statement { $1 }
;;

(** Start names and identifiers *)
%inline column_name:
   | i = identifier { i }
;;

local_or_schema_qualifier:
| Kw_module { `module' }
| s = schema_name { `schema s }
;;

local_or_schema_qualifier_name:
| q = option(pair(local_or_schema_qualifier, Tok_period)) i = identifier { (Option.map fst q, i) }
;;

schema_name:
| c = option(pair(identifier, Tok_period)) n = identifier { Schema_name (Option.map fst c, n) }
;;

table_name:
   | i = local_or_schema_qualifier_name { Table_name (i, ()) }
;;

query_name:
   | i = identifier { Query_name (i, ()) }
;;

(** End   names and identifiers *)


(** Start 7.4 table expression *)
table_expression:
  | from = from_clause;
    where = option(where_clause);
    group_by = option(group_by_clause);
    having = option(having_clause);
    window = option(window_clause) { Table_expression (from, where, group_by, having, window, ()) }
;;
(** End   7.4 table expression *)

(** Start 7.5 from clause *)
from_clause:
| Kw_from l = table_reference_list {From_clause (l, ())}
;;

table_reference_list:
| fl = table_reference rest = list(pair(Tok_comma, table_reference)) {Table_reference_list (fl, rest, ())}
;;
(** End   7.5 from clause *)

(** Start 7.6 table reference *)

table_reference:
| t = table_primary  s = option(sample_clause) { Table_reference (`primary t,s ,() ) }
| t = joined_table  s = option(sample_clause) { Table_reference (`joined t,s ,() ) }
;;

sample_clause:
| Kw_tablesample Kw_bernoulli Tok_lparen v = numeric_value_expression Tok_rparen r = option(repeatable_clause) { Sample_clause (`bernoulli, v, r, ()) }
| Kw_tablesample Kw_system Tok_lparen v = numeric_value_expression Tok_rparen r = option(repeatable_clause) { Sample_clause (`system, v, r, ()) }
;;

repeatable_clause:
| Kw_repeatable Tok_lparen e = numeric_value_expression Tok_rparen {Repeatable_clause (e, ())}
;;

table_primary:
| t = table_or_query_name { Table_primary (`table_or_query (t, None), ()) }
| t = table_or_query_name n = pair(option(Kw_as), identifier) { Table_primary (`table_or_query (t, Some (snd n, None)), ()) }
| t = table_or_query_name n = pair(option(Kw_as), identifier);
  l = delimited(Tok_lparen, derived_column_list, Tok_rparen) { Table_primary (`table_or_query (t, Some (snd n, Some l)), ()) }
| t = derived_table option(Kw_as) n = identifier;
 l = option(delimited(Tok_lparen, derived_column_list, Tok_rparen)) { Table_primary (`derived (t, n, l), ()) }
| t = lateral_derived_table option(Kw_as) n = identifier;
 l = option(delimited(Tok_lparen, derived_column_list, Tok_rparen)) { Table_primary (`lateral (t, n, l), ()) }
| t = collection_derived_table option(Kw_as) n = identifier;
 l = option(delimited(Tok_lparen, derived_column_list, Tok_rparen)) { Table_primary (`collection (t, n, l), ()) }
| t = table_function_derived_table option(Kw_as) n = identifier;
 l = option(delimited(Tok_lparen, derived_column_list, Tok_rparen)) { Table_primary (`table_function (t, n, l), ()) }
(* -- only spec  *)
| t = only_spec { Table_primary (`only (t, None), ()) }
| t = only_spec n = pair(option(Kw_as), identifier) { Table_primary (`only (t, Some (snd n, None)), ()) }
| t = only_spec n = pair(option(Kw_as), identifier);
  l = delimited(Tok_lparen, derived_column_list, Tok_rparen) { Table_primary (`only (t, Some (snd n, Some l)), ()) }
| jt = delimited(Tok_lparen, joined_table, Tok_rparen) { Table_primary (`joined jt, ()) }
;;

only_spec:
| Kw_only e = delimited(Tok_lparen, table_or_query_name, Tok_rparen) {Only_spec (e, ())}
;;

lateral_derived_table:
| Kw_lateral q = table_subquery { Lateral_derived_table (q, ())}
;;

collection_derived_table:
| Kw_unnest Tok_lparen e = collection_value_expression Tok_rparen o = option(pair(Kw_with, Kw_ordinality)) {Collection_derived_table (e, Option.map (fun _ -> `ordinality) o, ())}
;;

table_function_derived_table:
| Kw_table Tok_lparen e = collection_value_expression Tok_rparen {Table_function_derived_table (e, ())}
;;

derived_table:
| q = table_subquery {Derived_table (q, ())}
;;

table_or_query_name:
| q = query_name {Table_or_query_name (`query q, ())}
| q = table_name {Table_or_query_name (`table q, ())}
;;
derived_column_list:
| l = column_name_list {Derived_column_list (l, ())}
;;

column_name_list:
| c = column_name l = list(pair(Tok_comma, column_name)) { Column_name_list (c, List.map snd l, ()) }
;;

(** End   7.6 table reference *)

(** Start 7.8 where clause *)
where_clause:
| Kw_where s = search_condition {Where_clause (s, ())}
;;
(** End   7.8 where clause *)

(** Start 7.9 Group by clause *)
(** End   7.9 Group by clause *)

(** Start 7.10 having clause *)
having_clause:
| Kw_having e = search_condition {Having_clause (e, ())}
;;
(** End   7.10 having clause *)


(** Start 7.12 Query specification *)
query_specification:
  | Kw_select q = option(set_qualifier) l = select_list t = table_expression { Query_specification (q, l, t, ()) }
;;

select_list:
| Op_star { Select_list (`asterisk, ()) }
| f = select_sublist l = list(pair(Tok_comma, select_sublist)) {
                             let l = List.map snd l in
                             Select_list (`list (f, l), ()) }
;;

select_sublist:
| d = derived_column {Select_sublist (`derived d, ())}
| d = qualified_asterisk {Select_sublist (`asterisk d, ())}
;;

qualified_asterisk:
| c = asterisked_identifier_chain Tok_period Op_star { Qualified_asterisk (`chain c) }
| c = all_fields_reference { Qualified_asterisk (`all c) }
;;

asterisked_identifier_chain:
| i = identifier l = list(pair(Tok_period, identifier)) {Asterisked_identifier_chain (i,List.map snd l, ())}
;;

derived_column:
| e = value_expression c = option(as_clause) {Derived_column (e, c, ())}
;;

as_clause:
| option(Kw_as) c = column_name {As_clause (c, ()) }
;;

all_fields_reference:
| e = value_expression_primary Tok_period Op_star { All_fields_reference (e, None, ()) }
| e = value_expression_primary Tok_period Op_star;
  Kw_as Tok_lparen a = all_fields_column_name_list Tok_rparen  { All_fields_reference (e, Some a, ()) }
;;

all_fields_column_name_list:
| l = column_name_list { All_fields_column_name_list (l, ()) }
;;

(** End   7.12 Query specification *)

(** Start 8.19 Search condition *)
search_condition:
| e = boolean_value_expression {Search_condition (e, ())}
;;
(** End   8.19 Search condition *)


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

%inline sub_query_term:
  | Kw_intersect query_primary { (None, $2) }
  | Kw_intersect Kw_all query_primary { (Some `All, $3) }
  | Kw_intersect Kw_distinct query_primary { (Some `Distinct, $3) }
;;

query_term:
  | query_primary list(sub_query_term) { Query_term ($1, $2, ()) }
;;

query_primary:
  | query {Query_primary (`query $1, ())}
  | Tok_lparen q = query_expression_body Tok_rparen {Query_primary (`nested q, ())}
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
  | comparison_operator Kw_some; q = subquery  { Quantified_comparison_predicate ($1, `some, `query q, ()) }
  | comparison_operator Kw_all;  q = subquery  { Quantified_comparison_predicate ($1, `all, `query q, ()) }
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
  | nested_expression { Unsigned_value_expression_primary (`nested_expression $1, ()) }
  | case_expression { Unsigned_value_expression_primary (`case_expression $1, ()) }
  | searched_case_expression { Unsigned_value_expression_primary (`searched_case_expression $1, ()) }
  | f = unescaped_function { Unsigned_value_expression_primary (`unescaped_function f, ()) }
      (* need implementation:
         - escaped function
         - array expression constructor
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
  | Tok_lparen; list = separated_nonempty_list(Tok_comma, expression); option(Tok_comma) Tok_rparen { Nested_expression (list, ()) }
;;

unescaped_function:
| f = text_aggregate_function; filter = option(filter_clause); window = option(window_specification) {Unescaped_function (`text_aggregate_function (f, filter, window), ())}
| f = standard_aggregate_function; filter = option(filter_clause); window = option(window_specification) {Unescaped_function (`standard_aggregate_function (f, filter, window), ())}
| f = analytic_aggregate_function; filter = option(filter_clause); window = window_specification {Unescaped_function (`analytic_aggregate_function (f, filter, window), ())}
| f = function_;  window = option(window_specification) {Unescaped_function (`function' (f, window), ())}
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
  | Kw_string { Simple_data_type (`string None, ()) }
  | Kw_string Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`string (Some ui), ()) }
  | Kw_varchar { Simple_data_type (`varchar None, ()) }
  | Kw_varchar Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`varchar (Some ui), ()) }
  | Kw_boolean { Simple_data_type (`boolean, ()) }
  | Kw_byte { Simple_data_type (`byte, ()) }
  | Kw_tinyint { Simple_data_type (`tinyint, ()) }
  | Kw_short { Simple_data_type (`short, ()) }
  | Kw_smallint { Simple_data_type (`smallint, ()) }
  | Kw_char { Simple_data_type (`char None, ()) }
  | Kw_char Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`char (Some ui), ()) }
  | Kw_integer { Simple_data_type (`integer, ()) }
  | Kw_long { Simple_data_type (`long, ()) }
  | Kw_bigint { Simple_data_type (`bigint, ()) }
  | Kw_biginteger { Simple_data_type (`biginteger None, ()) }
  | Kw_biginteger Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`biginteger (Some ui), ()) }
  | Kw_float { Simple_data_type (`float, ()) }
  | Kw_real { Simple_data_type (`real, ()) }
  | Kw_double { Simple_data_type (`double, ()) }
  | Kw_bigdecimal { Simple_data_type (`bigdecimal (None, None), ()) }
  | Kw_bigdecimal Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`bigdecimal (Some ui, None), ()) }
  | Kw_bigdecimal Tok_lparen ui = unsigned_integer Tok_comma prec = unsigned_integer Tok_rparen { Simple_data_type (`bigdecimal (Some ui, Some prec), ()) }
  | Kw_decimal { Simple_data_type (`decimal (None, None), ()) }
  | Kw_decimal Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`decimal (Some ui, None), ()) }
  | Kw_decimal Tok_lparen ui = unsigned_integer Tok_comma prec = unsigned_integer Tok_rparen { Simple_data_type (`decimal (Some ui, Some prec), ()) }
  | Kw_date { Simple_data_type (`date, ()) }
  | Kw_time { Simple_data_type (`time, ()) }
  | Kw_timestamp { Simple_data_type (`timestamp None, ()) }
  | Kw_timestamp Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`timestamp (Some ui), ()) }
  | Kw_object { Simple_data_type (`object' None, ()) }
  | Kw_object Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`object' (Some ui), ()) }
  | Kw_blob { Simple_data_type (`blob None, ()) }
  | Kw_blob Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`blob (Some ui), ()) }
  | Kw_clob { Simple_data_type (`clob None, ()) }
  | Kw_clob Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`clob (Some ui), ()) }
  | Kw_json { Simple_data_type (`json, ()) }
  | Kw_varbinary { Simple_data_type (`varbinary None, ()) }
  | Kw_varbinary Tok_lparen ui = unsigned_integer Tok_rparen { Simple_data_type (`varbinary (Some ui), ()) }
  | Kw_geometry { Simple_data_type (`geometry, ()) }
  | Kw_geography { Simple_data_type (`geography, ()) }
  | Kw_xml { Simple_data_type (`xml, ()) }
;;

basic_data_type:
  | typ = simple_data_type; ary = option(pair(Tok_lsbrace, Tok_rsbrace)) {
                                      let ary = Option.map (fun _ -> true) ary |> Option.value ~default:false in
                                      Basic_data_type (typ, ary, ())
                                    }
;;
data_type:
  | typ = basic_data_type { Data_type (`basic typ, ())}
  | typ = identifier; ary = option(pair(Tok_lsbrace, Tok_rsbrace)) {
                                      let ary = Option.map (fun _ -> true) ary |> Option.value ~default:false in
                                      Data_type (`other (typ, ary), ())
                                    }
;;

function_:
| Kw_convert Tok_lparen e = expression Tok_comma d = data_type  Tok_rparen { Function (`convert (e, d), ()) }
| Kw_cast Tok_lparen e = expression Kw_as d = data_type  Tok_rparen { Function (`cast (e, d), ()) }
| Kw_substring Tok_lparen e = expression Kw_from f = expression for_ = option(pair(Kw_for, expression)) Tok_rparen {
                                                         let from' = Option.map snd for_ in
                                                         Function (`substring (e, `from_for (f, from')), ())
                                                                         }
| Kw_substring Tok_lparen e = expression Tok_comma l = separated_nonempty_list(Tok_comma, expression) Tok_rparen {
                                                           Function (`substring (e, `list l), ())
                                                                         }
| f = function_extract { f }
| f = function_trim { f }
| Kw_to_chars Tok_lparen e = expression Tok_comma s = Tok_string opt = option(pair(Tok_comma, expression)) Tok_rparen {
                                                                       let opt = Option.map snd opt in
                                                                       Function (`to_chars (e, s, opt), ())
                                                                       }
| Kw_to_bytes Tok_lparen e = expression Tok_comma s = Tok_string opt = option(pair(Tok_comma, expression)) Tok_rparen {
                                                                       let opt = Option.map snd opt in
                                                                       Function (`to_bytes (e, s, opt), ())
                                                                       }
| Kw_timestampadd Tok_lparen;
  ti = time_interval Tok_comma e2 = expression; Tok_comma e3 = expression Tok_rparen {
                                                                       Function (`timestampadd (ti, e2, e3), ())
                                                                       }
| Kw_timestampdiff Tok_lparen;
  ti = time_interval Tok_comma e2 = expression; Tok_comma e3 = expression Tok_rparen {
                                                                       Function (`timestampdiff (ti, e2, e3), ())
                                                                       }
| Kw_left Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`left e, ())}
| Kw_right Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`right e, ())}
| Kw_char Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`char e, ())}
| Kw_user Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`user e, ())}
| Kw_year Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`year e, ())}
| Kw_month Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`month e, ())}
| Kw_hour Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`hour e, ())}
| Kw_minute Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`minute e, ())}
| Kw_second Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`second e, ())}
| Kw_xmlconcat Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`xmlconcat e, ())}
| Kw_xmlcomment Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`xmlcomment e, ())}
| Kw_xmltext Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`xmltext e, ())}
| Kw_insert Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`insert e, ())}
| Kw_translate Tok_lparen e = separated_list(Tok_comma, expression) Tok_rparen {Function (`translate e, ())}
| Kw_position Tok_lparen s = common_value_expression Kw_in e = common_value_expression Tok_rparen {Function (`position (s, e), ())}
| Kw_listagg Tok_lparen e = expression str = option(pair(Tok_comma, Tok_string)) Tok_rparen;
  Kw_within Kw_group Tok_lparen order_by = order_by_clause Tok_rparen
  {
    let str = Option.map snd str in
    Function (`listagg (e, str, order_by), ())}
| Kw_current_date option(pair(Tok_lparen, Tok_rparen)) {Function (`current_date, ())}
| ident = identifier Tok_lparen; e = separated_list(Tok_comma, expression);
  order_by = option(order_by_clause);
  Tok_rparen;
  filter = option(filter_clause) {Function (`call (ident, None, e, order_by, filter), ())}
| ident = identifier Tok_lparen; Kw_all e = separated_list(Tok_comma, expression);
  order_by = option(order_by_clause);
  Tok_rparen;
  filter = option(filter_clause) {Function (`call (ident, Some `All, e, order_by, filter), ())}
| ident = identifier Tok_lparen; Kw_distinct e = separated_list(Tok_comma, expression);
  order_by = option(order_by_clause);
  Tok_rparen;
  filter = option(filter_clause) {Function (`call (ident, Some `Distinct, e, order_by, filter), ())}
| Kw_current_timestamp Tok_lparen int = unsigned_integer Tok_rparen {Function (`current_timestamp (Some int), ())}
| Kw_current_time Tok_lparen int = unsigned_integer Tok_rparen {Function (`current_time (Some int), ())}
| Kw_current_timestamp {Function (`current_timestamp None, ())}
| Kw_current_time {Function (`current_time None, ())}
| Kw_session_user {Function (`session_user, ())}
;;

%inline function_extract:
| Kw_extract Tok_lparen Kw_year Kw_from e = expression Tok_rparen {Function (`extract (e, `year), ())}
| Kw_extract Tok_lparen Kw_month Kw_from e = expression Tok_rparen {Function (`extract (e, `month), ())}
| Kw_extract Tok_lparen Kw_day Kw_from e = expression Tok_rparen {Function (`extract (e, `day), ())}
| Kw_extract Tok_lparen Kw_hour Kw_from e = expression Tok_rparen {Function (`extract (e, `hour), ())}
| Kw_extract Tok_lparen Kw_minute Kw_from e = expression Tok_rparen {Function (`extract (e, `minute), ())}
| Kw_extract Tok_lparen Kw_second Kw_from e = expression Tok_rparen {Function (`extract (e, `second), ())}
| Kw_extract Tok_lparen Kw_quarter Kw_from e = expression Tok_rparen {Function (`extract (e, `quarter), ())}
| Kw_extract Tok_lparen Kw_epoch Kw_from e = expression Tok_rparen {Function (`extract (e, `epoch), ())}
| Kw_extract Tok_lparen Kw_dow Kw_from e = expression Tok_rparen {Function (`extract (e, `dow), ())}
| Kw_extract Tok_lparen Kw_doy Kw_from e = expression Tok_rparen {Function (`extract (e, `doy), ())}
;;

%inline function_trim:
| Kw_trim Tok_lparen Kw_leading te = option(expression) Kw_from e = expression Tok_rparen {Function (`trim (Some (`leading te), e), ())}
| Kw_trim Tok_lparen Kw_trailing te = option(expression) Kw_from e = expression Tok_rparen {Function (`trim (Some (`trailing te), e), ())}
| Kw_trim Tok_lparen Kw_both te = option(expression) Kw_from e = expression Tok_rparen {Function (`trim (Some (`both te), e), ())}
| Kw_trim Tok_lparen te = expression Kw_from e = expression Tok_rparen {Function (`trim ( Some (`no_trimmer te), e), ())}
| Kw_trim Tok_lparen e = expression Tok_rparen {Function (`trim (None, e), ())}
;;

%inline time_interval:
| Kw_sql_tsi_frac_second { Time_interval (`frac_second, ()) }
| Kw_sql_tsi_second { Time_interval (`second, ()) }
| Kw_sql_tsi_minute { Time_interval (`minute, ()) }
| Kw_sql_tsi_hour { Time_interval (`hour, ()) }
| Kw_sql_tsi_day { Time_interval (`day, ()) }
| Kw_sql_tsi_week { Time_interval (`week, ()) }
| Kw_sql_tsi_month { Time_interval (`month, ()) }
| Kw_sql_tsi_quarter { Time_interval (`quarter, ()) }
| Kw_sql_tsi_year { Time_interval (`year, ()) }
;;

non_reserved_identifier:
  | Kw_exception { Non_reserved_identifier (`exception',()) }
  | Kw_serial { Non_reserved_identifier (`serial,()) }
  | Kw_object { Non_reserved_identifier (`object',()) }
  | Kw_index { Non_reserved_identifier (`index,()) }
  | Kw_json { Non_reserved_identifier (`json,()) }
  | Kw_geometry { Non_reserved_identifier (`geometry,()) }
  | Kw_geography { Non_reserved_identifier (`geography,()) }
  | basic = basic_non_reserved { Non_reserved_identifier (`basic basic, ()) }
;;

basic_non_reserved:
  | Kw_instead  {Basic_non_reserved (`instead, ())}
  | Kw_view  {Basic_non_reserved (`view, ())}
  | Kw_enabled  {Basic_non_reserved (`enabled, ())}
  | Kw_disabled  {Basic_non_reserved (`disabled, ())}
  | Kw_key  {Basic_non_reserved (`key, ())}
  | Kw_textagg  {Basic_non_reserved (`textagg, ())}
  | Kw_count  {Basic_non_reserved (`count, ())}
  | Kw_count_big  {Basic_non_reserved (`count_big, ())}
  | Kw_row_number  {Basic_non_reserved (`row_number, ())}
  | Kw_rank  {Basic_non_reserved (`rank, ())}
  | Kw_dense_rank  {Basic_non_reserved (`dense_rank, ())}
  | Kw_sum  {Basic_non_reserved (`sum, ())}
  | Kw_avg  {Basic_non_reserved (`avg, ())}
  | Kw_min  {Basic_non_reserved (`min, ())}
  | Kw_max  {Basic_non_reserved (`max, ())}
  | Kw_every  {Basic_non_reserved (`every, ())}
  | Kw_stddev_pop  {Basic_non_reserved (`stddev_pop, ())}
  | Kw_stddev_samp  {Basic_non_reserved (`stddev_samp, ())}
  | Kw_var_samp  {Basic_non_reserved (`var_samp, ())}
  | Kw_var_pop  {Basic_non_reserved (`var_pop, ())}
  | Kw_document  {Basic_non_reserved (`document, ())}
  | Kw_content  {Basic_non_reserved (`content, ())}
  | Kw_trim  {Basic_non_reserved (`trim, ())}
  | Kw_empty  {Basic_non_reserved (`empty, ())}
  | Kw_ordinality  {Basic_non_reserved (`ordinality, ())}
  | Kw_path  {Basic_non_reserved (`path, ())}
  | Kw_first  {Basic_non_reserved (`first, ())}
  | Kw_last  {Basic_non_reserved (`last, ())}
  | Kw_next  {Basic_non_reserved (`next, ())}
  | Kw_substring  {Basic_non_reserved (`substring, ())}
  | Kw_extract  {Basic_non_reserved (`extract, ())}
  | Kw_to_chars  {Basic_non_reserved (`to_chars, ())}
  | Kw_to_bytes  {Basic_non_reserved (`to_bytes, ())}
  | Kw_timestampadd  {Basic_non_reserved (`timestampadd, ())}
  | Kw_timestampdiff  {Basic_non_reserved (`timestampdiff, ())}
  | Kw_querystring  {Basic_non_reserved (`querystring, ())}
  | Kw_namespace  {Basic_non_reserved (`namespace, ())}
  | Kw_result  {Basic_non_reserved (`result, ())}
  | Kw_accesspattern  {Basic_non_reserved (`accesspattern, ())}
  | Kw_auto_increment  {Basic_non_reserved (`auto_increment, ())}
  | Kw_wellformed  {Basic_non_reserved (`wellformed, ())}
  | Kw_sql_tsi_frac_second  {Basic_non_reserved (`sql_tsi_frac_second, ())}
  | Kw_sql_tsi_second  {Basic_non_reserved (`sql_tsi_second, ())}
  | Kw_sql_tsi_minute  {Basic_non_reserved (`sql_tsi_minute, ())}
  | Kw_sql_tsi_hour  {Basic_non_reserved (`sql_tsi_hour, ())}
  | Kw_sql_tsi_day  {Basic_non_reserved (`sql_tsi_day, ())}
  | Kw_sql_tsi_week  {Basic_non_reserved (`sql_tsi_week, ())}
  | Kw_sql_tsi_month  {Basic_non_reserved (`sql_tsi_month, ())}
  | Kw_sql_tsi_quarter  {Basic_non_reserved (`sql_tsi_quarter, ())}
  | Kw_sql_tsi_year  {Basic_non_reserved (`sql_tsi_year, ())}
  | Kw_texttable  {Basic_non_reserved (`texttable, ())}
  | Kw_arraytable  {Basic_non_reserved (`arraytable, ())}
  | Kw_jsontable  {Basic_non_reserved (`jsontable, ())}
  | Kw_selector  {Basic_non_reserved (`selector, ())}
  | Kw_skip  {Basic_non_reserved (`skip, ())}
  | Kw_width  {Basic_non_reserved (`width, ())}
  | Kw_passing  {Basic_non_reserved (`passing, ())}
  | Kw_name  {Basic_non_reserved (`name, ())}
  | Kw_encoding  {Basic_non_reserved (`encoding, ())}
  | Kw_columns  {Basic_non_reserved (`columns, ())}
  | Kw_delimiter  {Basic_non_reserved (`delimiter, ())}
  | Kw_quote  {Basic_non_reserved (`quote, ())}
  | Kw_header  {Basic_non_reserved (`header, ())}
  | Kw_nulls  {Basic_non_reserved (`nulls, ())}
  | Kw_objecttable  {Basic_non_reserved (`objecttable, ())}
  | Kw_version  {Basic_non_reserved (`version, ())}
  | Kw_including  {Basic_non_reserved (`including, ())}
  | Kw_excluding  {Basic_non_reserved (`excluding, ())}
  | Kw_xmldeclaration  {Basic_non_reserved (`xmldeclaration, ())}
  | Kw_variadic  {Basic_non_reserved (`variadic, ())}
  | Kw_raise  {Basic_non_reserved (`raise, ())}
  | Kw_chain  {Basic_non_reserved (`chain, ())}
  | Kw_jsonarray_agg  {Basic_non_reserved (`jsonarray_agg, ())}
  | Kw_jsonobject  {Basic_non_reserved (`jsonobject, ())}
  | Kw_preserve  {Basic_non_reserved (`preserve, ())}
  | Kw_upsert  {Basic_non_reserved (`upsert, ())}
  | Kw_after  {Basic_non_reserved (`after, ())}
  | Kw_type  {Basic_non_reserved (`type', ())}
  | Kw_translator  {Basic_non_reserved (`translator, ())}
  | Kw_jaas  {Basic_non_reserved (`jaas, ())}
  | Kw_condition  {Basic_non_reserved (`condition, ())}
  | Kw_mask  {Basic_non_reserved (`mask, ())}
  | Kw_access  {Basic_non_reserved (`access, ())}
  | Kw_control  {Basic_non_reserved (`control, ())}
  | Kw_none  {Basic_non_reserved (`none, ())}
  | Kw_data  {Basic_non_reserved (`data, ())}
  | Kw_database  {Basic_non_reserved (`database, ())}
  | Kw_privileges  {Basic_non_reserved (`privileges, ())}
  | Kw_role  {Basic_non_reserved (`role, ())}
  | Kw_schema  {Basic_non_reserved (`schema, ())}
  | Kw_use  {Basic_non_reserved (`use, ())}
  | Kw_repository  {Basic_non_reserved (`repository, ())}
  | Kw_rename  {Basic_non_reserved (`rename, ())}
  | Kw_domain  {Basic_non_reserved (`domain, ())}
  | Kw_usage  {Basic_non_reserved (`usage, ())}
  | Kw_position  {Basic_non_reserved (`position, ())}
  | Kw_current  {Basic_non_reserved (`current, ())}
  | Kw_unbounded  {Basic_non_reserved (`unbounded, ())}
  | Kw_preceding  {Basic_non_reserved (`preceding, ())}
  | Kw_following  {Basic_non_reserved (`following, ())}
  | Kw_listagg  {Basic_non_reserved (`listagg, ())}
  | Kw_explain  {Basic_non_reserved (`explain, ())}
  | Kw_analyze  {Basic_non_reserved (`analyze, ())}
  | Kw_text  {Basic_non_reserved (`text, ())}
  | Kw_format  {Basic_non_reserved (`format, ())}
  | Kw_yaml  {Basic_non_reserved (`yaml, ())}
  | Kw_epoch  {Basic_non_reserved (`epoch, ())}
  | Kw_quarter  {Basic_non_reserved (`quarter, ())}
  | Kw_policy {Basic_non_reserved (`policy, ())}
;;
      (* literals *)
literal:
  | l = signed_numeric_literal { Literal (`numeric l, ()) }
  | l = general_literal { Literal (`general l, ()) }
;;

unsigned_literal:
  | l = unsigned_numeric_literal { Unsigned_literal (`numeric l, ()) }
  | l = general_literal { Unsigned_literal (`general l, ()) }
;;

general_literal:
  | l = character_string_literal { General_literal (`character l, ()) }
  | l = national_character_string_literal { General_literal (`national l, ()) }
  | l = unicode_character_string_literal { General_literal (`string l, ()) }
  | l = binary_string_literal { General_literal (`binary l, ()) }
  | l = datetime_literal { General_literal (`datetime l, ()) }
  | l = interval_literal { General_literal (`interval l, ()) }
  | l = boolean_literal { General_literal (`boolean l, ()) }
;;

character_string_literal:
| s = Tok_string { Character_string_Literal (s, ()) }
;;

national_character_string_literal:
| s = Tok_national_string { National_character_string_Literal (s, ()) }
;;

unicode_character_string_literal:
| s = Tok_unicode_string { Unicode_character_string_Literal (s, ()) }
;;

binary_string_literal:
| s = Tok_bin_string { Binary_string_Literal (s, ()) }
;;

signed_numeric_literal:
  | Op_plus l = unsigned_numeric_literal { Signed_numeric_literal (Some `plus l, ()) }
  | Op_minus l = unsigned_numeric_literal { Signed_numeric_literal (Some `minus l, ()) }
  | unsigned_numeric_literal { Signed_numeric_literal (None, l, ()) }
;;


unsigned_numeric_literal:
  | l = Tok_exact_numeric_literal { Unsigned_numeric_literal (l, ()) }
  | l = Tok_approximate_numeric_literal { Unsigned_numeric_literal (l, ()) }
;;

unsigned_integer:
| Tok_unsigned_integer { Unsigned_integer ($1, ()) }
;;

signed_integer:
| Op_plus u = unsigned_integer { Signed_integer (Some `plus , u, ()) }
| Op_minus u = unsigned_integer { Signed_integer (Some `minus , u, ()) }
| u = unsigned_integer { Signed_integer (None , u, ()) }
;;
datetime_literal:
  | date_literal { Datetime_literal (`date l, ())}
  | time_literal { Datetime_literal (`time l, ())}
  | timestamp_literal { Datetime_literal (`timestamp l, ())}
;;

date_literal:
  | Kw_date; s = Tok_string { Date_literal (s, ()) }
;;
time_literal:
  | Kw_time s = Tok_string {Time_literal (s, ())}
;;
timestamp_literal:
  | Kw_timestamp s = Tok_string { Timestamp_literal (s, ()) }
;;

interval_literal:
  | Kw_interval sign = option(plus_or_minus) s = interval_string q = interval_qualifier { Interval_literal (sign, s, q, ())}
;;

interval_string:
| Tok_quote s = Tok_string Tok_quote { s }
;;

interval_qualifier:
| f = single_datetime_field { f }
| f = start_field Kw_to e = end_field { Interval_qualifier (`start_end (f, e), ()) }
;;

start_field:
  | f = non_second_primary_datetime_field { (f, None) }
  | f = non_second_primary_datetime_field Tok_lparen prec = unsigned_integer Tok_rparen { (f, Some prec) }
;;

end_field:
  | f = non_second_primary_datetime_field { `primary f }
  | Kw_second Tok_lparen prec = unsigned_integer Tok_rparen { `second (Some prec) }
;;

single_datetime_field:
  | f = non_second_primary_datetime_field { Interval_qualifier (`single (`primary (f, None)), ()) }
  | f = non_second_primary_datetime_field Tok_lparen prec = unsigned_integer;
    Tok_rparen {
        Interval_qualifier (`single (`primary (f, Some prec)), ())
      }
  | Kw_second Tok_lparen prec = unsigned_integer Tok_rparen { Interval_qualifier (`single (`second (Some prec, None)), ()) }
  | Kw_second Tok_lparen prec = unsigned_integer Tok_comma seconds_prec = unsigned_integer Tok_rparen
                                                                            {
                                                                              Interval_qualifier (`single (`second (Some prec, Some seconds_prec)), ())
                                                                            }
;;

non_second_primary_datetime_field:
  | Kw_year { `year }
  | Kw_month { `month }
  | Kw_day { `day }
  | Kw_hour { `hour }
  | Kw_minute { `minute }
;;

boolean_literal:
  | Kw_true {Boolean_literal (`true', ())}
  | Kw_false {Boolean_literal (`false', ())}
  | Kw_unknown {Boolean_literal (`unknown, ())}
;;

identifier:
  | Tok_ident { Identifier (`literal $1, ())}
  | non_reserved_identifier { Identifier (`non_reserved $1, ())}
;;
