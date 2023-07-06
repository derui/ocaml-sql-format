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
      | Kw_string -> Fmt.string f @@ as_keyword "string" keyword
      | Kw_varchar -> Fmt.string f @@ as_keyword "varchar" keyword
      | Kw_boolean -> Fmt.string f @@ as_keyword "boolean" keyword
      | Kw_byte -> Fmt.string f @@ as_keyword "byte" keyword
      | Kw_tinyint -> Fmt.string f @@ as_keyword "tinyint" keyword
      | Kw_short -> Fmt.string f @@ as_keyword "short" keyword
      | Kw_smallint -> Fmt.string f @@ as_keyword "smallint" keyword
      | Kw_char -> Fmt.string f @@ as_keyword "char" keyword
      | Kw_integer -> Fmt.string f @@ as_keyword "integer" keyword
      | Kw_long -> Fmt.string f @@ as_keyword "long" keyword
      | Kw_bigint -> Fmt.string f @@ as_keyword "bigint" keyword
      | Kw_biginteger -> Fmt.string f @@ as_keyword "biginteger" keyword
      | Kw_float -> Fmt.string f @@ as_keyword "float" keyword
      | Kw_real -> Fmt.string f @@ as_keyword "real" keyword
      | Kw_double -> Fmt.string f @@ as_keyword "double" keyword
      | Kw_bigdecimal -> Fmt.string f @@ as_keyword "bigdecimal" keyword
      | Kw_decimal -> Fmt.string f @@ as_keyword "decimal" keyword
      | Kw_object -> Fmt.string f @@ as_keyword "object" keyword
      | Kw_blob -> Fmt.string f @@ as_keyword "blob" keyword
      | Kw_clob -> Fmt.string f @@ as_keyword "clob" keyword
      | Kw_json -> Fmt.string f @@ as_keyword "json" keyword
      | Kw_varbinary -> Fmt.string f @@ as_keyword "varbinary" keyword
      | Kw_geometry -> Fmt.string f @@ as_keyword "geometry" keyword
      | Kw_geography -> Fmt.string f @@ as_keyword "geography" keyword
      | Kw_xml -> Fmt.string f @@ as_keyword "xml" keyword
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
      | Kw_dow -> Fmt.string f @@ as_keyword "dow" keyword
      | Kw_doy -> Fmt.string f @@ as_keyword "doy" keyword
      | Kw_trim -> Fmt.string f @@ as_keyword "trim" keyword
      | Kw_leading -> Fmt.string f @@ as_keyword "leading" keyword
      | Kw_trailing -> Fmt.string f @@ as_keyword "trailing" keyword
      | Kw_both -> Fmt.string f @@ as_keyword "both" keyword
      | Kw_to_chars -> Fmt.string f @@ as_keyword "to_chars" keyword
      | Kw_to_bytes -> Fmt.string f @@ as_keyword "to_bytes" keyword
      | Kw_sql_tsi_frac_second ->
        Fmt.string f @@ as_keyword "sql_tsi_frac_second" keyword
      | Kw_sql_tsi_second -> Fmt.string f @@ as_keyword "sql_tsi_second" keyword
      | Kw_sql_tsi_hour -> Fmt.string f @@ as_keyword "sql_tsi_hour" keyword
      | Kw_sql_tsi_minute -> Fmt.string f @@ as_keyword "sql_tsi_minute" keyword
      | Kw_sql_tsi_day -> Fmt.string f @@ as_keyword "sql_tsi_day" keyword
      | Kw_sql_tsi_week -> Fmt.string f @@ as_keyword "sql_tsi_week" keyword
      | Kw_sql_tsi_month -> Fmt.string f @@ as_keyword "sql_tsi_month" keyword
      | Kw_sql_tsi_quarter ->
        Fmt.string f @@ as_keyword "sql_tsi_quarter" keyword
      | Kw_sql_tsi_year -> Fmt.string f @@ as_keyword "sql_tsi_year" keyword
      | Kw_timestampadd -> Fmt.string f @@ as_keyword "timestampadd" keyword
      | Kw_timestampdiff -> Fmt.string f @@ as_keyword "timestampdiff" keyword
      | Kw_user -> Fmt.string f @@ as_keyword "user" keyword
      | Kw_xmlconcat -> Fmt.string f @@ as_keyword "xmlconcat" keyword
      | Kw_xmlcomment -> Fmt.string f @@ as_keyword "xmlcomment" keyword
      | Kw_xmltext -> Fmt.string f @@ as_keyword "xmltext" keyword
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
      | Kw_xmldeclaration -> Fmt.string f @@ as_keyword "xmldeclaration" keyword
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
      | Tok_lparen -> Fmt.string f "("
      | Tok_rparen -> Fmt.string f ")"
      | Tok_ident v -> Fmt.string f v
      | Tok_all_in_group v -> Fmt.string f v
      | Tok_string v -> Fmt.string f v
      | Tok_national_string v -> Fmt.string f v
      | Tok_unicode_string v -> Fmt.string f v
      | Tok_typed_string v -> Fmt.string f v
      | Tok_bin_string v -> Fmt.string f v
      | Tok_unsigned_integer v -> Fmt.string f v
      | Tok_exact_numeric_literal v -> Fmt.string f v
      | Tok_approximate_numeric_literal v -> Fmt.string f v
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
      | Op_double_amp -> Fmt.string f "&&"
      | Op_eq -> Fmt.string f "="
      | Op_ge -> Fmt.string f ">="
      | Op_gt -> Fmt.string f ">"
      | Op_le -> Fmt.string f "<="
      | Op_lt -> Fmt.string f "<"
      | Op_ne -> Fmt.string f "<>"
      | Op_ne2 -> Fmt.string f "!="
      | Tok_eof -> failwith "Can not stringify EOF"
  end :
    PRINTER with type t = token)
