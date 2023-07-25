%{
open Types.Ast
open Types.Literal
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
%token <string> Tok_blob
%token <string> Tok_numeric

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

%start <Types.Statement.t list> statements

%%

statements:
  | v = separated_nonempty_list(Tok_semicolon, entry) Tok_eof { v }
;;

entry:
                 | { }
;;

literal_value:
  | v = numeric_literal { Literal_value (`numeric v, ())}
  | v = string_literal { Literal_value (`string v, ())}
  | v = blob_literal { Literal_value (`blob v, ())}
  | Kw_null { Literal_value (`null, ()) }
;;
numeric_literal:
  | v = Tok_numeric { Numeric_literal (v, ()) }
;;
string_literal:
  | v = Tok_string { String_literal (v, ()) }
;;
blob_literal:
  | v = Tok_blob { Blob_literal (v, ()) }
;;
