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
  | Kw_year
  | Kw_month
  | Kw_day
  | Kw_hour
  | Kw_minute
  | Kw_second
  | Kw_quarter
  | Kw_epoch
  | Kw_leading
  | Kw_trailing
  | Kw_both
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
  | Kw_element
  | Kw_zone
  | Kw_local
  | Kw_at
  | Kw_abs
  | Kw_array
  | Kw_multiset
  | Kw_localtime
  | Kw_localtimestamp
  | Kw_characters
  | Kw_code_units
  | Kw_octets
  | Kw_without
  | Kw_scope
  | Kw_ref
  | Kw_precision
  | Kw_numeric
  | Kw_dec
  | Kw_int
  | Kw_binary
  | Kw_large
  | Kw_national
  | Kw_varying
  | Kw_character
  | Kw_nchar
  | Kw_nclob
  | Kw_collation
  | Kw_indicator
  | Kw_current_user
  | Kw_system_user
  | Kw_current_default_transform_group
  | Kw_current_transform_group_for_type
  | Kw_current_path
  | Kw_current_role
  | Kw_nullif
  | Kw_coalesce
  | Kw_groups
  | Kw_glob
  | Kw_match
  | Kw_regexp
  | Kw_materialized
  | Kw_abort
  | Kw_ignore
  | Kw_replace
  | Kw_rollback
  | Kw_fail
  | Kw_update
  | Kw_returning
  | Kw_delete
  | Kw_savepoint
  | Kw_transaction
  | Kw_if
  | Kw_drop
  | Kw_begin
  | Kw_commit
  | Kw_trigger
  | Kw_references
  | Kw_constraint
  | Kw_primary
  | Kw_unique
  | Kw_generated
  | Kw_always
  | Kw_check
  (* tokens *)
  | Tok_ident of string
  | Tok_string of string
  | Tok_blob of string
  | Tok_numeric of string
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
  | Op_amp
  | Op_pipe
  | Op_concat
  | Op_eq
  | Op_eq2
  | Op_ge
  | Op_gt
  | Op_le
  | Op_lt
  | Op_ne
  | Op_ne2
  | Op_extract
  | Op_extract_2
  | Op_tilda
  | Op_lshift
  | Op_rshift
  | Tok_eof
[@@deriving show, eq]
