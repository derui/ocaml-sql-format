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
%token Op_dereference

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
%token Kw_corresponding
%token Kw_recursive
%token Kw_cycle
%token Kw_default
%token Kw_set
%token Kw_depth
%token Kw_breadth
%token Kw_search
%token Kw_values
%token Kw_value
%token Kw_element
%token Kw_zone
%token Kw_local
%token Kw_at
%token Kw_abs
%token Kw_array
%token Kw_multiset
%token Kw_localtime
%token Kw_localtimestamp
%token Kw_characters
%token Kw_code_units
%token Kw_octets
%token Kw_without
%token Kw_scope
%token Kw_ref
%token Kw_precision
%token Kw_numeric
%token Kw_dec
%token Kw_int
%token Kw_binary
%token Kw_large
%token Kw_national
%token Kw_varying
%token Kw_character
%token Kw_nchar
%token Kw_nclob
%token Kw_collation
%token Kw_indicator
%token Kw_system_user
%token Kw_current_default_transform_group
%token Kw_current_path
%token Kw_current_role
%token Kw_current_transform_group_for_type
%token Kw_nullif
%token Kw_coalesce
%token Kw_exclude
%token Kw_current_user

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
  | Kw_interval sign = option(sign) s = interval_string q = interval_qualifier { Interval_literal (sign, s, q, ())}
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

sign:
  |Op_plus {`plus}
  |Op_minus {`minus}
;;

(** End   5.3 literal *)

(** Start names and identifiers *)
identifier:
  | Tok_ident { Identifier (`literal $1, ())}
;;

%inline column_name:
   | i = identifier { i }
;;

domain_name:
| s = schema_qualified_name {s}
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

field_name:
| i = identifier { i }
;;

host_parameter_name:
| Tok_colon i = identifier { Host_parameter_name (i, ())}
;;
(** End   names and identifiers *)

(** Start 6.1 data type *)
time_fractional_seconds_precision:
| e = unsigned_integer {Time_fractional_seconds_precision (e, ())}
;;

timestamp_precision:
| e = time_fractional_seconds_precision {Timestamp_precision (e, ())}
;;

time_precision:
| e = time_fractional_seconds_precision {Time_precision (e, ())}
;;

length:
| e = unsigned_integer {Length (e, ())}
;;

boolean_type:
| Kw_boolean {Boolean_type ()}
;;

scale:
  | e = unsigned_integer {Scale (e, ())}
;;

precision:
| e = unsigned_integer {Precision (e, ())}
;;

char_length_units:
| Kw_characters {Char_length_units (`char, ())}
| Kw_code_units {Char_length_units (`code, ())}
| Kw_octets {Char_length_units (`octets, ())}
;;

with_or_without_time_zone:
  |Kw_with Kw_time Kw_zone {With_or_without_time_zone (`with' ,())}
  |Kw_without Kw_time Kw_zone {With_or_without_time_zone (`without ,())}
;;

interval_type:
  | Kw_interval q = interval_qualifier {Interval_type (q, ())}
;;

path_resolved_user_defined_type_name:
| e = schema_qualified_name {Path_resolved_user_defined_type_name (e, ())}
;;

referenced_type:
| e = path_resolved_user_defined_type_name {Referenced_type (e, ())}
;;

scope_clause:
| Kw_scope e =table_name {Scope_clause (e, ())}
;;

reference_type:
| Kw_ref e = delimited(Tok_lparen, referenced_type, Tok_rparen) s = option(scope_clause) {Reference_type (e, s, ())}
;;

array_type:
| t = data_type Kw_array u = delimited(Tok_lsbrace, unsigned_integer, Tok_rsbrace) {Array_type (t, u, ())}
;;

multiset_type:
| t = data_type Kw_multiset {Multiset_type (t, ())}
;;

collection_type:
| e =array_type {Collection_type (`array e, ())}
| e =multiset_type {Collection_type (`multiset e, ())}
;;

datetime_type:
| Kw_date {Datetime_type (`date, ())}
| Kw_time e = option(delimited(Tok_lparen, time_precision, Tok_rparen));
  t = option(with_or_without_time_zone) {
          Datetime_type (`time (e, t), ())
        }
| Kw_timestamp e = option(delimited(Tok_lparen, timestamp_precision, Tok_rparen));
  t = option(with_or_without_time_zone) {
          Datetime_type (`timestamp (e, t), ())
        }
;;

large_object_length:
| u = unsigned_integer; v = option(Tok_ident);
  unit = option(char_length_units) { Large_object_length (u, Option.map (function
                                                                 | "k" | "K" -> `k
                                                                 | "m" | "M" -> `m
                                                                 | "g" | "G" -> `g
                                                                 | _ -> failwith "Invalid multiplier") v, unit, ()) }
;;

row_type:
| Kw_row v = row_type_body {Row_type (v, ())}
;;

row_type_body:
| Tok_lparen fl = field_definition; list = list(pair(Tok_comma, field_definition));
  Tok_rparen {
      Row_type_body (fl, List.map snd list, ())
    }
;;

approximate_numeric_type:
|Kw_float v = option(delimited(Tok_lparen, precision, Tok_rparen)) {Approximate_numeric_type (`float v, ())}
|Kw_real {Approximate_numeric_type (`real, ())}
|Kw_double Kw_precision {Approximate_numeric_type (`double, ())}
;;

exact_numeric_type:
| Kw_numeric {Exact_numeric_type (`numeric None, ())}
| Kw_numeric v = delimited(Tok_lparen, precision, Tok_rparen) {Exact_numeric_type (`numeric (Some (v, None)), ())}
| Kw_numeric Tok_lparen v = precision;
  Tok_comma s = scale Tok_rparen {Exact_numeric_type (`numeric (Some (v, Some s)), ())}
| Kw_decimal {Exact_numeric_type (`decimal None, ())}
| Kw_decimal v = delimited(Tok_lparen, precision, Tok_rparen) {Exact_numeric_type (`decimal (Some (v, None)), ())}
| Kw_decimal Tok_lparen v = precision;
  Tok_comma s = scale Tok_rparen {Exact_numeric_type (`decimal (Some (v, Some s)), ())}
| Kw_dec {Exact_numeric_type (`dec None, ())}
| Kw_dec v = delimited(Tok_lparen, precision, Tok_rparen) {Exact_numeric_type (`dec (Some (v, None)), ())}
| Kw_dec Tok_lparen v = precision;
  Tok_comma s = scale Tok_rparen {Exact_numeric_type (`dec (Some (v, Some s)), ())}

| Kw_smallint {Exact_numeric_type (`smallint, ())}
| Kw_integer {Exact_numeric_type (`integer, ())}
| Kw_int {Exact_numeric_type (`int, ())}
| Kw_bigint {Exact_numeric_type (`bigint, ())}
;;

numeric_type:
  | e = exact_numeric_type {Numeric_type (`exact e, ())}
  | e = approximate_numeric_type {Numeric_type (`approximate e, ())}
;;

binary_large_object_string_type:
| Kw_binary Kw_large Kw_object;
  v = option(delimited(Tok_lparen, large_object_length, Tok_rparen)) {Binary_large_object_string_type (`long, v, ())}
| Kw_blob;
  v = option(delimited(Tok_lparen, large_object_length, Tok_rparen)) {Binary_large_object_string_type (`short, v, ())}
;;

national_character_string_type:
| Kw_national Kw_character;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {National_character_string_type (`character v, ())}
| Kw_national Kw_char;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {National_character_string_type (`char v, ())}
| Kw_nchar;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {National_character_string_type (`nchar v, ())}
| Kw_national Kw_character Kw_varying;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {National_character_string_type (`character_varying v, ())}
| Kw_national Kw_char Kw_varying;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {National_character_string_type (`char_varying v, ())}
| Kw_national Kw_character Kw_large Kw_object;
  v = option(delimited(Tok_lparen, large_object_length, Tok_rparen)) {National_character_string_type (`character_large_object v, ())}
| Kw_national Kw_char Kw_large Kw_object;
  v = option(delimited(Tok_lparen, large_object_length, Tok_rparen)) {National_character_string_type (`char_large_object v, ())}
| Kw_nclob;
  v = option(delimited(Tok_lparen, large_object_length, Tok_rparen)) {National_character_string_type (`nclob v, ())}
;;

character_string_type:
| Kw_character;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {Character_string_type (`character v, ())}
| Kw_char;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {Character_string_type (`char v, ())}
| Kw_character Kw_varying;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {Character_string_type (`character_varying v, ())}
| Kw_char Kw_varying;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {Character_string_type (`char_varying v, ())}
| Kw_varchar;
  v = option(delimited(Tok_lparen, length, Tok_rparen)) {Character_string_type (`varchar v, ())}
| Kw_character Kw_large Kw_object;
  v = option(delimited(Tok_lparen, large_object_length, Tok_rparen)) {Character_string_type (`character_large_object v, ())}
| Kw_char Kw_large Kw_object;
  v = option(delimited(Tok_lparen, large_object_length, Tok_rparen)) {Character_string_type (`char_large_object v, ())}
| Kw_clob;
  v = option(delimited(Tok_lparen, large_object_length, Tok_rparen)) {Character_string_type (`clob v, ())}
;;

predefined_type:
| t = character_string_type; c = option(collate_clause) { Predefined_type (`character (t, (), c), ()) }
| t = national_character_string_type; c = option(collate_clause) { Predefined_type (`national_character (t, (), c), ()) }
| t = binary_large_object_string_type { Predefined_type (`blob t, ()) }
| t = numeric_type { Predefined_type (`numeric t, ()) }
| t = boolean_type { Predefined_type (`boolean t, ()) }
| t = datetime_type { Predefined_type (`datetime t, ()) }
| t = interval_type { Predefined_type (`interval t, ()) }
;;

data_type:
| t = predefined_type {Data_type (`predefined t, ())}
| t = row_type {Data_type (`row t, ())}
| t = path_resolved_user_defined_type_name {Data_type (`path t, ())}
| t = reference_type {Data_type (`ref t, ())}
| t = collection_type {Data_type (`collection t, ())}
;;
(** End   6.1 data type *)

(** Start 6.2 field definition *)
field_definition:
| name = field_name d = data_type {Field_definition (name, d, (), ())}
;;
(** End   6.2 field definition *)

(** Start 6.3 value expression primary *)
value_expression_primary:
| e = parenthesized_value_expression {Value_expression_primary (`paren e, ())}
| e = nonparenthesized_value_expression_primary {Value_expression_primary (`non_paren e, ())}
;;

parenthesized_value_expression:
| Tok_lparen e = value_expression Tok_rparen {Parenthesized_value_expression (e, ())}
;;

nonparenthesized_value_expression_primary:
| e = column_reference {Nonparenthesized_value_expression_primary (`column e, ())}
| e = next_value_expression {Nonparenthesized_value_expression_primary (`next e, ())}
| e = field_reference {Nonparenthesized_value_expression_primary (`field e, ())}
| e = attribute_or_method_reference {Nonparenthesized_value_expression_primary (`attribute e, ())}
| e = array_element_reference {Nonparenthesized_value_expression_primary (`array e, ())}
| e = multiset_element_reference {Nonparenthesized_value_expression_primary (`multiset e, ())}
| e = window_function {Nonparenthesized_value_expression_primary (`window e, ())}
| e = set_function_specification {Nonparenthesized_value_expression_primary (`set_function e, ())}
| e = case_expression {Nonparenthesized_value_expression_primary (`case e, ())}
| e = cast_specification {Nonparenthesized_value_expression_primary (`cast e, ())}
;;
(** End   6.3 value expression primary *)

(** Start 6.4 value specification and target specification *)
current_collation_specification:
| Kw_current Kw_collation;
  e = delimited(Tok_lparen, string_value_expression, Tok_rparen) {Current_collation_specification (e, ())}
;;

target_array_reference:
| e = sql_parameter_reference {Target_array_reference (`sql e, ())}
| e = column_reference {Target_array_reference (`col e, ())}
;;

target_array_element_specification:
|r = target_array_reference;
 v = delimited(Tok_lsbrace, simple_value_specification, Tok_rsbrace) { Target_array_element_specification (r, v, ()) }
;;

dynamic_parameter_specification:
| Tok_qmark { Dynamic_parameter_specification () }
;;

host_parameter_specification:
  | n = host_parameter_name {Host_parameter_specification (n, ())}
;;

simple_target_specification:
| e = host_parameter_specification {Simple_target_specification (`host e, ())}
| e = sql_parameter_reference {Simple_target_specification (`sql e, ())}
| e = column_reference {Simple_target_specification (`col e, ())}
;;

target_specification:
| e = host_parameter_specification {Target_specification (`host e, ())}
| e = sql_parameter_reference {Target_specification (`sql e, ())}
| e = column_reference {Target_specification (`col e, ())}
| e = target_array_element_specification {Target_specification (`array_element e, ())}
| e = dynamic_parameter_specification {Target_specification (`dynamic e, ())}
;;

simple_value_specification:
| e = literal {Simple_value_specification (`literal e, ())}
| e = host_parameter_name {Simple_value_specification (`host e, ())}
| e = sql_parameter_reference {Simple_value_specification (`sql e, ())}
;;

general_value_specification:
| e = host_parameter_specification { General_value_specification (`host e, ()) }
| e = sql_parameter_reference { General_value_specification (`sql e, ()) }
| e = dynamic_parameter_specification { General_value_specification (`dynamic e, ()) }
| e = current_collation_specification { General_value_specification (`current_collation e, ()) }
| Kw_current_default_transform_group { General_value_specification (`default_transform_group, ()) }
| Kw_current_path { General_value_specification (`path, ()) }
| Kw_current_role { General_value_specification (`role, ()) }
| Kw_current_transform_group_for_type;
  e = path_resolved_user_defined_type_name { General_value_specification (`transform_group_for_type e, ()) }
| Kw_current_user { General_value_specification (`current_user, ()) }
| Kw_session_user { General_value_specification (`session_user, ()) }
| Kw_system_user { General_value_specification (`system_user, ()) }
| Kw_user { General_value_specification (`user, ()) }
| Kw_value { General_value_specification (`value, ()) }
;;

unsigned_value_specification:
  | e = unsigned_literal {Unsigned_value_specification (`literal e, ())}
  | e = general_value_specification {Unsigned_value_specification (`general e, ())}
;;

value_specification:
  | e = literal {Value_specification (`literal e, ())}
  | e = general_value_specification {Value_specification (`general e, ())}
;;
(** End   6.4 value specification and target specification *)

(** Start 6.5 contextually typed value specification *)
default_specification:
| Kw_default {Default_specification () }
;;

null_specification:
| Kw_null {Null_specification () }
;;

empty_specification:
  | Kw_array Tok_lsbrace Tok_rsbrace {Empty_specification (`array, ())}
  | Kw_multiset Tok_lsbrace Tok_rsbrace {Empty_specification (`multiset, ())}
;;

implicit_typed_value_specification:
  |e = null_specification {Implicit_typed_value_specification (`null e, ())}
  |e = empty_specification {Implicit_typed_value_specification (`empty e, ())}
;;

contextually_typed_value_specification:
| e = implicit_typed_value_specification {Contextually_typed_value_specification (`implicit e, ())}
| e = default_specification {Contextually_typed_value_specification (`default e, ())}
;;
(** End   6.5 contextually typed value specification *)

(** Start 6.6 identifier chain *)
identifier_chain:
| i = identifier l = list(identifier) {Identifier_chain (i, l, ())}
;;
(** End   6.6 identifier chain *)

(** Start 6.7 column reference *)
column_reference:
| c = identifier_chain {Column_reference (`chain c, ())}
| Kw_module Tok_period i = identifier Tok_period n = identifier {Column_reference (`module' (i, n), ())}
;;
(** End   6.7 column reference *)

(** Start 6.8 sql parameter reference *)
sql_parameter_reference:
| e = identifier_chain {Sql_parameter_reference (e, ())}
;;
(** End   6.8 sql parameter reference *)

(** Start 6.9 set function specification *)
set_function_specification:
| e = grouping_operation {Set_function_specification (`grouping e, ())}
;;

grouping_operation:
| Kw_grouping Tok_lparen fl = column_reference;
  list = list(pair(Tok_comma, column_reference));
  Tok_rparen {Grouping_operation (fl, list, ())}
;;
(** End   6.9 set function specification *)

(** Start 6.10 window function *)
window_name_or_specification:
| e = identifier {Window_name_or_specification (`name e, ())}
| e = window_specification {Window_name_or_specification (`spec e, ())}
;;

rank_function_type:
| Kw_rank { Rank_function_type (`rank, ())}
| Kw_dense_rank { Rank_function_type (`dense_rank, ())}
| Kw_percent_rank { Rank_function_type (`percent_rank, ())}
| Kw_cume_dist { Rank_function_type (`cume_dist, ())}
;;

window_function_type:
| e = rank_function_type Tok_lparen Tok_rparen { Window_function_type (`rank e, ())}
| Kw_row_number Tok_lparen Tok_rparen { Window_function_type (`row_number, ())}
;;

window_function:
  | typ = window_function_type Kw_over w = window_name_or_specification {Window_function (typ, w, ())}
;;

(** End   6.10 window function *)

(** Start 6.11 case expression *)
case_expression:
| e = case_specification {Case_expression (`spec e, ())}
| e = case_abbreviation {Case_expression (`abbrev e, ())}
;;

case_abbreviation:
| Kw_nullif Tok_lparen;
  first = value_expression; Tok_comma; second = value_expression;
  Tok_rparen {Case_abbreviation (`nullif (first ,second), ())}
| Kw_coalesce Tok_lparen;
  first = value_expression; list = list(pair(Tok_comma, value_expression));
  Tok_rparen {Case_abbreviation (`coalesce (first ,list), ())}
;;

case_specification:
| e = simple_case {Case_specification (`simple e, ())}
| e = searched_case {Case_specification (`searched e, ())}
;;

simple_case:
| Kw_case c = case_operand;
  list = nonempty_list(simple_when_clause);
  els = option(else_clause) Kw_end {Simple_case (c, list, els, ())}
;;

searched_case:
| Kw_case fl = nonempty_list(searched_when_clause) e = option(else_clause) Kw_end {
                                                           Searched_case (fl, e, ())
                                                         }
;;

simple_when_clause:
| Kw_when e = when_operand Kw_then r = result {Simple_when_clause (e, r, ())}
;;

searched_when_clause:
| Kw_when e = search_condition Kw_then r = result {Searched_when_clause (e, r, ())}
;;

else_clause:
| Kw_else e = result {Else_clause (e, ())}
;;

case_operand:
| e = row_value_predicand {Case_operand (`row e, ())}
;;

when_operand:
| e = row_value_predicand {When_operand (`row e, ())}
;;

result:
| e = result_expression {Result (`expr e, ())}
| Kw_null {Result (`null, ())}
;;

result_expression:
| e = value_expression {Result_expression (e, ())}
;;
(** End   6.11 case expression *)

(** Start 6.12 cast specification *)
cast_specification:
| Kw_cast Tok_lparen;
  operand = cast_operand;
  Kw_as;
  target = cast_target;
  Tok_rparen {Cast_specification (operand, target, ())}
;;

cast_operand:
| v = value_expression {Cast_operand (`expr v, ())}
| v = implicit_typed_value_specification {Cast_operand (`implicit v, ())}
;;

cast_target:
| v = domain_name {Cast_target (`domain v, ())}
| v = data_type {Cast_target (`data v, ())}
;;
(** Start 6.12 cast specification *)

(** Start 6.13 next value expression *)
next_value_expression:
|Kw_next Kw_value Kw_for e = schema_qualified_name {Next_value_expression (e, ())}
;;
(** End   6.13 next value expression *)
(** Start 6.14 field reference *)
field_reference:
| e = value_expression_primary Tok_period name = identifier {Field_reference (e, name, ())}
;;
(** End   6.14 field reference *)

(** Start 6.19 attribute or method reference *)
attribute_or_method_reference:
  v = value_expression_primary Op_minus Op_gt i = identifier arg = option(sql_argument_list) {Attribute_or_method_reference (v, i, arg, ())}
;;
(** End   6.19 attribute or method reference *)

(** Start 6.23 array element reference *)
array_element_reference:
| e = array_value_expression Tok_lsbrace i = numeric_value_expression Tok_rsbrace {Array_element_reference (e, i, ())}
;;
(** End   6.23 array element reference *)

(** Start 6.24 multiset element reference *)
multiset_element_reference:
| Kw_element e = delimited(Tok_lparen, multiset_element_reference, Tok_rparen) {Multiset_element_reference (e, ())}
;;
(** End   6.24 multiset element reference *)

(** Start 6.25 value expression *)
value_expression:
| e = common_value_expression {Value_expression (`common e, ())}
| e = boolean_value_expression {Value_expression (`boolean e, ())}
| e = row_value_expression {Value_expression (`row e, ())}
;;

common_value_expression:
| e = numeric_value_expression {Common_value_expression (`numeric e, ())}
| e = string_value_expression {Common_value_expression (`string e, ())}
| e = datetime_value_expression {Common_value_expression (`datetime e, ())}
| e = interval_value_expression {Common_value_expression (`interval e, ())}
| e = user_defined_type_value_expression {Common_value_expression (`user_defined e, ())}
| e = reference_value_expression {Common_value_expression (`reference e, ())}
| e = collection_value_expression {Common_value_expression (`collection e, ())}
;;

user_defined_type_value_expression:
| e = value_expression_primary {User_defined_type_value_expression (e, ())}
;;

reference_value_expression:
| e = value_expression_primary {Reference_value_expression (e, ())}
;;

collection_value_expression:
| e = array_value_expression {Collection_value_expression (`array e, ())}
| e = multiset_value_expression {Collection_value_expression (`multiset e, ())}
;;

collection_value_constructor:
| e = array_value_constructor {Collection_value_constructor (`array e, ())}
| e = multiset_value_constructor {Collection_value_constructor (`multiset e, ())}
;;
(** End   6.25 value expression *)

(** Start 6.26 numeric value expression *)
numeric_primary:
| e = value_expression_primary {Numeric_primary (`primary e, ())}
;;

factor:
| sign = option(sign) e = numeric_primary {Factor (sign, e, ())}
;;

term:
| v = factor {Term (`single v, ())}
| v1 = factor Op_star v2 = factor {Term (`asterisk (v1, v2), ())}
| v1 = factor Op_slash v2 = factor {Term (`solidus (v1, v2), ())}
;;

numeric_value_expression:
| v = term {Numeric_value_expression (`single v, ())}
| v1 = numeric_value_expression Op_plus v2 = term {Numeric_value_expression (`plus (v1, v2), ())}
| v1 = numeric_value_expression Op_minus v2 = term {Numeric_value_expression (`minus (v1, v2), ())}
;;
(** End   6.26 numeric value expression *)

(** Start 6.28 string value expression *)
string_value_expression:
| e = character_value_expression {String_value_expression (e, ())}
;;

character_value_expression:
| e = concatenation {Character_value_expression (`concat e, ())}
| e = character_factor {Character_value_expression (`factor e, ())}
;;

concatenation:
| e = character_value_expression; Op_concat c = character_factor {Concatenation (e, c, ())}
;;

character_factor:
| e = character_primary; c = option(collate_clause) {Character_factor (e, c, ())}
;;

character_primary:
| e = value_expression_primary {Character_primary (`primary e, ())}
;;
(** End   6.28 string value expression *)

(** Start 6.30 datetime value expression *)
datetime_value_expression:
| e = datetime_term {Datetime_value_expression (`term e, ())}
| e = interval_value_expression; Op_plus term = datetime_term {Datetime_value_expression (`plus_interval e, ())}
| e = datetime_value_expression; Op_plus term = interval_term {Datetime_value_expression (`plus_datetime e, ())}
| e = datetime_value_expression; Op_minus term = interval_term {Datetime_value_expression (`minus e, ())}
;;

datetime_term:
| e = datetime_factor {Datetime_term (e, ())}
;;

datetime_factor:
| e = datetime_primary; s = option(time_zone_specifier) {Datetime_factor (e, s, ())}
;;

datetime_primary:
| e = value_expression_primary {Datetime_primary (`value e, ())}
| e = datetime_value_function {Datetime_primary (`function' e, ())}
;;

time_zone:
| Kw_at e = time_zone_specifier {Time_zone (e, ())}
;;

time_zone_specifier:
| Kw_local {Time_zone_specifier (`local, ())}
| Kw_time Kw_zone e = interval_primary {Time_zone_specifier (`time_zone e, ())}
;;
(** End   6.30 datetime value expression *)

(** Start 6.31 datetime value function *)
datetime_value_function:
| e = current_date_value_function {Datetime_value_function (`date e, ())}
| e = current_time_value_function {Datetime_value_function (`time e, ())}
| e = current_local_time_value_function {Datetime_value_function (`local_time e, ())}
| e = current_timestamp_value_function {Datetime_value_function (`timestamp e, ())}
| e = current_local_timestamp_value_function {Datetime_value_function (`local_timestamp e, ())}
;;

current_local_timestamp_value_function:
| Kw_localtimestamp e = option(delimited(Tok_lparen, timestamp_precision, Tok_rparen)) {Current_local_timestamp_value_function (e, ())}
;;

current_timestamp_value_function:
| Kw_timestamp e = option(delimited(Tok_lparen, timestamp_precision, Tok_rparen)) {Current_timestamp_value_function (e, ())}
;;

current_local_time_value_function:
| Kw_localtime e = option(delimited(Tok_lparen, time_precision, Tok_rparen)) {Current_local_time_value_function (e, ())}
;;

current_time_value_function:
| Kw_current_time e = option(delimited(Tok_lparen, time_precision, Tok_rparen)) {Current_time_value_function (e, ())}
;;

current_date_value_function:
| Kw_current_date {Current_date_value_function ()}
;;
(** End   6.31 datetime value function *)

(** Start 6.32 interval value expression *)
interval_value_expression:
| f = interval_term {Interval_value_expression (`term f, ())}
| e = interval_value_expression_1 Op_plus t = interval_term_1 {Interval_value_expression (`plus (e, t), ())}
| e = interval_value_expression_1 Op_minus t = interval_term_1 {Interval_value_expression (`minus (e, t), ())}
| Tok_lparen e = datetime_value_expression;
  Op_minus;
  t = datetime_term Tok_rparen;
  iq = interval_qualifier {Interval_value_expression (`qualifier (e, t, iq), ())}
;;

interval_term:
| f = interval_factor {Interval_term (`factor f, ())}
| t = interval_term_2 Op_star f = factor {Interval_term (`asterisk (t, f), ())}
| t = interval_term_2 Op_slash f = factor {Interval_term (`solidus (t, f), ())}
| t = term Op_star f = interval_factor {Interval_term (`term (t, f), ())}
;;

interval_factor:
|s = option(sign); e = interval_primary {Interval_factor (s, e, ())}
;;

interval_primary:
|e = value_expression_primary iq = option(interval_qualifier) {Interval_primary (`value (e, iq), ())}
|e = interval_value_function {Interval_primary (`function' e, ())}
;;

interval_value_expression_1:
|e = interval_value_expression {Interval_value_expression_1 (e, ())}
  ;;

interval_term_1:
|e = interval_term {Interval_term_1 (e, ())}
;;

interval_term_2:
|e = interval_term {Interval_term_2 (e, ())}
;;
(** End   6.32 interval value expression *)

(** Start 6.33 interval value function *)
interval_value_function:
| f = interval_absolute_value_function {Interval_value_function (f, _)}
;;

interval_absolute_value_function:
| Kw_abs e = delimited(Tok_lparen, interval_value_expression, Tok_rparen) {Interval_absolute_value_function (f, _)}
;;
(** End   6.33 interval value function *)

(** Start 6.34 boolean value expression *)
truth_value:
| Kw_true {Truth_value (`true', ())}
| Kw_false {Truth_value (`false', ())}
| Kw_unknown {Truth_value (`unknown, ())}
;;

parenthesized_boolean_value_expression:
  | e = delimited(Tok_lparen, boolean_value_expression, Tok_rparen) {Parenthesized_boolean_value_expression (e, ())}
;;

boolean_predicand:
| e = parenthesized_boolean_value_expression {Boolean_predicand (`paren e, ())}
| e = nonparenthesized_value_expression_primary {Boolean_predicand (`non e, ())}
;;

boolean_primary:
| e = boolean_predicand {Boolean_primary (`predicand e, ())}
;;

boolean_test:
| e = boolean_primary {Boolean_test (e, None, ())}
| e = boolean_primary Kw_is v = truth_value {Boolean_test (e, Some (`is v), ())}
| e = boolean_primary Kw_is Kw_not v = truth_value {Boolean_test (e, Some (`is_not v), ())}
;;

boolean_factor:
| not_ = option(Kw_not) e = boolean_test {Boolean_factor (Option.map (fun _ -> `not') not_, e, ())}
;;

boolean_term:
| e = boolean_factor {Boolean_term (`factor e, ())}
| t = boolean_term Kw_and f = boolean_factor {Boolean_term (`and' (t, f), ())}
;;

boolean_value_expression:
| e = boolean_term {Boolean_value_expression (`term e, ())}
| t = boolean_value_expression Kw_or f = boolean_term {Boolean_value_expression (`or' (t, f), ())}
;;
(** End   6.34 boolean value expression *)

(** Start 6.35 array value expression *)
array_value_expression:
| e = array_factor {Array_value_expression (`factor e, ())}
| e = array_concatenation {Array_value_expression (`concat e, ())}
;;

array_concatenation:
| e = array_value_expression_1 Op_concat f = array_factor {Array_concatenation (e, f, ())}
;;

array_value_expression_1:
| e = array_value_expression {Array_value_expression_1 (e, ())}
;;

array_factor:
| e = value_expression_primary {Array_factor (e, ())}
;;
(** End   6.35 array value expression *)

(** Start 6.36 array value constructor *)
array_value_constructor:
| e = array_value_constructor_by_enumeration { Array_value_constructor (`enum e, ()) }
| e = array_value_constructor_by_query { Array_value_constructor (`query e, ()) }
;;

array_value_constructor_by_enumeration:
| Kw_array e = delimited(Tok_lsbrace, array_element_list, Tok_rsbrace) {Array_value_constructor_by_enumerationg (e, ())}
;;

array_element_list:
| fl = array_element; list = list(pair(Tok_comma, array_element)) {Array_element_list (fl, List.map snd list, ())}
;;

array_element:
| e = value_expression {Array_element (e, ())}
;;

array_value_constructor_by_query:
|Kw_array Tok_lparen q = query_expression o = option(order_by_clause) Tok_rparen {
                                                  Array_value_constructor_by_query (q, o, ())
                                                }
;;
(** End   6.36 array value constructor *)

(** Start 6.37 multiset value expression *)
multiset_value_expression:
| e = multiset_term {Multiset_value_expression (`term e, ())}
| e = multiset_value_expression; Kw_multiset Kw_union; q = option(set_quantifier);
  t = multiset_term {Multiset_value_expression (`union (t, p, q), ())}
;;

multiset_term:
| e = multiset_primary {Multiset_term (`primary e, ())}
| t = multiset_term; Kw_multiset Kw_intersect; q = option(set_quantifier);
  p = multiset_primary {Multiset_term (`intersect (t, p, q), ())}
;;

multiset_primary:
| e = value_expression_primary {Multiset_primary (`value e, ())}
| e = multiset_value_function {Multiset_primary (`function' e, ())}
;;
(** End   6.37 multiset value expression *)

(** Start 6.38 multiset value function *)
multiset_value_function:
|  e = multiset_set_function {Multiset_value_function (e, ())}
;;

multiset_set_function:
| Kw_set e = delimited(Tok_lparen, multiset_value_expression, Tok_rparen) {Multiset_set_function (e, ())}
;;
(** End   6.38 multiset value function *)

(** Start 6.39 multiset value constructor *)
table_value_constructor_by_query:
| Kw_table e = delimited(Tok_lparen, query_expression, Tok_rparen) {Table_value_constructor_by_query (e, ())}
;;

multiset_value_constructor_by_query:
| Kw_multiset e = delimited(Tok_lparen, query_expression, Tok_rparen) {Multiset_value_constructor_by_query (e, ())}
;;

multiset_element:
| e = value_expression {Multiset_element (e, ())}
;;

multiset_element_list:
| fl = multiset_element; list = list(pair(Tok_comma, multiset_element)) {Multiset_element_list (fl, List.map snd list, ())}
;;

multiset_value_constructor_by_enumeration:
| Kw_multiset e = delimited(Tok_lsbrace, multiset_element_list, Tok_rsbrace) {
                      Multiset_value_constructor_by_enumeration (e, ())
                    }
;;

multiset_value_constructor:
| e = multiset_value_constructor_by_enumeration {Multiset_value_constructor (`enum e ,())}
| e = multiset_value_constructor_by_query {Multiset_value_constructor (`multi_query e ,())}
| e = table_value_constructor_by_query {Multiset_value_constructor (`table_query e ,())}
  ;;
(** End   6.39 multiset value constructor *)

(** Start 7.1 row value constructor *)
row_value_constructor:
  | e = common_value_expression {Row_value_constructor (`common e, ())}
  | e = boolean_value_expression {Row_value_constructor (`boolean e, ())}
  | e = explicit_row_value_constructor {Row_value_constructor (`explicit e, ())}
  ;;

explicit_row_value_constructor:
  | Tok_lparen;
    e = row_value_constructor_element;
    Tok_comma;
    list = row_value_constructor_element_list;
    Tok_rparen {Explicit_row_value_constructor (`param (e, list), ())}
  | Kw_row e = delimited(Tok_lparen, row_value_constructor_element_list, Tok_rparen) {
                   Explicit_row_value_constructor (`row e, ())}
  | e = row_subquery {Explicit_row_value_constructor (`subquery e, ())}
  ;;

row_value_constructor_element_list:
  | e = row_value_constructor_element;
    list = list(pair(Tok_comma, row_value_constructor_element)) {row_value_constructor_element_list (e, List.map snd list, ())}
  ;;

row_value_constructor_element:
  | e = value_expression {Row_value_constructor_element (e, ())}
;;

contextually_typed_row_value_constructor:
  | e = common_value_expression {Contextually_typed_row_value_constructor (`common e, ())}
  | e = boolean_value_expression {Contextually_typed_row_value_constructor (`boolean e, ())}
  | e = contextually_typed_value_specification {Contextually_typed_row_value_constructor (`typed_value e, ())}
  | Tok_lparen;
    e = contextually_typed_row_value_constructor_element;
    Tok_comma;
    list = contextually_typed_row_value_constructor_element_list;
    Tok_rparen {Contextually_typed_row_value_constructor (`paren (e, list), ())}
  | Kw_row e = delimited(Tok_lparen, contextually_typed_row_value_constructor_element_list, Tok_rparen) {
                   Contextually_typed_row_value_constructor (`row e, ())}
  ;;

contextually_typed_row_value_constructor_element_list:
  | fl = contextually_typed_row_value_constructor_element;
    list = list(pair(Tok_comma, contextually_typed_row_value_constructor_element)) {
             Contextually_typed_row_value_constructor_element_list (fl, List.map snd list, ())}
  ;;

contextually_typed_row_value_constructor_element:
  | e = value_expression {Contextually_typed_row_value_constructor_element (`expr e, ())}
  | e = contextually_typed_value_specification {Contextually_typed_row_value_constructor_element (`spec e, ())}
;;

row_value_constructor_predicand:
  | e = common_value_expression {Row_value_constructor_predicand (`common e, ())}
  | e = boolean_predicand {Row_value_constructor_predicand (`boolean e, ())}
  | e = explicit_row_value_constructor {Row_value_constructor_predicand (`explicit e, ())}
  ;;

(** End 7.1 row value constructor *)

(** Start 7.2 row value expression *)
row_value_expression:
| v = row_value_special_case { Row_value_expression (`special v, ()) }
| v = explicit_row_value_constructor { Row_value_expression (`explicit v, ()) }
;;

table_row_value_expression:
| v = row_value_special_case { Table_row_value_expression (`special v, ()) }
| v = row_value_constructor { Table_row_value_expression (`row v, ()) }
;;

contextually_typed_row_value_expression:
| v = row_value_special_case { Contextually_typed_row_value_expression (`special v, ()) }
| v = contextually_typed_row_value_constructor { Contextually_typed_row_value_expression (`row v, ()) }
;;

row_value_predicand:
| v = row_value_special_case { Row_value_predicand (`special v, ()) }
| v = row_value_constructor_predicand { Row_value_predicand (`row v, ()) }
;;

row_value_special_case:
| v = nonparenthesized_value_expression_primary { Row_value_special_case (v, ()) }
;;
(** End   7.2 row value expression *)

(** Start 7.3 table value constructor *)
table_value_constructor:
| Kw_values v = row_value_expression_list {Table_value_constructor (v, _)}
;;

row_value_expression_list:
| fl = table_row_value_expression; list = list(pair(Tok_comma, table_row_value_expression)) {Row_value_expression_list (fl, List.map snd list, ())}
;;

contextually_typed_table_value_constructor:
| Kw_values v = contextually_typed_row_value_expression_list {Contextually_typed_table_value_constructor (v, _)}
;;

contextually_typed_row_value_expression_list:
| fl = contextually_typed_row_value_expression; list = list(pair(Tok_comma, contextually_typed_row_value_expression)) {Contextually_typed_row_value_expression_list (fl, List.map snd list, ())}
;;

(** End   7.3 table value constructor *)


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
  | v = unsigned_value_specification Kw_following {Window_frame_following (v, ())}
;;

window_frame_bound_1:
  | v = window_frame_bound {Window_frame_bound_1 (v, ())}
;;

window_frame_bound_2:
  | v = window_frame_bound {Window_frame_bound_2 (v, ())}
;;

window_frame_preceding:
  | v = unsigned_value_specification Kw_preceding {Window_frame_preceding (v, ())}
;;

window_frame_between:
  | Kw_between b1 = window_frame_bound_1 Kw_and b2= window_frame_bound_2 {Window_frame_between (b1, b2, ())}
;;

window_frame_start:
  | Kw_unbounded Kw_preceding {Window_frame_start (`unbounded, ())}
  | v = window_frame_preceding {Window_frame_start (`preceding v, ())}
  | Kw_current Kw_row {Window_frame_start (`current, ())}
;;

window_frame_bound:
  | v = window_frame_start {Window_frame_bound (`start v, ())}
  | Kw_unbounded Kw_following {Window_frame_bound (`unbounded, ())}
  | v = window_frame_following {Window_frame_bound (`following v, ())}
;;

window_frame_extent:
  | v = window_frame_start {Window_frame_extent (`start v, ())}
  | v = window_frame_between {Window_frame_extent (`between v, ())}
;;

window_frame_clause:
  | v = window_frame_units e = window_frame_extent;
    exclusion = option(window_frame_exclusion) {Window_frame_clause (v, e, exclusion, ())}
;;

window_specification:
| e = delimited(Tok_lparen, window_specification_details, Tok_rparen) {Window_specification (e, ())}
  ;;

window_specification_details:
  | v = option(identifier);
    partition = option(window_partition_clause);
    order = option(window_order_clause);
    frame = option(window_frame_clause);
    { Window_specification_details (v, partition, order, frame, _) }
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
  | Kw_select q = option(set_quantifier) l = select_list t = table_expression { Query_specification (q, l, t, ()) }
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

corresponding_spec:
| Kw_corresponding { Corresponding_spec (None, ()) }
| Kw_corresponding Kw_by;
  v = delimited(Tok_lparen, corresponding_column_list, Tok_rparen) { Corresponding_spec (Some v, ()) }
;;

explicit_table:
| Kw_table v = table_or_query_name { Explicit_table (v, ()) }
;;

simple_table:
| v = query_specification { Simple_table (`query v, ()) }
| v = table_value_constructor { Simple_table (`table v, ()) }
| v = explicit_table { Simple_table (`explicit v, ()) }
;;

non_join_query_primary:
| v = simple_table { Non_join_query_primary (`simple v, ()) }
| v = delimited(Tok_lparen, non_join_query_expression, Tok_rparen) { Non_join_query_primary (`expr v, ()) }
;;

query_primary:
| v = joined_table { Query_primary (`joined v, ()) }
| v = non_join_query_primary { Query_primary (`non_join v, ()) }
;;

non_join_query_term:
| v = non_join_query_primary { Non_join_query_term (`primary v, ()) }
| term = query_term;
  Kw_intersect;
  c = option(corresponding_spec);
  p = query_primary { Non_join_query_term (`term (term, None, c, p), ()) }
| term = query_term;
  Kw_intersect;
  Kw_all;
  c = option(corresponding_spec);
  p = query_primary { Non_join_query_term (`term (term, Some `All, c, p), ()) }
| term = query_term;
  Kw_intersect;
  Kw_distinct;
  c = option(corresponding_spec);
  p = query_primary { Non_join_query_term (`term (term, Some `Distinct, c, p), ()) }
;;

query_term:
| v = joined_table { Query_term (`joined v, ()) }
| v = non_join_query_term { Query_term (`term v, ()) }
;;

non_join_query_expression:
| v = non_join_query_term { Non_join_query_expression (`term v, ()) }
| term = query_expression_body;
  Kw_union;
  c = option(corresponding_spec);
  p = query_term { Non_join_query_term (`union (term, None, c, p), ()) }
| term = query_expression_body;
  Kw_union;
  Kw_all;
  c = option(corresponding_spec);
  p = query_term { Non_join_query_term (`union (term, Some `All, c, p), ()) }
| term = query_expression_body;
  Kw_union;
  Kw_distinct;
  c = option(corresponding_spec);
  p = query_term { Non_join_query_term (`union (term, Some `Distinct, c, p), ()) }
| term = query_expression_body;
  Kw_except;
  c = option(corresponding_spec);
  p = query_term { Non_join_query_term (`except (term, None, c, p), ()) }
| term = query_expression_body;
  Kw_except;
  Kw_all;
  c = option(corresponding_spec);
  p = query_term { Non_join_query_term (`except (term, Some `All, c, p), ()) }
| term = query_expression_body;
  Kw_except;
  Kw_distinct;
  c = option(corresponding_spec);
  p = query_term { Non_join_query_term (`except (term, Some `Distinct, c, p), ()) }
;;

query_expression_body:
| v = joined_table { Query_expression_body (`joined v, ()) }
| v = non_join_query_expression { Query_expression_body (`expr v, ()) }
;;

with_list_element:
| n = identifier;
  c = option(delimited(Tok_lparen, column_name_list, Tok_rparen));
  Kw_as;
  expr = delimited(Tok_lparen, query_expression, Tok_rparen);
  search = option(search_or_cycle_clause)
  { With_list_element (n, c, expr, search, ()) }
;;

with_list:
| fl = with_list_element; list = list(pair(Tok_comma, with_list_element)) {With_list (fl, List.map snd list, ())}
;;

with_clause:
| Kw_with kw = option(Kw_recursive);
              list = with_list {With_clause (Option.map (fun _ -> `recursive) kw, list, ())}

query_expression:
| wl = option(with_clause); q = query_expression_body {Query_expression (wl, q, ())}
;;

(** End   7.13 query expression *)

(** Start 7.14 search or cycle clause *)
non_cycle_mark_value:
| e = value_expression {Non_cycle_mark_value (e, ())}
;;

cycle_mark_value:
| e = value_expression {Cycle_mark_value (e, ())}
;;

path_column:
| e = column_name {Path_column (e, ())}
;;

cycle_mark_column:
| e = column_name {Cycle_mark_column (e, ())}
;;

cycle_column:
| e = column_name {Cycle_column (e, ())}
;;

cycle_column_list:
| fl = cycle_column; list = list(pair(Tok_comma, cycle_column)) {Cycle_column_list (fl, List.map snd list, ())}
;;

cycle_clause:
| Kw_cycle list = cycle_column_list;
  Kw_set mark = cycle_mark_column Kw_to mark_value = cycle_mark_value;
  Kw_default nmv =  non_cycle_mark_value;
  Kw_using path = path_column { Cycle_clause (list, mark, mark_value, nmv, path, ()) }
;;

sequence_column:
| e = column_name {Sequence_column (e, ())}
;;

recursive_search_order:
| Kw_depth Kw_first Kw_by spec = sort_specification_list {Recursive_search_order (`depth spec, ())}
| Kw_breadth Kw_first Kw_by spec = sort_specification_list {Recursive_search_order (`breadth spec, ())}
;;

search_clause:
| Kw_search order = recursive_search_order Kw_set col = sequence_column {Search_clause (order, col, ())}
;;

search_or_cycle_clause:
| clause = search_clause {Search_or_cycle_clause (`search clause, ())}
| clause = cycle_clause {Search_or_cycle_clause (`cycle clause, ())}
| search = search_clause cycle = cycle_clause {Search_or_cycle_clause (`search_and_cycle (search, cycle), ())}
;;

(** End   7.14 search or cycle clause *)


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

(** Start 10.4 routine invocation *)
sql_argument_list:
| Tok_lparen fl = sql_argument; list = list(pair(Tok_comma, sql_argument)) Tok_rparen {Sql_argument_list (fl, List.map snd list, ())}
;;

sql_argument:
| e = value_expression {Sql_argument (`value e, ())}
| e = generalized_expression {Sql_argument (`generalized e, ())}
;;

generalized_expression:
| e = value_expression Kw_as name = schema_qualified_name {Generalized_expression (e, name, ())}
;;
(** End   10.4 routine invocation *)

(** Start 10.7 collate clause *)
collate_clause:
| Kw_collate n = collate_name {Collate_clause (n, ())}
;;
(** End   10.7 collate clause *)

(** Start 10.9 aggregate function *)
set_quantifier:
|Kw_all {`All}
|Kw_distinct {`Distinct}
  ;;
(** End   10.9 aggregate function *)

(** Start 10.10 sort specification *)
sort_specification_list:
| fl = sort_specification; list = list(pair(Tok_comma, sort_specification)) {Sort_specification_list (fl, List.map snd list, ())}
  ;;

sort_specification:
| key = sort_key spec = option(ordering_specification) null = option(null_ordering) {Sort_specification (key, spec, null, ())}
;;

sort_key:
| e = value_expression {Sort_key (e, ())}
  ;;

ordering_specification:
| Kw_asc {Ordering_specification (`asc, ())}
| Kw_desc {Ordering_specification (`desc, ())}
  ;;

null_ordering:
| Kw_nulls Kw_first {Null_ordering (`first, ())}
| Kw_nulls Kw_last {Null_ordering (`last, ())}
  ;;
(** End   10.10 sort specification *)

(** Start 14.1 declare cursor *)
order_by_clause:
  | Kw_order Kw_by e = sort_specification_list {Order_by_clause (e, ())}
  ;;
(** End   14.1 declare cursor *)

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
