open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext basic_non_reserved

module Make () : S = struct
  type t = ext basic_non_reserved

  let print f t ~option =
    match t with
    | Basic_non_reserved (kw, _) ->
      let kw =
        match kw with
        | `instead -> Kw_instead
        | `view -> Kw_view
        | `enabled -> Kw_enabled
        | `disabled -> Kw_disabled
        | `key -> Kw_key
        | `textagg -> Kw_textagg
        | `count -> Kw_count
        | `count_big -> Kw_count_big
        | `row_number -> Kw_row_number
        | `rank -> Kw_rank
        | `dense_rank -> Kw_dense_rank
        | `sum -> Kw_sum
        | `avg -> Kw_avg
        | `min -> Kw_min
        | `max -> Kw_max
        | `every -> Kw_every
        | `stddev_pop -> Kw_stddev_pop
        | `stddev_samp -> Kw_stddev_samp
        | `var_samp -> Kw_var_samp
        | `var_pop -> Kw_var_pop
        | `document -> Kw_document
        | `content -> Kw_content
        | `trim -> Kw_trim
        | `empty -> Kw_empty
        | `ordinality -> Kw_ordinality
        | `path -> Kw_path
        | `first -> Kw_first
        | `last -> Kw_last
        | `next -> Kw_next
        | `substring -> Kw_substring
        | `extract -> Kw_extract
        | `to_chars -> Kw_to_chars
        | `to_bytes -> Kw_to_bytes
        | `timestampadd -> Kw_timestampadd
        | `timestampdiff -> Kw_timestampdiff
        | `querystring -> Kw_querystring
        | `namespace -> Kw_namespace
        | `result -> Kw_result
        | `accesspattern -> Kw_accesspattern
        | `auto_increment -> Kw_auto_increment
        | `wellformed -> Kw_wellformed
        | `sql_tsi_frac_second -> Kw_sql_tsi_frac_second
        | `sql_tsi_second -> Kw_sql_tsi_second
        | `sql_tsi_minute -> Kw_sql_tsi_minute
        | `sql_tsi_hour -> Kw_sql_tsi_hour
        | `sql_tsi_day -> Kw_sql_tsi_day
        | `sql_tsi_week -> Kw_sql_tsi_week
        | `sql_tsi_month -> Kw_sql_tsi_month
        | `sql_tsi_quarter -> Kw_sql_tsi_quarter
        | `sql_tsi_year -> Kw_sql_tsi_year
        | `texttable -> Kw_texttable
        | `arraytable -> Kw_arraytable
        | `jsontable -> Kw_jsontable
        | `selector -> Kw_selector
        | `skip -> Kw_skip
        | `width -> Kw_width
        | `passing -> Kw_passing
        | `name -> Kw_name
        | `encoding -> Kw_encoding
        | `columns -> Kw_columns
        | `delimiter -> Kw_delimiter
        | `quote -> Kw_quote
        | `header -> Kw_header
        | `nulls -> Kw_nulls
        | `objecttable -> Kw_objecttable
        | `version -> Kw_version
        | `including -> Kw_including
        | `excluding -> Kw_excluding
        | `xmldeclaration -> Kw_xmldeclaration
        | `variadic -> Kw_variadic
        | `raise -> Kw_raise
        | `chain -> Kw_chain
        | `jsonarray_agg -> Kw_jsonarray_agg
        | `jsonobject -> Kw_jsonobject
        | `preserve -> Kw_preserve
        | `upsert -> Kw_upsert
        | `after -> Kw_after
        | `type' -> Kw_type
        | `translator -> Kw_translator
        | `jaas -> Kw_jaas
        | `condition -> Kw_condition
        | `mask -> Kw_mask
        | `access -> Kw_access
        | `control -> Kw_control
        | `none -> Kw_none
        | `data -> Kw_data
        | `database -> Kw_database
        | `privileges -> Kw_privileges
        | `role -> Kw_role
        | `schema -> Kw_schema
        | `use -> Kw_use
        | `repository -> Kw_repository
        | `rename -> Kw_rename
        | `domain -> Kw_domain
        | `usage -> Kw_usage
        | `position -> Kw_position
        | `current -> Kw_current
        | `unbounded -> Kw_unbounded
        | `preceding -> Kw_preceding
        | `following -> Kw_following
        | `listagg -> Kw_listagg
        | `explain -> Kw_explain
        | `analyze -> Kw_analyze
        | `text -> Kw_text
        | `format -> Kw_format
        | `yaml -> Kw_yaml
        | `epoch -> Kw_epoch
        | `quarter -> Kw_quarter
        | `policy -> Kw_policy
      in
      Printer_token.print f kw ~option
end
