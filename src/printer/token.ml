open Types.Token
open Intf

let as_keyword original = function
  | `Upper -> String.uppercase_ascii original
  | `Lower -> String.lowercase_ascii original

include (
  struct
    type t = token

    let print f t ~option:{ Options.keyword; _ } =
      match t with
      | Kw_all -> Fmt.string f @@ as_keyword "all" keyword
      | Kw_select -> Fmt.string f @@ as_keyword "select" keyword
      | Kw_as -> Fmt.string f @@ as_keyword "as" keyword
      | Kw_from -> Fmt.string f @@ as_keyword "from" keyword
      | Kw_distinct -> Fmt.string f @@ as_keyword "distinct" keyword
      | Kw_true -> Fmt.string f @@ as_keyword "true" keyword
      | Kw_false -> Fmt.string f @@ as_keyword "false" keyword
      | Kw_unknown -> Fmt.string f @@ as_keyword "unknown" keyword
      | Kw_null -> Fmt.string f @@ as_keyword "null" keyword
      | Kw_date -> Fmt.string f @@ as_keyword "date" keyword
      | Kw_time -> Fmt.string f @@ as_keyword "time" keyword
      | Kw_timestamp -> Fmt.string f @@ as_keyword "timestamp" keyword
      | Kw_or -> Fmt.string f @@ as_keyword "or" keyword
      | Kw_not -> Fmt.string f @@ as_keyword "not" keyword
      | Kw_and -> Fmt.string f @@ as_keyword "and" keyword
      | Kw_into -> Fmt.string f @@ as_keyword "into" keyword
      | Kw_union -> Fmt.string f @@ as_keyword "union" keyword
      | Kw_except -> Fmt.string f @@ as_keyword "except" keyword
      | Kw_intersect -> Fmt.string f @@ as_keyword "intersect" keyword
      | Kw_by -> Fmt.string f @@ as_keyword "by" keyword
      | Kw_group -> Fmt.string f @@ as_keyword "group" keyword
      | Kw_rollup -> Fmt.string f @@ as_keyword "rollup" keyword
      | Kw_having -> Fmt.string f @@ as_keyword "having" keyword
      | Kw_where -> Fmt.string f @@ as_keyword "where" keyword
      | Kw_order -> Fmt.string f @@ as_keyword "order" keyword
      | Kw_asc -> Fmt.string f @@ as_keyword "asc" keyword
      | Kw_desc -> Fmt.string f @@ as_keyword "desc" keyword
      | Kw_first -> Fmt.string f @@ as_keyword "first" keyword
      | Kw_last -> Fmt.string f @@ as_keyword "last" keyword
      | Kw_limit -> Fmt.string f @@ as_keyword "limit" keyword
      | Kw_offset -> Fmt.string f @@ as_keyword "offset" keyword
      | Kw_row -> Fmt.string f @@ as_keyword "row" keyword
      | Kw_rows -> Fmt.string f @@ as_keyword "rows" keyword
      | Kw_fetch -> Fmt.string f @@ as_keyword "fetch" keyword
      | Kw_next -> Fmt.string f @@ as_keyword "next" keyword
      | Kw_only -> Fmt.string f @@ as_keyword "only" keyword
      | Kw_is -> Fmt.string f @@ as_keyword "is" keyword
      | Kw_between -> Fmt.string f @@ as_keyword "between" keyword
      | Kw_like_regex -> Fmt.string f @@ as_keyword "like_regex" keyword
      | Kw_similar -> Fmt.string f @@ as_keyword "similar" keyword
      | Kw_to -> Fmt.string f @@ as_keyword "to" keyword
      | Kw_escape -> Fmt.string f @@ as_keyword "escape" keyword
      | Kw_like -> Fmt.string f @@ as_keyword "like" keyword
      | Kw_any -> Fmt.string f @@ as_keyword "any" keyword
      | Kw_some -> Fmt.string f @@ as_keyword "some" keyword
      | Kw_in -> Fmt.string f @@ as_keyword "in" keyword
      | Kw_exists -> Fmt.string f @@ as_keyword "exists" keyword
      | Kw_with -> Fmt.string f @@ as_keyword "with" keyword
      | Kw_table -> Fmt.string f @@ as_keyword "table" keyword
      | Kw_lateral -> Fmt.string f @@ as_keyword "lateral" keyword
      | Kw_left -> Fmt.string f @@ as_keyword "left" keyword
      | Kw_right -> Fmt.string f @@ as_keyword "right" keyword
      | Kw_full -> Fmt.string f @@ as_keyword "full" keyword
      | Kw_outer -> Fmt.string f @@ as_keyword "outer" keyword
      | Kw_inner -> Fmt.string f @@ as_keyword "inner" keyword
      | Kw_cross -> Fmt.string f @@ as_keyword "cross" keyword
      | Kw_join -> Fmt.string f @@ as_keyword "join" keyword
      | Kw_on -> Fmt.string f @@ as_keyword "on" keyword
      | Kw_case -> Fmt.string f @@ as_keyword "case" keyword
      | Kw_when -> Fmt.string f @@ as_keyword "when" keyword
      | Kw_then -> Fmt.string f @@ as_keyword "then" keyword
      | Kw_end -> Fmt.string f @@ as_keyword "end" keyword
      | Kw_else -> Fmt.string f @@ as_keyword "else" keyword
      | Kw_textagg -> Fmt.string f @@ as_keyword "textagg" keyword
      | Kw_for -> Fmt.string f @@ as_keyword "for" keyword
      | Kw_delimiter -> Fmt.string f @@ as_keyword "delimiter" keyword
      | Kw_quote -> Fmt.string f @@ as_keyword "quote" keyword
      | Kw_no -> Fmt.string f @@ as_keyword "no" keyword
      | Kw_header -> Fmt.string f @@ as_keyword "header" keyword
      | Kw_encoding -> Fmt.string f @@ as_keyword "encoding" keyword
      | Kw_count -> Fmt.string f @@ as_keyword "count" keyword
      | Kw_count_big -> Fmt.string f @@ as_keyword "count_big" keyword
      | Kw_avg -> Fmt.string f @@ as_keyword "avg" keyword
      | Kw_sum -> Fmt.string f @@ as_keyword "sum" keyword
      | Kw_min -> Fmt.string f @@ as_keyword "min" keyword
      | Kw_max -> Fmt.string f @@ as_keyword "max" keyword
      | Kw_every -> Fmt.string f @@ as_keyword "every" keyword
      | Kw_stddev_pop -> Fmt.string f @@ as_keyword "stddev_pop" keyword
      | Kw_stddev_samp -> Fmt.string f @@ as_keyword "stddev_samp" keyword
      | Kw_var_samp -> Fmt.string f @@ as_keyword "var_samp" keyword
      | Kw_var_pop -> Fmt.string f @@ as_keyword "var_pop" keyword
      | Kw_filter -> Fmt.string f @@ as_keyword "filter" keyword
      | Kw_over -> Fmt.string f @@ as_keyword "over" keyword
      | Kw_partition -> Fmt.string f @@ as_keyword "partition" keyword
      | Kw_range -> Fmt.string f @@ as_keyword "range" keyword
      | Kw_unbounded -> Fmt.string f @@ as_keyword "unbounded" keyword
      | Kw_following -> Fmt.string f @@ as_keyword "following" keyword
      | Kw_preceding -> Fmt.string f @@ as_keyword "preceding" keyword
      | Kw_current -> Fmt.string f @@ as_keyword "current" keyword
      | Kw_row_number -> Fmt.string f @@ as_keyword "row_number" keyword
      | Kw_rank -> Fmt.string f @@ as_keyword "rank" keyword
      | Kw_dense_rank -> Fmt.string f @@ as_keyword "dense_rank" keyword
      | Kw_percent_rank -> Fmt.string f @@ as_keyword "percent_rank" keyword
      | Kw_cume_dist -> Fmt.string f @@ as_keyword "cume_dist" keyword
      | Kw_convert -> Fmt.string f @@ as_keyword "convert" keyword
      | Kw_cast -> Fmt.string f @@ as_keyword "cast" keyword
      | Kw_substring -> Fmt.string f @@ as_keyword "substring" keyword
      | Kw_extract -> Fmt.string f @@ as_keyword "extract" keyword
      | Kw_year -> Fmt.string f @@ as_keyword "year" keyword
      | Kw_month -> Fmt.string f @@ as_keyword "month" keyword
      | Kw_day -> Fmt.string f @@ as_keyword "day" keyword
      | Kw_hour -> Fmt.string f @@ as_keyword "hour" keyword
      | Kw_minute -> Fmt.string f @@ as_keyword "minute" keyword
      | Kw_second -> Fmt.string f @@ as_keyword "second" keyword
      | Kw_quarter -> Fmt.string f @@ as_keyword "quarter" keyword
      | Kw_epoch -> Fmt.string f @@ as_keyword "epoch" keyword
      | Kw_trim -> Fmt.string f @@ as_keyword "trim" keyword
      | Kw_leading -> Fmt.string f @@ as_keyword "leading" keyword
      | Kw_trailing -> Fmt.string f @@ as_keyword "trailing" keyword
      | Kw_both -> Fmt.string f @@ as_keyword "both" keyword
      | Kw_to_chars -> Fmt.string f @@ as_keyword "to_chars" keyword
      | Kw_to_bytes -> Fmt.string f @@ as_keyword "to_bytes" keyword
      | Kw_insert -> Fmt.string f @@ as_keyword "insert" keyword
      | Kw_translate -> Fmt.string f @@ as_keyword "translate" keyword
      | Kw_position -> Fmt.string f @@ as_keyword "position" keyword
      | Kw_listagg -> Fmt.string f @@ as_keyword "listagg" keyword
      | Kw_within -> Fmt.string f @@ as_keyword "within" keyword
      | Kw_current_date -> Fmt.string f @@ as_keyword "current_date" keyword
      | Kw_current_timestamp ->
        Fmt.string f @@ as_keyword "current_timestamp" keyword
      | Kw_current_time -> Fmt.string f @@ as_keyword "current_time" keyword
      | Kw_exception -> Fmt.string f @@ as_keyword "exception" keyword
      | Kw_serial -> Fmt.string f @@ as_keyword "serial" keyword
      | Kw_index -> Fmt.string f @@ as_keyword "index" keyword
      | Kw_instead -> Fmt.string f @@ as_keyword "instead" keyword
      | Kw_view -> Fmt.string f @@ as_keyword "view" keyword
      | Kw_enabled -> Fmt.string f @@ as_keyword "enabled" keyword
      | Kw_disabled -> Fmt.string f @@ as_keyword "disabled" keyword
      | Kw_key -> Fmt.string f @@ as_keyword "key" keyword
      | Kw_document -> Fmt.string f @@ as_keyword "document" keyword
      | Kw_content -> Fmt.string f @@ as_keyword "content" keyword
      | Kw_empty -> Fmt.string f @@ as_keyword "empty" keyword
      | Kw_ordinality -> Fmt.string f @@ as_keyword "ordinality" keyword
      | Kw_path -> Fmt.string f @@ as_keyword "path" keyword
      | Kw_querystring -> Fmt.string f @@ as_keyword "querystring" keyword
      | Kw_namespace -> Fmt.string f @@ as_keyword "namespace" keyword
      | Kw_result -> Fmt.string f @@ as_keyword "result" keyword
      | Kw_accesspattern -> Fmt.string f @@ as_keyword "accesspattern" keyword
      | Kw_auto_increment -> Fmt.string f @@ as_keyword "auto_increment" keyword
      | Kw_wellformed -> Fmt.string f @@ as_keyword "wellformed" keyword
      | Kw_texttable -> Fmt.string f @@ as_keyword "texttable" keyword
      | Kw_arraytable -> Fmt.string f @@ as_keyword "arraytable" keyword
      | Kw_jsontable -> Fmt.string f @@ as_keyword "jsontable" keyword
      | Kw_selector -> Fmt.string f @@ as_keyword "selector" keyword
      | Kw_skip -> Fmt.string f @@ as_keyword "skip" keyword
      | Kw_width -> Fmt.string f @@ as_keyword "width" keyword
      | Kw_passing -> Fmt.string f @@ as_keyword "passing" keyword
      | Kw_name -> Fmt.string f @@ as_keyword "name" keyword
      | Kw_columns -> Fmt.string f @@ as_keyword "columns" keyword
      | Kw_nulls -> Fmt.string f @@ as_keyword "nulls" keyword
      | Kw_objecttable -> Fmt.string f @@ as_keyword "objecttable" keyword
      | Kw_version -> Fmt.string f @@ as_keyword "version" keyword
      | Kw_including -> Fmt.string f @@ as_keyword "including" keyword
      | Kw_excluding -> Fmt.string f @@ as_keyword "excluding" keyword
      | Kw_variadic -> Fmt.string f @@ as_keyword "variadic" keyword
      | Kw_raise -> Fmt.string f @@ as_keyword "raise" keyword
      | Kw_chain -> Fmt.string f @@ as_keyword "chain" keyword
      | Kw_jsonarray_agg -> Fmt.string f @@ as_keyword "jsonarray_agg" keyword
      | Kw_jsonobject -> Fmt.string f @@ as_keyword "jsonobject" keyword
      | Kw_preserve -> Fmt.string f @@ as_keyword "preserve" keyword
      | Kw_upsert -> Fmt.string f @@ as_keyword "upsert" keyword
      | Kw_after -> Fmt.string f @@ as_keyword "after" keyword
      | Kw_type -> Fmt.string f @@ as_keyword "type" keyword
      | Kw_translator -> Fmt.string f @@ as_keyword "translator" keyword
      | Kw_jaas -> Fmt.string f @@ as_keyword "jaas" keyword
      | Kw_condition -> Fmt.string f @@ as_keyword "condition" keyword
      | Kw_mask -> Fmt.string f @@ as_keyword "mask" keyword
      | Kw_access -> Fmt.string f @@ as_keyword "access" keyword
      | Kw_control -> Fmt.string f @@ as_keyword "control" keyword
      | Kw_none -> Fmt.string f @@ as_keyword "none" keyword
      | Kw_data -> Fmt.string f @@ as_keyword "data" keyword
      | Kw_database -> Fmt.string f @@ as_keyword "database" keyword
      | Kw_privileges -> Fmt.string f @@ as_keyword "privileges" keyword
      | Kw_role -> Fmt.string f @@ as_keyword "role" keyword
      | Kw_schema -> Fmt.string f @@ as_keyword "schema" keyword
      | Kw_use -> Fmt.string f @@ as_keyword "use" keyword
      | Kw_repository -> Fmt.string f @@ as_keyword "repository" keyword
      | Kw_rename -> Fmt.string f @@ as_keyword "rename" keyword
      | Kw_domain -> Fmt.string f @@ as_keyword "domain" keyword
      | Kw_usage -> Fmt.string f @@ as_keyword "usage" keyword
      | Kw_explain -> Fmt.string f @@ as_keyword "explain" keyword
      | Kw_analyze -> Fmt.string f @@ as_keyword "analyze" keyword
      | Kw_text -> Fmt.string f @@ as_keyword "text" keyword
      | Kw_format -> Fmt.string f @@ as_keyword "format" keyword
      | Kw_yaml -> Fmt.string f @@ as_keyword "yaml" keyword
      | Kw_policy -> Fmt.string f @@ as_keyword "policy" keyword
      | Kw_session_user -> Fmt.string f @@ as_keyword "session_user" keyword
      | Kw_interval -> Fmt.string f @@ as_keyword "interval" keyword
      | Kw_tablesample -> Fmt.string f @@ as_keyword "tablesample" keyword
      | Kw_bernoulli -> Fmt.string f @@ as_keyword "bernoulli" keyword
      | Kw_system -> Fmt.string f @@ as_keyword "system" keyword
      | Kw_repeatable -> Fmt.string f @@ as_keyword "repeatable" keyword
      | Kw_unnest -> Fmt.string f @@ as_keyword "unnest" keyword
      | Kw_module -> Fmt.string f @@ as_keyword "module" keyword
      | Kw_collate -> Fmt.string f @@ as_keyword "collate" keyword
      | Kw_cube -> Fmt.string f @@ as_keyword "cube" keyword
      | Kw_grouping -> Fmt.string f @@ as_keyword "grouping" keyword
      | Kw_sets -> Fmt.string f @@ as_keyword "sets" keyword
      | Kw_ties -> Fmt.string f @@ as_keyword "ties" keyword
      | Kw_others -> Fmt.string f @@ as_keyword "others" keyword
      | Kw_exclude -> Fmt.string f @@ as_keyword "exclude" keyword
      | Kw_window -> Fmt.string f @@ as_keyword "window" keyword
      | Kw_using -> Fmt.string f @@ as_keyword "using" keyword
      | Kw_natural -> Fmt.string f @@ as_keyword "natural" keyword
      | Kw_corresponding -> Fmt.string f @@ as_keyword "corresponding" keyword
      | Kw_recursive -> Fmt.string f @@ as_keyword "recursive" keyword
      | Kw_cycle -> Fmt.string f @@ as_keyword "cycle" keyword
      | Kw_default -> Fmt.string f @@ as_keyword "default" keyword
      | Kw_set -> Fmt.string f @@ as_keyword "set" keyword
      | Kw_depth -> Fmt.string f @@ as_keyword "depth" keyword
      | Kw_breadth -> Fmt.string f @@ as_keyword "breadth" keyword
      | Kw_search -> Fmt.string f @@ as_keyword "search" keyword
      | Kw_values -> Fmt.string f @@ as_keyword "values" keyword
      | Kw_value -> Fmt.string f @@ as_keyword "value" keyword
      | Kw_element -> Fmt.string f @@ as_keyword "element" keyword
      | Kw_zone -> Fmt.string f @@ as_keyword "zone" keyword
      | Kw_local -> Fmt.string f @@ as_keyword "local" keyword
      | Kw_at -> Fmt.string f @@ as_keyword "at" keyword
      | Kw_abs -> Fmt.string f @@ as_keyword "abs" keyword
      | Kw_array -> Fmt.string f @@ as_keyword "array" keyword
      | Kw_multiset -> Fmt.string f @@ as_keyword "multiset" keyword
      | Kw_localtime -> Fmt.string f @@ as_keyword "localtime" keyword
      | Kw_localtimestamp -> Fmt.string f @@ as_keyword "localtimestamp" keyword
      | Kw_characters -> Fmt.string f @@ as_keyword "characters" keyword
      | Kw_code_units -> Fmt.string f @@ as_keyword "code_units" keyword
      | Kw_octets -> Fmt.string f @@ as_keyword "octets" keyword
      | Kw_without -> Fmt.string f @@ as_keyword "without" keyword
      | Kw_scope -> Fmt.string f @@ as_keyword "scope" keyword
      | Kw_ref -> Fmt.string f @@ as_keyword "ref" keyword
      | Kw_precision -> Fmt.string f @@ as_keyword "precision" keyword
      | Kw_numeric -> Fmt.string f @@ as_keyword "numeric" keyword
      | Kw_dec -> Fmt.string f @@ as_keyword "dec" keyword
      | Kw_int -> Fmt.string f @@ as_keyword "int" keyword
      | Kw_binary -> Fmt.string f @@ as_keyword "binary" keyword
      | Kw_large -> Fmt.string f @@ as_keyword "large" keyword
      | Kw_national -> Fmt.string f @@ as_keyword "national" keyword
      | Kw_varying -> Fmt.string f @@ as_keyword "varying" keyword
      | Kw_character -> Fmt.string f @@ as_keyword "character" keyword
      | Kw_nchar -> Fmt.string f @@ as_keyword "nchar" keyword
      | Kw_nclob -> Fmt.string f @@ as_keyword "nclob" keyword
      | Kw_collation -> Fmt.string f @@ as_keyword "collation" keyword
      | Kw_indicator -> Fmt.string f @@ as_keyword "indicator" keyword
      | Kw_current_user -> Fmt.string f @@ as_keyword "current_user" keyword
      | Kw_system_user -> Fmt.string f @@ as_keyword "system_user" keyword
      | Kw_current_default_transform_group ->
        Fmt.string f @@ as_keyword "current_default_transform_group" keyword
      | Kw_current_transform_group_for_type ->
        Fmt.string f @@ as_keyword "current_transform_group_for_type" keyword
      | Kw_current_path -> Fmt.string f @@ as_keyword "current_path" keyword
      | Kw_current_role -> Fmt.string f @@ as_keyword "current_role" keyword
      | Kw_nullif -> Fmt.string f @@ as_keyword "nullif" keyword
      | Kw_coalesce -> Fmt.string f @@ as_keyword "coalesce" keyword
      | Kw_groups -> Fmt.string f @@ as_keyword "groups" keyword
      | Kw_glob -> Fmt.string f @@ as_keyword "glob" keyword
      | Kw_match -> Fmt.string f @@ as_keyword "match" keyword
      | Kw_regexp -> Fmt.string f @@ as_keyword "regexp" keyword
      | Kw_materialized -> Fmt.string f @@ as_keyword "materialized" keyword
      | Kw_abort -> Fmt.string f @@ as_keyword "abort" keyword
      | Kw_ignore -> Fmt.string f @@ as_keyword "ignore" keyword
      | Kw_replace -> Fmt.string f @@ as_keyword "replace" keyword
      | Kw_rollback -> Fmt.string f @@ as_keyword "rollback" keyword
      | Kw_fail -> Fmt.string f @@ as_keyword "fail" keyword
      | Kw_update -> Fmt.string f @@ as_keyword "update" keyword
      | Kw_returning -> Fmt.string f @@ as_keyword "returning" keyword
      | Kw_delete -> Fmt.string f @@ as_keyword "delete" keyword
      | Kw_savepoint -> Fmt.string f @@ as_keyword "savepoint" keyword
      | Kw_transaction -> Fmt.string f @@ as_keyword "transaction" keyword
      | Kw_if -> Fmt.string f @@ as_keyword "if" keyword
      | Kw_drop -> Fmt.string f @@ as_keyword "drop" keyword
      | Kw_begin -> Fmt.string f @@ as_keyword "begin" keyword
      | Kw_commit -> Fmt.string f @@ as_keyword "commit" keyword
      (* 'token *)
      | Tok_lparen -> Fmt.string f "("
      | Tok_rparen -> Fmt.string f ")"
      | Tok_ident v -> Fmt.string f v
      | Tok_string v -> Fmt.string f v
      | Tok_numeric v -> Fmt.string f v
      | Tok_blob v -> Fmt.string f v
      | Tok_period -> Fmt.string f "."
      | Tok_comma -> Fmt.string f ","
      | Tok_colon -> Fmt.string f ":"
      | Tok_dollar -> Fmt.string f "$"
      | Tok_lbrace -> Fmt.string f "{"
      | Tok_rbrace -> Fmt.string f "}"
      | Tok_lsbrace -> Fmt.string f "["
      | Tok_rsbrace -> Fmt.string f "]"
      | Tok_qmark -> Fmt.string f "?"
      | Tok_semicolon -> Fmt.string f ";"
      | Tok_quote -> Fmt.string f "'"
      | Op_plus -> Fmt.string f "+"
      | Op_minus -> Fmt.string f "-"
      | Op_star -> Fmt.string f "*"
      | Op_slash -> Fmt.string f "/"
      | Op_concat -> Fmt.string f "||"
      | Op_amp -> Fmt.string f "&"
      | Op_pipe -> Fmt.string f "|"
      | Op_eq -> Fmt.string f "="
      | Op_eq2 -> Fmt.string f "=="
      | Op_ge -> Fmt.string f ">="
      | Op_gt -> Fmt.string f ">"
      | Op_le -> Fmt.string f "<="
      | Op_lt -> Fmt.string f "<"
      | Op_ne -> Fmt.string f "<>"
      | Op_ne2 -> Fmt.string f "!="
      | Op_extract -> Fmt.string f "->"
      | Op_extract_2 -> Fmt.string f "->>"
      | Op_tilda -> Fmt.string f "~"
      | Op_lshift -> Fmt.string f "<<"
      | Op_rshift -> Fmt.string f ">>"
      | Tok_eof -> failwith "Can not stringify EOF"
  end :
    PRINTER with type t = token)
