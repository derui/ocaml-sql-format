%{
open Types.Ast
open Types.Literal

%}

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
%token Kw_sql_tsi_frac_second
%token Kw_sql_tsi_second
%token Kw_sql_tsi_minute
%token Kw_sql_tsi_hour
%token Kw_sql_tsi_day
%token Kw_sql_tsi_week
%token Kw_sql_tsi_month
%token Kw_sql_tsi_quarter
%token Kw_sql_tsi_year
%token Kw_insert
%token Kw_within
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
%token Kw_interval
%token Kw_convert
%token Kw_cast
%token Kw_substring
%token Kw_extract
%token Kw_trim
%token Kw_to_chars
%token Kw_to_bytes
%token Kw_timestampadd
%token Kw_timestampdiff
%token Kw_user
%token Kw_xmlconcat
%token Kw_xmlcomment
%token Kw_xmltext
%token Kw_translate
%token Kw_position
%token Kw_listagg
%token Kw_current_date
%token Kw_current_timestamp
%token Kw_current_time
%token Kw_session_user
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
%token Kw_exclude
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
%token Kw_current_user
%token Kw_system_user
%token Kw_current_default_transform_group
%token Kw_current_transform_group_for_type
%token Kw_current_path
%token Kw_current_role
%token Kw_nullif
%token Kw_coalesce
%token Kw_groups
%token Kw_glob
%token Kw_match
%token Kw_regexp

(* tokens *)
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
%token <string> Tok_blob
%token <string> Tok_numeric

(* operators *)
%token Op_plus
%token Op_minus
%token Op_star
%token Op_slash
%token Op_amp
%token Op_pipe
%token Op_concat
%token Op_eq
%token Op_eq2
%token Op_ge
%token Op_gt
%token Op_le
%token Op_lt
%token Op_ne
%token Op_ne2
%token Op_extract
%token Op_extract_2
%token Op_lshift
%token Op_rshift
%token Op_tilda

%token Tok_eof

%left Op_concat Op_extract Op_extract_2
%left Op_star Op_slash Op_reminder
%left Op_plus Op_minus
%left Op_amp Op_pipe Op_lshift Op_rshift
%left Op_lt Op_gt Op_le Op_ge
%left Op_eq Op_eq2 Op_ne Op_ne2
%left Kw_not
%left Kw_and Kw_or

%start <Types.Statement.t list> statements

%%

let keyword ==
  | Kw_select; {Identifier (`keyword Kw_select, ())}
  | Kw_from; {Identifier (`keyword Kw_from, ())}
  | Kw_as; {Identifier (`keyword Kw_as, ())}
  | Kw_distinct; {Identifier (`keyword Kw_distinct, ())}
  | Kw_all; {Identifier (`keyword Kw_all, ())}
  | Kw_true; {Identifier (`keyword Kw_true, ())}
  | Kw_false; {Identifier (`keyword Kw_false, ())}
  | Kw_unknown; {Identifier (`keyword Kw_unknown, ())}
  | Kw_null; {Identifier (`keyword Kw_null, ())}
  | Kw_date; {Identifier (`keyword Kw_date, ())}
  | Kw_time; {Identifier (`keyword Kw_time, ())}
  | Kw_timestamp; {Identifier (`keyword Kw_timestamp, ())}
  | Kw_into; {Identifier (`keyword Kw_into, ())}
  | Kw_or; {Identifier (`keyword Kw_or, ())}
  | Kw_not; {Identifier (`keyword Kw_not, ())}
  | Kw_and; {Identifier (`keyword Kw_and, ())}
  | Kw_union; {Identifier (`keyword Kw_union, ())}
  | Kw_except; {Identifier (`keyword Kw_except, ())}
  | Kw_intersect; {Identifier (`keyword Kw_intersect, ())}
  | Kw_group; {Identifier (`keyword Kw_group, ())}
  | Kw_by; {Identifier (`keyword Kw_by, ())}
  | Kw_rollup; {Identifier (`keyword Kw_rollup, ())}
  | Kw_having; {Identifier (`keyword Kw_having, ())}
  | Kw_where; {Identifier (`keyword Kw_where, ())}
  | Kw_order; {Identifier (`keyword Kw_order, ())}
  | Kw_asc; {Identifier (`keyword Kw_asc, ())}
  | Kw_desc; {Identifier (`keyword Kw_desc, ())}
  | Kw_first; {Identifier (`keyword Kw_first, ())}
  | Kw_last; {Identifier (`keyword Kw_last, ())}
  | Kw_limit; {Identifier (`keyword Kw_limit, ())}
  | Kw_offset; {Identifier (`keyword Kw_offset, ())}
  | Kw_row; {Identifier (`keyword Kw_row, ())}
  | Kw_rows; {Identifier (`keyword Kw_rows, ())}
  | Kw_fetch; {Identifier (`keyword Kw_fetch, ())}
  | Kw_next; {Identifier (`keyword Kw_next, ())}
  | Kw_only; {Identifier (`keyword Kw_only, ())}
  | Kw_is; {Identifier (`keyword Kw_is, ())}
  | Kw_between; {Identifier (`keyword Kw_between, ())}
  | Kw_like_regex; {Identifier (`keyword Kw_like_regex, ())}
  | Kw_similar; {Identifier (`keyword Kw_similar, ())}
  | Kw_to; {Identifier (`keyword Kw_to, ())}
  | Kw_escape; {Identifier (`keyword Kw_escape, ())}
  | Kw_like; {Identifier (`keyword Kw_like, ())}
  | Kw_any; {Identifier (`keyword Kw_any, ())}
  | Kw_some; {Identifier (`keyword Kw_some, ())}
  | Kw_in; {Identifier (`keyword Kw_in, ())}
  | Kw_exists; {Identifier (`keyword Kw_exists, ())}
  | Kw_with; {Identifier (`keyword Kw_with, ())}
  | Kw_table; {Identifier (`keyword Kw_table, ())}
  | Kw_lateral; {Identifier (`keyword Kw_lateral, ())}
  | Kw_left; {Identifier (`keyword Kw_left, ())}
  | Kw_right; {Identifier (`keyword Kw_right, ())}
  | Kw_full; {Identifier (`keyword Kw_full, ())}
  | Kw_outer; {Identifier (`keyword Kw_outer, ())}
  | Kw_inner; {Identifier (`keyword Kw_inner, ())}
  | Kw_cross; {Identifier (`keyword Kw_cross, ())}
  | Kw_join; {Identifier (`keyword Kw_join, ())}
  | Kw_on; {Identifier (`keyword Kw_on, ())}
  | Kw_case; {Identifier (`keyword Kw_case, ())}
  | Kw_when; {Identifier (`keyword Kw_when, ())}
  | Kw_then; {Identifier (`keyword Kw_then, ())}
  | Kw_end; {Identifier (`keyword Kw_end, ())}
  | Kw_else; {Identifier (`keyword Kw_else, ())}
  | Kw_textagg; {Identifier (`keyword Kw_textagg, ())}
  | Kw_for; {Identifier (`keyword Kw_for, ())}
  | Kw_delimiter; {Identifier (`keyword Kw_delimiter, ())}
  | Kw_quote; {Identifier (`keyword Kw_quote, ())}
  | Kw_no; {Identifier (`keyword Kw_no, ())}
  | Kw_header; {Identifier (`keyword Kw_header, ())}
  | Kw_encoding; {Identifier (`keyword Kw_encoding, ())}
  | Kw_count; {Identifier (`keyword Kw_count, ())}
  | Kw_count_big; {Identifier (`keyword Kw_count_big, ())}
  | Kw_sum; {Identifier (`keyword Kw_sum, ())}
  | Kw_avg; {Identifier (`keyword Kw_avg, ())}
  | Kw_min; {Identifier (`keyword Kw_min, ())}
  | Kw_max; {Identifier (`keyword Kw_max, ())}
  | Kw_every; {Identifier (`keyword Kw_every, ())}
  | Kw_stddev_pop; {Identifier (`keyword Kw_stddev_pop, ())}
  | Kw_stddev_samp; {Identifier (`keyword Kw_stddev_samp, ())}
  | Kw_var_samp; {Identifier (`keyword Kw_var_samp, ())}
  | Kw_var_pop; {Identifier (`keyword Kw_var_pop, ())}
  | Kw_filter; {Identifier (`keyword Kw_filter, ())}
  | Kw_over; {Identifier (`keyword Kw_over, ())}
  | Kw_partition; {Identifier (`keyword Kw_partition, ())}
  | Kw_range; {Identifier (`keyword Kw_range, ())}
  | Kw_unbounded; {Identifier (`keyword Kw_unbounded, ())}
  | Kw_following; {Identifier (`keyword Kw_following, ())}
  | Kw_preceding; {Identifier (`keyword Kw_preceding, ())}
  | Kw_current; {Identifier (`keyword Kw_current, ())}
  | Kw_row_number; {Identifier (`keyword Kw_row_number, ())}
  | Kw_rank; {Identifier (`keyword Kw_rank, ())}
  | Kw_dense_rank; {Identifier (`keyword Kw_dense_rank, ())}
  | Kw_percent_rank; {Identifier (`keyword Kw_percent_rank, ())}
  | Kw_cume_dist; {Identifier (`keyword Kw_cume_dist, ())}
  | Kw_string; {Identifier (`keyword Kw_string, ())}
  | Kw_varchar; {Identifier (`keyword Kw_varchar, ())}
  | Kw_boolean; {Identifier (`keyword Kw_boolean, ())}
  | Kw_byte; {Identifier (`keyword Kw_byte, ())}
  | Kw_tinyint; {Identifier (`keyword Kw_tinyint, ())}
  | Kw_short; {Identifier (`keyword Kw_short, ())}
  | Kw_smallint; {Identifier (`keyword Kw_smallint, ())}
  | Kw_char; {Identifier (`keyword Kw_char, ())}
  | Kw_integer; {Identifier (`keyword Kw_integer, ())}
  | Kw_long; {Identifier (`keyword Kw_long, ())}
  | Kw_bigint; {Identifier (`keyword Kw_bigint, ())}
  | Kw_biginteger; {Identifier (`keyword Kw_biginteger, ())}
  | Kw_float; {Identifier (`keyword Kw_float, ())}
  | Kw_real; {Identifier (`keyword Kw_real, ())}
  | Kw_double; {Identifier (`keyword Kw_double, ())}
  | Kw_bigdecimal; {Identifier (`keyword Kw_bigdecimal, ())}
  | Kw_decimal; {Identifier (`keyword Kw_decimal, ())}
  | Kw_object; {Identifier (`keyword Kw_object, ())}
  | Kw_blob; {Identifier (`keyword Kw_blob, ())}
  | Kw_clob; {Identifier (`keyword Kw_clob, ())}
  | Kw_json; {Identifier (`keyword Kw_json, ())}
  | Kw_varbinary; {Identifier (`keyword Kw_varbinary, ())}
  | Kw_geometry; {Identifier (`keyword Kw_geometry, ())}
  | Kw_geography; {Identifier (`keyword Kw_geography, ())}
  | Kw_xml; {Identifier (`keyword Kw_xml, ())}
  | Kw_year; {Identifier (`keyword Kw_year, ())}
  | Kw_month; {Identifier (`keyword Kw_month, ())}
  | Kw_day; {Identifier (`keyword Kw_day, ())}
  | Kw_hour; {Identifier (`keyword Kw_hour, ())}
  | Kw_minute; {Identifier (`keyword Kw_minute, ())}
  | Kw_second; {Identifier (`keyword Kw_second, ())}
  | Kw_quarter; {Identifier (`keyword Kw_quarter, ())}
  | Kw_epoch; {Identifier (`keyword Kw_epoch, ())}
  | Kw_dow; {Identifier (`keyword Kw_dow, ())}
  | Kw_doy; {Identifier (`keyword Kw_doy, ())}
  | Kw_leading; {Identifier (`keyword Kw_leading, ())}
  | Kw_trailing; {Identifier (`keyword Kw_trailing, ())}
  | Kw_both; {Identifier (`keyword Kw_both, ())}
  | Kw_sql_tsi_frac_second; {Identifier (`keyword Kw_sql_tsi_frac_second, ())}
  | Kw_sql_tsi_second; {Identifier (`keyword Kw_sql_tsi_second, ())}
  | Kw_sql_tsi_minute; {Identifier (`keyword Kw_sql_tsi_minute, ())}
  | Kw_sql_tsi_hour; {Identifier (`keyword Kw_sql_tsi_hour, ())}
  | Kw_sql_tsi_day; {Identifier (`keyword Kw_sql_tsi_day, ())}
  | Kw_sql_tsi_week; {Identifier (`keyword Kw_sql_tsi_week, ())}
  | Kw_sql_tsi_month; {Identifier (`keyword Kw_sql_tsi_month, ())}
  | Kw_sql_tsi_quarter; {Identifier (`keyword Kw_sql_tsi_quarter, ())}
  | Kw_sql_tsi_year; {Identifier (`keyword Kw_sql_tsi_year, ())}
  | Kw_insert; {Identifier (`keyword Kw_insert, ())}
  | Kw_within; {Identifier (`keyword Kw_within, ())}
  | Kw_exception; {Identifier (`keyword Kw_exception, ())}
  | Kw_serial; {Identifier (`keyword Kw_serial, ())}
  | Kw_index; {Identifier (`keyword Kw_index, ())}
  | Kw_instead; {Identifier (`keyword Kw_instead, ())}
  | Kw_view; {Identifier (`keyword Kw_view, ())}
  | Kw_enabled; {Identifier (`keyword Kw_enabled, ())}
  | Kw_disabled; {Identifier (`keyword Kw_disabled, ())}
  | Kw_key; {Identifier (`keyword Kw_key, ())}
  | Kw_document; {Identifier (`keyword Kw_document, ())}
  | Kw_content; {Identifier (`keyword Kw_content, ())}
  | Kw_empty; {Identifier (`keyword Kw_empty, ())}
  | Kw_ordinality; {Identifier (`keyword Kw_ordinality, ())}
  | Kw_path; {Identifier (`keyword Kw_path, ())}
  | Kw_querystring; {Identifier (`keyword Kw_querystring, ())}
  | Kw_namespace; {Identifier (`keyword Kw_namespace, ())}
  | Kw_result; {Identifier (`keyword Kw_result, ())}
  | Kw_accesspattern; {Identifier (`keyword Kw_accesspattern, ())}
  | Kw_auto_increment; {Identifier (`keyword Kw_auto_increment, ())}
  | Kw_wellformed; {Identifier (`keyword Kw_wellformed, ())}
  | Kw_texttable; {Identifier (`keyword Kw_texttable, ())}
  | Kw_arraytable; {Identifier (`keyword Kw_arraytable, ())}
  | Kw_jsontable; {Identifier (`keyword Kw_jsontable, ())}
  | Kw_selector; {Identifier (`keyword Kw_selector, ())}
  | Kw_skip; {Identifier (`keyword Kw_skip, ())}
  | Kw_width; {Identifier (`keyword Kw_width, ())}
  | Kw_passing; {Identifier (`keyword Kw_passing, ())}
  | Kw_name; {Identifier (`keyword Kw_name, ())}
  | Kw_columns; {Identifier (`keyword Kw_columns, ())}
  | Kw_nulls; {Identifier (`keyword Kw_nulls, ())}
  | Kw_objecttable; {Identifier (`keyword Kw_objecttable, ())}
  | Kw_version; {Identifier (`keyword Kw_version, ())}
  | Kw_including; {Identifier (`keyword Kw_including, ())}
  | Kw_excluding; {Identifier (`keyword Kw_excluding, ())}
  | Kw_xmldeclaration; {Identifier (`keyword Kw_xmldeclaration, ())}
  | Kw_variadic; {Identifier (`keyword Kw_variadic, ())}
  | Kw_raise; {Identifier (`keyword Kw_raise, ())}
  | Kw_chain; {Identifier (`keyword Kw_chain, ())}
  | Kw_jsonarray_agg; {Identifier (`keyword Kw_jsonarray_agg, ())}
  | Kw_jsonobject; {Identifier (`keyword Kw_jsonobject, ())}
  | Kw_preserve; {Identifier (`keyword Kw_preserve, ())}
  | Kw_upsert; {Identifier (`keyword Kw_upsert, ())}
  | Kw_after; {Identifier (`keyword Kw_after, ())}
  | Kw_type; {Identifier (`keyword Kw_type, ())}
  | Kw_translator; {Identifier (`keyword Kw_translator, ())}
  | Kw_jaas; {Identifier (`keyword Kw_jaas, ())}
  | Kw_condition; {Identifier (`keyword Kw_condition, ())}
  | Kw_mask; {Identifier (`keyword Kw_mask, ())}
  | Kw_access; {Identifier (`keyword Kw_access, ())}
  | Kw_control; {Identifier (`keyword Kw_control, ())}
  | Kw_none; {Identifier (`keyword Kw_none, ())}
  | Kw_data; {Identifier (`keyword Kw_data, ())}
  | Kw_database; {Identifier (`keyword Kw_database, ())}
  | Kw_privileges; {Identifier (`keyword Kw_privileges, ())}
  | Kw_role; {Identifier (`keyword Kw_role, ())}
  | Kw_schema; {Identifier (`keyword Kw_schema, ())}
  | Kw_use; {Identifier (`keyword Kw_use, ())}
  | Kw_repository; {Identifier (`keyword Kw_repository, ())}
  | Kw_rename; {Identifier (`keyword Kw_rename, ())}
  | Kw_domain; {Identifier (`keyword Kw_domain, ())}
  | Kw_usage; {Identifier (`keyword Kw_usage, ())}
  | Kw_explain; {Identifier (`keyword Kw_explain, ())}
  | Kw_analyze; {Identifier (`keyword Kw_analyze, ())}
  | Kw_text; {Identifier (`keyword Kw_text, ())}
  | Kw_format; {Identifier (`keyword Kw_format, ())}
  | Kw_yaml; {Identifier (`keyword Kw_yaml, ())}
  | Kw_policy; {Identifier (`keyword Kw_policy, ())}
  | Kw_interval; {Identifier (`keyword Kw_interval, ())}
  | Kw_convert; {Identifier (`keyword Kw_convert, ())}
  | Kw_cast; {Identifier (`keyword Kw_cast, ())}
  | Kw_substring; {Identifier (`keyword Kw_substring, ())}
  | Kw_extract; {Identifier (`keyword Kw_extract, ())}
  | Kw_trim; {Identifier (`keyword Kw_trim, ())}
  | Kw_to_chars; {Identifier (`keyword Kw_to_chars, ())}
  | Kw_to_bytes; {Identifier (`keyword Kw_to_bytes, ())}
  | Kw_timestampadd; {Identifier (`keyword Kw_timestampadd, ())}
  | Kw_timestampdiff; {Identifier (`keyword Kw_timestampdiff, ())}
  | Kw_user; {Identifier (`keyword Kw_user, ())}
  | Kw_xmlconcat; {Identifier (`keyword Kw_xmlconcat, ())}
  | Kw_xmlcomment; {Identifier (`keyword Kw_xmlcomment, ())}
  | Kw_xmltext; {Identifier (`keyword Kw_xmltext, ())}
  | Kw_translate; {Identifier (`keyword Kw_translate, ())}
  | Kw_position; {Identifier (`keyword Kw_position, ())}
  | Kw_listagg; {Identifier (`keyword Kw_listagg, ())}
  | Kw_current_date; {Identifier (`keyword Kw_current_date, ())}
  | Kw_current_timestamp; {Identifier (`keyword Kw_current_timestamp, ())}
  | Kw_current_time; {Identifier (`keyword Kw_current_time, ())}
  | Kw_session_user; {Identifier (`keyword Kw_session_user, ())}
  | Kw_tablesample; {Identifier (`keyword Kw_tablesample, ())}
  | Kw_bernoulli; {Identifier (`keyword Kw_bernoulli, ())}
  | Kw_system; {Identifier (`keyword Kw_system, ())}
  | Kw_repeatable; {Identifier (`keyword Kw_repeatable, ())}
  | Kw_unnest; {Identifier (`keyword Kw_unnest, ())}
  | Kw_module; {Identifier (`keyword Kw_module, ())}
  | Kw_collate; {Identifier (`keyword Kw_collate, ())}
  | Kw_cube; {Identifier (`keyword Kw_cube, ())}
  | Kw_grouping; {Identifier (`keyword Kw_grouping, ())}
  | Kw_sets; {Identifier (`keyword Kw_sets, ())}
  | Kw_ties; {Identifier (`keyword Kw_ties, ())}
  | Kw_others; {Identifier (`keyword Kw_others, ())}
  | Kw_exclude; {Identifier (`keyword Kw_exclude, ())}
  | Kw_window; {Identifier (`keyword Kw_window, ())}
  | Kw_using; {Identifier (`keyword Kw_using, ())}
  | Kw_natural; {Identifier (`keyword Kw_natural, ())}
  | Kw_corresponding; {Identifier (`keyword Kw_corresponding, ())}
  | Kw_recursive; {Identifier (`keyword Kw_recursive, ())}
  | Kw_cycle; {Identifier (`keyword Kw_cycle, ())}
  | Kw_default; {Identifier (`keyword Kw_default, ())}
  | Kw_set; {Identifier (`keyword Kw_set, ())}
  | Kw_depth; {Identifier (`keyword Kw_depth, ())}
  | Kw_breadth; {Identifier (`keyword Kw_breadth, ())}
  | Kw_search; {Identifier (`keyword Kw_search, ())}
  | Kw_values; {Identifier (`keyword Kw_values, ())}
  | Kw_value; {Identifier (`keyword Kw_value, ())}
  | Kw_element; {Identifier (`keyword Kw_element, ())}
  | Kw_zone; {Identifier (`keyword Kw_zone, ())}
  | Kw_local; {Identifier (`keyword Kw_local, ())}
  | Kw_at; {Identifier (`keyword Kw_at, ())}
  | Kw_abs; {Identifier (`keyword Kw_abs, ())}
  | Kw_array; {Identifier (`keyword Kw_array, ())}
  | Kw_multiset; {Identifier (`keyword Kw_multiset, ())}
  | Kw_localtime; {Identifier (`keyword Kw_localtime, ())}
  | Kw_localtimestamp; {Identifier (`keyword Kw_localtimestamp, ())}
  | Kw_characters; {Identifier (`keyword Kw_characters, ())}
  | Kw_code_units; {Identifier (`keyword Kw_code_units, ())}
  | Kw_octets; {Identifier (`keyword Kw_octets, ())}
  | Kw_without; {Identifier (`keyword Kw_without, ())}
  | Kw_scope; {Identifier (`keyword Kw_scope, ())}
  | Kw_ref; {Identifier (`keyword Kw_ref, ())}
  | Kw_precision; {Identifier (`keyword Kw_precision, ())}
  | Kw_numeric; {Identifier (`keyword Kw_numeric, ())}
  | Kw_dec; {Identifier (`keyword Kw_dec, ())}
  | Kw_int; {Identifier (`keyword Kw_int, ())}
  | Kw_binary; {Identifier (`keyword Kw_binary, ())}
  | Kw_large; {Identifier (`keyword Kw_large, ())}
  | Kw_national; {Identifier (`keyword Kw_national, ())}
  | Kw_varying; {Identifier (`keyword Kw_varying, ())}
  | Kw_character; {Identifier (`keyword Kw_character, ())}
  | Kw_nchar; {Identifier (`keyword Kw_nchar, ())}
  | Kw_nclob; {Identifier (`keyword Kw_nclob, ())}
  | Kw_collation; {Identifier (`keyword Kw_collation, ())}
  | Kw_indicator; {Identifier (`keyword Kw_indicator, ())}
  | Kw_current_user; {Identifier (`keyword Kw_current_user, ())}
  | Kw_system_user; {Identifier (`keyword Kw_system_user, ())}
  | Kw_current_default_transform_group; {Identifier (`keyword Kw_current_default_transform_group, ())}
  | Kw_current_transform_group_for_type; {Identifier (`keyword Kw_current_transform_group_for_type, ())}
  | Kw_current_path; {Identifier (`keyword Kw_current_path, ())}
  | Kw_current_role; {Identifier (`keyword Kw_current_role, ())}
  | Kw_nullif; {Identifier (`keyword Kw_nullif, ())}
  | Kw_coalesce; {Identifier (`keyword Kw_coalesce, ())}
  | Kw_groups; {Identifier (`keyword Kw_groups, ())}

let statements :=
  | v = nonempty_list(pair(statement, option(Tok_semicolon))); Tok_eof; { List.map fst v }

let statement :=
  | v = sql_statement; { v }

                      (* basic *)
let sign ==
  | Op_plus; {`plus}
  | Op_minus; {`minus}

(* literal *)
let identifier :=
  | x = Tok_ident; {Identifier (`raw x, ())}

let literal_value :=
  | Kw_null; {Literal_value (`null, ())}
  | Kw_true; {Literal_value (`true', ())}
  | Kw_false; {Literal_value (`false', ())}
  | Kw_current_date; {Literal_value (`current_date, ())}
  | Kw_current_time; {Literal_value (`current_time, ())}
  | Kw_current_timestamp; {Literal_value (`current_timestamp, ())}
  | v = numeric_literal; { Literal_value (`numeric v, ())}
  | v = string_literal; { Literal_value (`string v, ())}
  | v = blob_literal; { Literal_value (`blob v, ())}

let numeric_literal :=
  | v = Tok_numeric; { Numeric_literal (v, ()) }

let string_literal :=
  | v = Tok_string ;{ String_literal (v, ()) }

let blob_literal :=
  | v = Tok_blob; { Blob_literal (v, ()) }

let bind_parameter :=
  | Tok_qmark; {Bind_parameter ()}

let schema_name ==
  | v = identifier; { Schema_name (v, ()) }

let table_name ==
  | v = identifier; { Table_name (v, ()) }

let column_name ==
  | v = identifier; { Column_name (v, ()) }

let type_name :=
 | name = nonempty_list(identifier); Tok_lparen;
   size = signed_number; Tok_comma; max_size = signed_number;
   Tok_rparen ;
   { Type_name (name, `with_max (size, max_size), ()) }
 | name = nonempty_list(identifier); size = delimited(Tok_lparen, signed_number, Tok_rparen); { Type_name (name, `size size, ()) }
 | name = nonempty_list(identifier); { Type_name (name, `name_only, ()) }

let signed_number :=
 | sign = option(sign); v = numeric_literal; { Signed_number (sign ,v, ()) }

let qualified_name :=
 | sname = pair(schema_name, Tok_period);
   tname = pair(table_name, Tok_period);
   name = column_name; { Qualified_name (Some (fst sname), Some (fst tname), name, ()) }
 | tname = pair(table_name, Tok_period);
   name = column_name; { Qualified_name (None, Some (fst tname), name, ()) }
 | name = column_name; { Qualified_name (None, None, name, ()) }


let expr :=
 | v = literal_value; { Expr (`literal v, ()) }
 | v = bind_parameter; { Expr (`parameter v, ()) }
 | v = qualified_name; { Expr (`name v, ()) }
 | op = unary_operator; v = expr; { Expr (`unary (op, v), ()) }
 | e = expr; op = binary_operator; e2 = expr; { Expr (`binary (e, op, e2), ()) }
 | e = delimited(Tok_lparen, separated_nonempty_list(Tok_comma, expr), Tok_rparen); { Expr (`nested e, ()) }
 | Kw_cast; Tok_lparen;
   e = expr; Kw_as; t = type_name;
   Tok_rparen;
   { Expr (`cast (e, t), ()) }
 | e = expr; Kw_collate; tname = collation_name; { Expr (`collate (e, tname), ()) }
 | e = expr; n = ioption(Kw_not); Kw_like; e2 = expr; { Expr (`like (e, Option.map (fun _ -> `not')n, e2, None), ()) }
 | e = expr; n = ioption(Kw_not); Kw_like; e2 = expr; Kw_escape; escape = expr; {
       Expr (`like (e, Option.map (fun _ -> `not') n, e2, Some (escape)), ())
     }
 | e = expr; n = ioption(Kw_not); Kw_glob; e2 = expr; {
       Expr (`glob (e, Option.map (fun _ -> `not') n, e2), ())
     }
 | e = expr; n = ioption(Kw_not); Kw_regexp; e2 = expr; {
       Expr (`regexp (e, Option.map (fun _ -> `not') n, e2), ())
     }
 | e = expr; n = ioption(Kw_not); Kw_match; e2 = expr; {
       Expr (`match' (e, Option.map (fun _ -> `not') n, e2), ())
     }
 | e = expr; Kw_is; n = ioption(Kw_not); e2 = expr; {
       Expr (`is (e, Option.map (fun _ -> `not') n, e2), ())
     }
 | e = expr; Kw_is; n = ioption(Kw_not); Kw_distinct; Kw_from; e2 = expr; {
       Expr (`is_distinct (e, Option.map (fun _ -> `not') n, e2), ())
     }


let sql_statement :=
 | s = select_statement; { Sql_statement (`select s, ()) }


let select_statement :=
 | c = select_core; { Select_statement (c, ())}


let select_core :=
 | s = select_clause;
   f = option(from_clause);
   wh = option(where_clause);
   g = option(group_by_clause);
   h = option(having_clause);
   wi = option(window_clause);
   { Select_core (`select (s,f,wh,g,h,wi), ()) }


let result_column :=
 | Op_star; { Result_column (`asterisk, ()) }
 | v = table_name; Tok_period; Op_star; { Result_column (`qualified_asterisk v, ()) }
 | e = expr; alias = alias; {Result_column (`expr (e, alias), ())}

let alias ==
  | { None }
  | Kw_as; x = identifier; { Some x }
  | x = identifier; {Some x}


let table_or_subquery :=
 | sname = schema_name; Tok_period; tname = table_name; a = alias; { Table_or_subquery (`name (Some sname, tname, a), ()) }
 | tname = table_name; a = alias; { Table_or_subquery (`name (None, tname, a), ()) }
 | stmt = delimited(Tok_lparen, select_statement, Tok_rparen); a = alias; { Table_or_subquery (`statement (stmt, a), ()) }
 | ls = delimited(Tok_lparen, separated_nonempty_list(Tok_comma, table_or_subquery), Tok_rparen); {
     Table_or_subquery (`nested ls, ())
   }
 | ls = delimited(Tok_lparen, join_clause, Tok_rparen); {
     Table_or_subquery (`join ls, ())
   }


let quantifier ==
  | Kw_distinct; { `distinct }
  | Kw_all; { `all }


let select_clause :=
 | Kw_select; q = option(quantifier); cols = separated_nonempty_list(Tok_comma, result_column); {
        Select_clause (q, cols, ())
      }


let from_clause :=
 | Kw_from; ts = separated_nonempty_list(Tok_comma, table_or_subquery); { From_clause (`table_or_subquery ts, ()) }
 | Kw_from; j = join_clause; { From_clause (`join j, ()) }


let where_clause :=
 | Kw_where; e = expr; { Where_clause (e, ())}


let group_by_clause :=
 | Kw_group; Kw_by; es = separated_nonempty_list(Tok_comma, expr); {Group_by_clause (es, ())}

let window_clause :=
 | Kw_window; ds = separated_nonempty_list(Tok_comma, window_clause_sublist); {Window_clause (ds, ())}

let window_clause_sublist ==
  | n = window_name; Kw_as; w = window_defn; { (n, w) }


let having_clause :=
 | Kw_having; e = expr; {  Having_clause (e, ()) }


let window_name ==
 | v = identifier; { Window_name (v, ()) }


let window_defn :=
 | Tok_lparen;
   n = option(base_window_name);
   p = option(partition_clause);
   o = option(order_by_clause);
   s = option(frame_spec);
   Tok_rparen; { Window_defn (n,p,o,s, ()) }


let base_window_name :=
 | i = identifier; { Base_window_name (i, ()) }


let order_by_clause :=
  | Kw_order; Kw_by; term = ordering_term; {Order_by_clause (term, ())}

let order ==
  | Kw_asc; {`asc}
  | Kw_desc; {`desc}

let null_order ==
  | Kw_null; Kw_first; { `first }
  | Kw_null; Kw_last; { `last }

let frame_spec :=
 | Kw_range; core = frame_spec_core; e = option(frame_spec_excluding);  { Frame_spec (`range, core, e, ()) }
 | Kw_rows; core = frame_spec_core; e = option(frame_spec_excluding);  { Frame_spec (`rows, core, e, ()) }
 | Kw_groups; core = frame_spec_core; e = option(frame_spec_excluding);  { Frame_spec (`groups, core, e, ()) }


let ordering_term :=
 | e = expr; collation = option(collation_name);
   o = option(order); no = option(null_order);
   { Ordering_term (e, collation, o, no, ())  }


let partition_clause :=
 | Kw_partition; Kw_by; es = separated_nonempty_list(Tok_comma, expr); {Partition_clause (es, ())}


let collation_name :=
 | Kw_collation; name = identifier; {Collation_name (name, ())}


let frame_spec_between :=
  | Kw_between; b1 = frame_spec_between_1; Kw_and; b2 = frame_spec_between_2;
    {Frame_spec_between (b1, b2, ())}


let frame_spec_between_1 :=
 | e = expr; Kw_preceding; {Frame_spec_between_1 (`preceding e, ())}
 | e = expr; Kw_following; {Frame_spec_between_1 (`following e, ())}
 | Kw_unbounded; Kw_preceding; {Frame_spec_between_1 (`unbounded, ())}
 | Kw_current; Kw_row; {Frame_spec_between_1 (`current_row, ())}



let frame_spec_between_2 :=
 | e = expr; Kw_preceding; {Frame_spec_between_2 (`preceding e, ())}
 | e = expr; Kw_following; {Frame_spec_between_2 (`following e, ())}
 | Kw_unbounded; Kw_following; {Frame_spec_between_2 (`unbounded, ())}
 | Kw_current; Kw_row; {Frame_spec_between_2 (`current_row, ())}


let frame_spec_core :=
 | e = expr; Kw_preceding; {Frame_spec_core (`preceding e, ())}
 | Kw_unbounded; Kw_preceding; {Frame_spec_core (`unbounded, ())}
 | Kw_current; Kw_row; {Frame_spec_core (`current_row, ())}
 | b = frame_spec_between; { Frame_spec_core (`between b, ()) }


let frame_spec_excluding :=
 | Kw_exclude; Kw_group; {Frame_spec_excluding (`group, ())}
 | Kw_exclude; Kw_ties; {Frame_spec_excluding (`ties, ())}
 | Kw_exclude; Kw_no; Kw_others; {Frame_spec_excluding (`no_others, ())}
 | Kw_exclude; Kw_current; Kw_row; {Frame_spec_excluding (`current_row, ())}


let join_operator :=
 | Tok_comma; { Join_operator (`comma, ()) }
 | Kw_join; { Join_operator (`simple, ()) }
 | Kw_cross; Kw_join; { Join_operator (`cross, ()) }
 | Kw_natural; Kw_join; { Join_operator (`natural, ()) }
 | v = option(Kw_natural); Kw_inner; Kw_join; { Join_operator (`inner (Option.map (fun _ -> `natural) v) , ()) }
 | v = option(Kw_natural); Kw_left; option(Kw_outer); Kw_join; {
       Join_operator (`outer ((Option.map (fun _ -> `natural) v), `left) , ())
     }
 | v = option(Kw_natural); Kw_right; option(Kw_outer); Kw_join; {
       Join_operator (`outer ((Option.map (fun _ -> `natural) v), `right) , ())
     }
 | v = option(Kw_natural); Kw_full; option(Kw_outer); Kw_join; {
       Join_operator (`outer ((Option.map (fun _ -> `natural) v), `full) , ())
     }


let join_constraint :=
 | Kw_on; e = expr; { Join_constraint (`expr e, ()) }
 | Kw_using; ds = delimited(Tok_lparen, separated_nonempty_list(Tok_comma, column_name) ,Tok_rparen); { Join_constraint (`using ds, ()) }

let join_clause_sublist ==
  | op = join_operator; t = table_or_subquery; c = option(join_constraint); { (op, t, c) }

let join_clause :=
 | q = table_or_subquery; cs = list(join_clause_sublist) ; { Join_clause (q, cs, ()) }


let unary_operator ==
 | Op_tilda; { Unary_operator (`tilda, ()) }
 | Op_plus; { Unary_operator (`plus, ()) }
 | Op_minus; { Unary_operator (`minus, ()) }
 | Kw_not; { Unary_operator (`not', ()) }


let binary_operator :=
 | Op_concat; { Binary_operator (`concat, ()) }
 | Op_extract; { Binary_operator (`extract, ()) }
 | Op_extract_2; { Binary_operator (`extract_2, ()) }
 | Op_star; { Binary_operator (`asterisk, ()) }
 | Op_slash; { Binary_operator (`divide, ()) }
 | Op_plus; { Binary_operator (`plus, ()) }
 | Op_minus; { Binary_operator (`minus, ()) }
 | Op_amp; { Binary_operator (`land', ()) }
 | Op_pipe; { Binary_operator (`lor', ()) }
 | Op_lshift; { Binary_operator (`lshift, ()) }
 | Op_rshift; { Binary_operator (`rshift, ()) }
 | Op_lt; { Binary_operator (`lt, ()) }
 | Op_gt; { Binary_operator (`gt, ()) }
 | Op_le; { Binary_operator (`le, ()) }
 | Op_ge; { Binary_operator (`ge, ()) }
 | Op_eq; { Binary_operator (`eq, ()) }
 | Op_eq2; { Binary_operator (`eq2, ()) }
 | Op_ne; { Binary_operator (`ne, ()) }
 | Op_ne2; { Binary_operator (`ne2, ()) }
 | Kw_and; { Binary_operator (`and', ()) }
 | Kw_or; { Binary_operator (`or', ()) }


let function_name :=
 | v = identifier; { Function_name (, ()) }
