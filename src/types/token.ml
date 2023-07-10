type token =
  | Kw_select
  | Kw_from
  | Kw_as
  | Kw_distinct
  | Kw_all
  | Kw_true
  | Kw_false
  | Kw_unknown
  | Kw_null
  | Kw_date
  | Kw_time
  | Kw_timestamp
  | Kw_into
  | Kw_or
  | Kw_not
  | Kw_and
  | Kw_union
  | Kw_except
  | Kw_intersect
  | Kw_group
  | Kw_by
  | Kw_rollup
  | Kw_having
  | Kw_where
  | Kw_order
  | Kw_asc
  | Kw_desc
  | Kw_first
  | Kw_last
  | Kw_limit
  | Kw_offset
  | Kw_row
  | Kw_rows
  | Kw_fetch
  | Kw_next
  | Kw_only
  | Kw_is
  | Kw_between
  | Kw_like_regex
  | Kw_similar
  | Kw_to
  | Kw_escape
  | Kw_like
  | Kw_any
  | Kw_some
  | Kw_in
  | Kw_exists
  | Kw_with
  | Kw_table
  | Kw_lateral
  | Kw_left
  | Kw_right
  | Kw_full
  | Kw_outer
  | Kw_inner
  | Kw_cross
  | Kw_join
  | Kw_on
  | Kw_case
  | Kw_when
  | Kw_then
  | Kw_end
  | Kw_else
  | Kw_textagg
  | Kw_for
  | Kw_delimiter
  | Kw_quote
  | Kw_no
  | Kw_header
  | Kw_encoding
  | Kw_count
  | Kw_count_big
  | Kw_sum
  | Kw_avg
  | Kw_min
  | Kw_max
  | Kw_every
  | Kw_stddev_pop
  | Kw_stddev_samp
  | Kw_var_samp
  | Kw_var_pop
  | Kw_filter
  | Kw_over
  | Kw_partition
  | Kw_range
  | Kw_unbounded
  | Kw_following
  | Kw_preceding
  | Kw_current
  | Kw_row_number
  | Kw_rank
  | Kw_dense_rank
  | Kw_percent_rank
  | Kw_cume_dist
  | Kw_string
  | Kw_varchar
  | Kw_boolean
  | Kw_byte
  | Kw_tinyint
  | Kw_short
  | Kw_smallint
  | Kw_char
  | Kw_integer
  | Kw_long
  | Kw_bigint
  | Kw_biginteger
  | Kw_float
  | Kw_real
  | Kw_double
  | Kw_bigdecimal
  | Kw_decimal
  | Kw_object
  | Kw_blob
  | Kw_clob
  | Kw_json
  | Kw_varbinary
  | Kw_geometry
  | Kw_geography
  | Kw_xml
  | Kw_year
  | Kw_month
  | Kw_day
  | Kw_hour
  | Kw_minute
  | Kw_second
  | Kw_quarter
  | Kw_epoch
  | Kw_dow
  | Kw_doy
  | Kw_leading
  | Kw_trailing
  | Kw_both
  | Kw_sql_tsi_frac_second
  | Kw_sql_tsi_second
  | Kw_sql_tsi_minute
  | Kw_sql_tsi_hour
  | Kw_sql_tsi_day
  | Kw_sql_tsi_week
  | Kw_sql_tsi_month
  | Kw_sql_tsi_quarter
  | Kw_sql_tsi_year
  | Kw_insert
  | Kw_within
  | Kw_exception
  | Kw_serial
  | Kw_index
  | Kw_instead
  | Kw_view
  | Kw_enabled
  | Kw_disabled
  | Kw_key
  | Kw_document
  | Kw_content
  | Kw_empty
  | Kw_ordinality
  | Kw_path
  | Kw_querystring
  | Kw_namespace
  | Kw_result
  | Kw_accesspattern
  | Kw_auto_increment
  | Kw_wellformed
  | Kw_texttable
  | Kw_arraytable
  | Kw_jsontable
  | Kw_selector
  | Kw_skip
  | Kw_width
  | Kw_passing
  | Kw_name
  | Kw_columns
  | Kw_nulls
  | Kw_objecttable
  | Kw_version
  | Kw_including
  | Kw_excluding
  | Kw_xmldeclaration
  | Kw_variadic
  | Kw_raise
  | Kw_chain
  | Kw_jsonarray_agg
  | Kw_jsonobject
  | Kw_preserve
  | Kw_upsert
  | Kw_after
  | Kw_type
  | Kw_translator
  | Kw_jaas
  | Kw_condition
  | Kw_mask
  | Kw_access
  | Kw_control
  | Kw_none
  | Kw_data
  | Kw_database
  | Kw_privileges
  | Kw_role
  | Kw_schema
  | Kw_use
  | Kw_repository
  | Kw_rename
  | Kw_domain
  | Kw_usage
  | Kw_explain
  | Kw_analyze
  | Kw_text
  | Kw_format
  | Kw_yaml
  | Kw_policy
  | Kw_interval
  (* functions *)
  | Kw_convert
  | Kw_cast
  | Kw_substring
  | Kw_extract
  | Kw_trim
  | Kw_to_chars
  | Kw_to_bytes
  | Kw_timestampadd
  | Kw_timestampdiff
  | Kw_user
  | Kw_xmlconcat
  | Kw_xmlcomment
  | Kw_xmltext
  | Kw_translate
  | Kw_position
  | Kw_listagg
  | Kw_current_date
  | Kw_current_timestamp
  | Kw_current_time
  | Kw_session_user
  | Kw_tablesample
  | Kw_bernoulli
  | Kw_system
  | Kw_repeatable
  | Kw_unnest
  | Kw_module
  | Kw_collate
  | Kw_cube
  | Kw_grouping
  | Kw_sets
  | Kw_ties
  | Kw_others
  | Kw_exclude
  | Kw_window
  | Kw_using
  | Kw_natural
  | Kw_corresponding
  | Kw_recursive
  | Kw_cycle
  | Kw_default
  | Kw_set
  | Kw_depth
  | Kw_breadth
  | Kw_search
  | Kw_values
  | Kw_value
  (* tokens *)
  | Tok_ident of string
  | Tok_all_in_group of string
  | Tok_string of string
  | Tok_national_string of string
  | Tok_unicode_string of string
  | Tok_typed_string of string
  | Tok_bin_string of string
  | Tok_exact_numeric_literal of string
  | Tok_approximate_numeric_literal of string
  | Tok_unsigned_integer of string
  | Tok_lparen
  | Tok_rparen
  | Tok_period
  | Tok_comma
  | Tok_colon
  | Tok_dollar
  | Tok_lbrace
  | Tok_rbrace
  | Tok_lsbrace
  | Tok_rsbrace
  | Tok_qmark
  | Tok_semicolon
  | Tok_quote
  (* operators *)
  | Op_plus
  | Op_minus
  | Op_star
  | Op_slash
  | Op_double_amp
  | Op_concat
  | Op_eq
  | Op_ge
  | Op_gt
  | Op_le
  | Op_lt
  | Op_ne
  | Op_ne2
  | Tok_eof
[@@deriving show, eq]
