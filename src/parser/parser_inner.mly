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
%token Kw_module
%token Kw_collate
%token Kw_cube
%token Kw_grouping
%token Kw_sets
%token Kw_ties
%token Kw_others
%token Kw_window
%token Kw_using
%token Kw_natural

%token Tok_eof

%start <Types.Entry.t list> entries
%%

entries:
  | separated_nonempty_list(Tok_semicolon, entry) Tok_eof { $1 }
;;

entry:
                 | query_specification { $1 }
;;

(** Start 5.3 literal *)
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

(** End   5.3 literal *)

(** Start names and identifiers *)
identifier:
  | Tok_ident { Identifier (`literal $1, ())}
;;

%inline column_name:
   | i = identifier { i }
;;

identifier_chain:
| i = identifier l = list(identifier) {Identifier_chain (i, l, ())}
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

schema_qualified_name:
| s = option(pair(schema_name, Tok_period)) i = identifier {Schema_qualified_name (Option.fst s, i, ())}
;;

collate_name:
| i = schema_qualified_name {Collate_name (i, ())}
;;

column_reference:
| c = identifier_chain {Column_reference (`chain c, ())}
| Kw_module Tok_period i = identifier Tok_period n = identifier {Column_reference (`module' (i, n), ())}
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

(** Start 7.7 joined table *)
outer_join_type:
| Kw_left { Outer_join_type (`left, ()) }
| Kw_right { Outer_join_type (`right, ()) }
| Kw_full { Outer_join_type (`full, ()) }
;;

join_type:
| Kw_inner { Join_type (`inner, ()) }
| t = outer_join_type option(Kw_outer) { Join_type (`outer t, ()) }
;;

join_column_list:
| c = column_name_list { Join_column_list (c, ()) }
;;

named_columns_join:
| Kw_using v = delimited(Tok_lparen, join_column_list, Tok_rparen) { Named_columns_join (v, ()) }
;;

join_condition:
| Kw_on v = search_condition { Join_condition (v, ()) }
;;

join_specification:
| v = join_condition { Join_specification (`cond v, ()) }
| v = named_columns_join { Join_specification (`named v, ()) }
;;

union_join:
| r = table_reference Kw_union Kw_join t = table_primary { Union_join (r, t, ()) }
;;

cross_join:
| r = table_reference Kw_cross Kw_join t = table_primary { Cross_join (r, t, ()) }
;;

natural_join:
| r = table_reference Kw_natural jt = option(join_type) Kw_join t = table_primary { Natural_join (r,jt, t, ()) }
;;

qualified_join:
| r = table_reference jt = option(join_type) Kw_join t = table_primary; spec = join_specification { Qualified_join (r,jt, t, spec, ()) }
;;

joined_table:
| v = cross_join {Joined_table (`cross v, _)}
| v = qualified_join {Joined_table (`qualified v, _)}
| v = natural_join {Joined_table (`natural v, _)}
| v = union_join {Joined_table (`union v, _)}
;;

(** End   7.7 joined table *)

(** Start 7.8 where clause *)
where_clause:
| Kw_where s = search_condition {Where_clause (s, ())}
;;
(** End   7.8 where clause *)

(** Start 7.9 Group by clause *)
group_by_clause:
| Kw_group Kw_by l = grouping_element_list {Group_by_clause (None, l, ())}
| Kw_group Kw_by Kw_all l = grouping_element_list {Group_by_clause (Some `All, l, ())}
| Kw_group Kw_distinct l = grouping_element_list {Group_by_clause (Some `Distinct, l, ())}
;;

grouping_element:
| v = ordinary_grouping_set { Grouping_element (`ordinary v, ()) }
| v = rollup_list { Grouping_element (`rollup v, ()) }
| v = cube_list { Grouping_element (`cube v, ()) }
| v = grouping_sets_specification { Grouping_element (`spec v, ()) }
| v = empty_grouping_set { Grouping_element (`empty v, ()) }
;;
grouping_element_list:
| c = grouping_element l = list(pair(Tok_comma, grouping_element)) { Grouping_element_list (c, List.map snd l, ()) }
;;

grouping_column_reference:
| c = column_reference collate = option(collate_clause) {Grouping_column_reference (c, collate, ())}
;;

grouping_column_reference_list:
| c = grouping_column_reference;
  l = list(pair(Tok_comma, grouping_column_reference)) {Grouping_column_reference_list (c, List.map snd l, ())}
;;

ordinary_grouping_set:
| c = grouping_column_reference {Ordinary_grouping_set (`column c, ())}
| l = delimited(Tok_lparen, grouping_column_reference_list, Tok_rparen) {Ordinary_grouping_set (`list l, ())}
;;

ordinary_grouping_set_list:
| fe = ordinary_grouping_set l = list(pair(Tok_comma, ordinary_grouping_set)) {Ordinary_grouping_set_list (fe, List.map snd l, ())}
;;

rollup_list:
| Kw_rollup l = delimited(Tok_lparen, ordinary_grouping_set_list, Tok_rparen) { Rollup_list (l, ()) }
;;

cube_list:
| Kw_cube l = delimited(Tok_lparen, ordinary_grouping_set_list, Tok_rparen) { Cube_list (l, ()) }
;;

grouping_set:
| v = ordinary_grouping_set { Grouping_set (`ordinary v, ()) }
| v = rollup_list { Grouping_set (`rollup v, ()) }
| v = cube_list { Grouping_set (`cube v, ()) }
| v = grouping_sets_specification { Grouping_set (`spec v, ()) }
| v = empty_grouping_set { Grouping_set (`empty v, ()) }
;;

grouping_set_list:
| fe = grouping_set l = list(pair(Tok_comma, grouping_set)) {Grouping_set_list (fe, List.map snd l, ())}
;;

grouping_sets_specification:
| Kw_grouping Kw_sets l = delimited(Tok_lparen, grouping_set_list, Tok_rparen) {Grouping_sets_specification (l, ())}
;;

empty_grouping_set:
| Tok_lparen Tok_rparen { Empty_grouping_set () }
;;
(** End   7.9 Group by clause *)

(** Start 7.10 having clause *)
having_clause:
| Kw_having e = search_condition {Having_clause (e, ())}
;;
(** End   7.10 having clause *)

(** Start 7.11 Window clause *)
new_window_name:
| i = identifier { New_window_name (i, ()) }
;;

existing_window_name:
| i = identifier { Existing_window_name (i, ()) }
;;

window_partition_column_reference:
| c = column_reference collate = option(collate_clause) { Window_partition_column_reference (c, collate, ()) }
;;

window_partition_column_reference_list:
| fe = window_partition_column_reference;
  list = list(pair(Tok_comma, window_partition_column_reference)) {
             Window_partition_column_reference_list (fe, List.map snd l, ())
           }
;;

window_partition_clause:
| Kw_partition Kw_by l = window_partition_column_reference_list {Window_partition_clause (l, ())}
;;

window_frame_units:
| Kw_rows { Window_frame_units (`rows, ()) }
| Kw_range { Window_frame_units (`range, ()) }
;;

window_frame_exclusion:
| Kw_exclude Kw_current Kw_row { Window_frame_exclusion (`current_row, ()) }
| Kw_exclude Kw_group { Window_frame_exclusion (`group, ()) }
| Kw_exclude Kw_ties { Window_frame_exclusion (`ties, ()) }
| Kw_exclude Kw_no Kw_others { Window_frame_exclusion (`no_others, ()) }
;;

window_frame_following:
  | v = unsigned_value_specification Kw_following {Window_frame_following (v, _)}
;;

window_frame_bound_1:
  | v = window_frame_bound {Window_frame_bound_1 (v, _)}
;;

window_frame_bound_2:
  | v = window_frame_bound {Window_frame_bound_2 (v, _)}
;;

window_frame_preceding:
  | v = unsigned_value_specification Kw_preceding {Window_frame_preceding (v, _)}
;;

window_frame_between:
  | Kw_between b1 = window_frame_bound_1 Kw_and b2= window_frame_bound_2 {Window_frame_between (b1, b2, _)}
;;

window_frame_start:
  | Kw_unbounded Kw_preceding {Window_frame_start (`unbounded, _)}
  | v = window_frame_preceding {Window_frame_start (`preceding v, _)}
  | Kw_current Kw_row {Window_frame_start (`current, _)}
;;

window_frame_bound:
  | v = window_frame_start {Window_frame_bound (`start v, _)}
  | Kw_unbounded Kw_following {Window_frame_bound (`unbounded, _)}
  | v = window_frame_following {Window_frame_bound (`following v, _)}
;;

window_frame_extent:
  | v = window_frame_start {Window_frame_extent (`start v, _)}
  | v = window_frame_between {Window_frame_extent (`between v, _)}
;;

window_frame_clause:
  | v = delimited(Tok_lparen ,window_specification_detail, Tok_rparen) {Window_specification (v, _)}

window_specification_detail:
  | v = option(identifier);
    partition = option(window_partition_clause);
    order = option(window_order_clause);
    frame = option(window_frame_clause);
    { Window_specification_detail (v, partition, order, frame, _) }
;;

window_order_clause:
  | Kw_order Kw_by v = sort_specification_list {Window_order_clause (v, _)}
;;

window_definition:
  | name = new_window_name Kw_as spec = window_specification {Window_definition (name, spec, _)}
;;

window_definition_list:
  | fl = window_definition;
    list = list(pair(Tok_comma, window_definition)) {Window_definition_list (fl, List.map snd list, _)}
;;

window_clause:
| Kw_window list = window_definition_list {Window_clause (list, _)}
;;

(** End   7.11 Window clause *)


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

(** Start 7.13 query expression *)
corresponding_column_list:
| l = column_name_list { Corresponding_column_list (l, ()) }
;;
(** End   7.13 query expression *)

(** Start 7.15 subquery *)
scalar_subquery:
| q = subquery {Scalar_subquery (q, ())}
;;

row_subquery:
| q = subquery {Row_subquery (q, ())}
;;

table_subquery:
| q = subquery {Table_subquery (q, ())}
;;

subquery:
| q = delimited(Tok_lparen, query_expression, Tok_rparen) {Subquery (q, ())}
;;

(** End   7.15 subquery *)

(** Start 8.19 Search condition *)
search_condition:
| e = boolean_value_expression {Search_condition (e, ())}
;;
(** End   8.19 Search condition *)

(** Start 10.7 collate clause *)
collate_clause:
| Kw_collate n = collate_name {Collate_clause (n, ())}
;;
(** End   10.7 collate clause *)

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
