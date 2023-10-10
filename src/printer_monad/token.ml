open Types.Token
open Intf
module M = Monad

let as_keyword original = function
  | `Upper -> String.uppercase_ascii original
  | `Lower -> String.lowercase_ascii original

include (
  struct
    let print () =
      let open M.Let_syntax in
      let* options = M.options () in
      let* c = M.current () in
      let* kw =
        match c with
        | Kw_all -> M.return @@ as_keyword "all" options.Options.keyword
        | Kw_select -> M.return @@ as_keyword "select" options.Options.keyword
        | Kw_as -> M.return @@ as_keyword "as" options.Options.keyword
        | Kw_from -> M.return @@ as_keyword "from" options.Options.keyword
        | Kw_distinct ->
          M.return @@ as_keyword "distinct" options.Options.keyword
        | Kw_true -> M.return @@ as_keyword "true" options.Options.keyword
        | Kw_false -> M.return @@ as_keyword "false" options.Options.keyword
        | Kw_unknown -> M.return @@ as_keyword "unknown" options.Options.keyword
        | Kw_null -> M.return @@ as_keyword "null" options.Options.keyword
        | Kw_date -> M.return @@ as_keyword "date" options.Options.keyword
        | Kw_time -> M.return @@ as_keyword "time" options.Options.keyword
        | Kw_timestamp ->
          M.return @@ as_keyword "timestamp" options.Options.keyword
        | Kw_or -> M.return @@ as_keyword "or" options.Options.keyword
        | Kw_not -> M.return @@ as_keyword "not" options.Options.keyword
        | Kw_and -> M.return @@ as_keyword "and" options.Options.keyword
        | Kw_into -> M.return @@ as_keyword "into" options.Options.keyword
        | Kw_union -> M.return @@ as_keyword "union" options.Options.keyword
        | Kw_except -> M.return @@ as_keyword "except" options.Options.keyword
        | Kw_intersect ->
          M.return @@ as_keyword "intersect" options.Options.keyword
        | Kw_by -> M.return @@ as_keyword "by" options.Options.keyword
        | Kw_group -> M.return @@ as_keyword "group" options.Options.keyword
        | Kw_rollup -> M.return @@ as_keyword "rollup" options.Options.keyword
        | Kw_having -> M.return @@ as_keyword "having" options.Options.keyword
        | Kw_where -> M.return @@ as_keyword "where" options.Options.keyword
        | Kw_order -> M.return @@ as_keyword "order" options.Options.keyword
        | Kw_asc -> M.return @@ as_keyword "asc" options.Options.keyword
        | Kw_desc -> M.return @@ as_keyword "desc" options.Options.keyword
        | Kw_first -> M.return @@ as_keyword "first" options.Options.keyword
        | Kw_last -> M.return @@ as_keyword "last" options.Options.keyword
        | Kw_limit -> M.return @@ as_keyword "limit" options.Options.keyword
        | Kw_offset -> M.return @@ as_keyword "offset" options.Options.keyword
        | Kw_row -> M.return @@ as_keyword "row" options.Options.keyword
        | Kw_rows -> M.return @@ as_keyword "rows" options.Options.keyword
        | Kw_fetch -> M.return @@ as_keyword "fetch" options.Options.keyword
        | Kw_next -> M.return @@ as_keyword "next" options.Options.keyword
        | Kw_only -> M.return @@ as_keyword "only" options.Options.keyword
        | Kw_is -> M.return @@ as_keyword "is" options.Options.keyword
        | Kw_between -> M.return @@ as_keyword "between" options.Options.keyword
        | Kw_like_regex ->
          M.return @@ as_keyword "like_regex" options.Options.keyword
        | Kw_similar -> M.return @@ as_keyword "similar" options.Options.keyword
        | Kw_to -> M.return @@ as_keyword "to" options.Options.keyword
        | Kw_escape -> M.return @@ as_keyword "escape" options.Options.keyword
        | Kw_like -> M.return @@ as_keyword "like" options.Options.keyword
        | Kw_any -> M.return @@ as_keyword "any" options.Options.keyword
        | Kw_some -> M.return @@ as_keyword "some" options.Options.keyword
        | Kw_in -> M.return @@ as_keyword "in" options.Options.keyword
        | Kw_exists -> M.return @@ as_keyword "exists" options.Options.keyword
        | Kw_with -> M.return @@ as_keyword "with" options.Options.keyword
        | Kw_table -> M.return @@ as_keyword "table" options.Options.keyword
        | Kw_lateral -> M.return @@ as_keyword "lateral" options.Options.keyword
        | Kw_left -> M.return @@ as_keyword "left" options.Options.keyword
        | Kw_right -> M.return @@ as_keyword "right" options.Options.keyword
        | Kw_full -> M.return @@ as_keyword "full" options.Options.keyword
        | Kw_outer -> M.return @@ as_keyword "outer" options.Options.keyword
        | Kw_inner -> M.return @@ as_keyword "inner" options.Options.keyword
        | Kw_cross -> M.return @@ as_keyword "cross" options.Options.keyword
        | Kw_join -> M.return @@ as_keyword "join" options.Options.keyword
        | Kw_on -> M.return @@ as_keyword "on" options.Options.keyword
        | Kw_case -> M.return @@ as_keyword "case" options.Options.keyword
        | Kw_when -> M.return @@ as_keyword "when" options.Options.keyword
        | Kw_then -> M.return @@ as_keyword "then" options.Options.keyword
        | Kw_end -> M.return @@ as_keyword "end" options.Options.keyword
        | Kw_else -> M.return @@ as_keyword "else" options.Options.keyword
        | Kw_textagg -> M.return @@ as_keyword "textagg" options.Options.keyword
        | Kw_for -> M.return @@ as_keyword "for" options.Options.keyword
        | Kw_delimiter ->
          M.return @@ as_keyword "delimiter" options.Options.keyword
        | Kw_quote -> M.return @@ as_keyword "quote" options.Options.keyword
        | Kw_no -> M.return @@ as_keyword "no" options.Options.keyword
        | Kw_header -> M.return @@ as_keyword "header" options.Options.keyword
        | Kw_encoding ->
          M.return @@ as_keyword "encoding" options.Options.keyword
        | Kw_count -> M.return @@ as_keyword "count" options.Options.keyword
        | Kw_count_big ->
          M.return @@ as_keyword "count_big" options.Options.keyword
        | Kw_avg -> M.return @@ as_keyword "avg" options.Options.keyword
        | Kw_sum -> M.return @@ as_keyword "sum" options.Options.keyword
        | Kw_min -> M.return @@ as_keyword "min" options.Options.keyword
        | Kw_max -> M.return @@ as_keyword "max" options.Options.keyword
        | Kw_every -> M.return @@ as_keyword "every" options.Options.keyword
        | Kw_stddev_pop ->
          M.return @@ as_keyword "stddev_pop" options.Options.keyword
        | Kw_stddev_samp ->
          M.return @@ as_keyword "stddev_samp" options.Options.keyword
        | Kw_var_samp ->
          M.return @@ as_keyword "var_samp" options.Options.keyword
        | Kw_var_pop -> M.return @@ as_keyword "var_pop" options.Options.keyword
        | Kw_filter -> M.return @@ as_keyword "filter" options.Options.keyword
        | Kw_over -> M.return @@ as_keyword "over" options.Options.keyword
        | Kw_partition ->
          M.return @@ as_keyword "partition" options.Options.keyword
        | Kw_range -> M.return @@ as_keyword "range" options.Options.keyword
        | Kw_unbounded ->
          M.return @@ as_keyword "unbounded" options.Options.keyword
        | Kw_following ->
          M.return @@ as_keyword "following" options.Options.keyword
        | Kw_preceding ->
          M.return @@ as_keyword "preceding" options.Options.keyword
        | Kw_current -> M.return @@ as_keyword "current" options.Options.keyword
        | Kw_row_number ->
          M.return @@ as_keyword "row_number" options.Options.keyword
        | Kw_rank -> M.return @@ as_keyword "rank" options.Options.keyword
        | Kw_dense_rank ->
          M.return @@ as_keyword "dense_rank" options.Options.keyword
        | Kw_percent_rank ->
          M.return @@ as_keyword "percent_rank" options.Options.keyword
        | Kw_cume_dist ->
          M.return @@ as_keyword "cume_dist" options.Options.keyword
        | Kw_convert -> M.return @@ as_keyword "convert" options.Options.keyword
        | Kw_cast -> M.return @@ as_keyword "cast" options.Options.keyword
        | Kw_substring ->
          M.return @@ as_keyword "substring" options.Options.keyword
        | Kw_extract -> M.return @@ as_keyword "extract" options.Options.keyword
        | Kw_year -> M.return @@ as_keyword "year" options.Options.keyword
        | Kw_month -> M.return @@ as_keyword "month" options.Options.keyword
        | Kw_day -> M.return @@ as_keyword "day" options.Options.keyword
        | Kw_hour -> M.return @@ as_keyword "hour" options.Options.keyword
        | Kw_minute -> M.return @@ as_keyword "minute" options.Options.keyword
        | Kw_second -> M.return @@ as_keyword "second" options.Options.keyword
        | Kw_quarter -> M.return @@ as_keyword "quarter" options.Options.keyword
        | Kw_epoch -> M.return @@ as_keyword "epoch" options.Options.keyword
        | Kw_trim -> M.return @@ as_keyword "trim" options.Options.keyword
        | Kw_leading -> M.return @@ as_keyword "leading" options.Options.keyword
        | Kw_trailing ->
          M.return @@ as_keyword "trailing" options.Options.keyword
        | Kw_both -> M.return @@ as_keyword "both" options.Options.keyword
        | Kw_to_chars ->
          M.return @@ as_keyword "to_chars" options.Options.keyword
        | Kw_to_bytes ->
          M.return @@ as_keyword "to_bytes" options.Options.keyword
        | Kw_insert -> M.return @@ as_keyword "insert" options.Options.keyword
        | Kw_translate ->
          M.return @@ as_keyword "translate" options.Options.keyword
        | Kw_position ->
          M.return @@ as_keyword "position" options.Options.keyword
        | Kw_listagg -> M.return @@ as_keyword "listagg" options.Options.keyword
        | Kw_within -> M.return @@ as_keyword "within" options.Options.keyword
        | Kw_current_date ->
          M.return @@ as_keyword "current_date" options.Options.keyword
        | Kw_current_timestamp ->
          M.return @@ as_keyword "current_timestamp" options.Options.keyword
        | Kw_current_time ->
          M.return @@ as_keyword "current_time" options.Options.keyword
        | Kw_exception ->
          M.return @@ as_keyword "exception" options.Options.keyword
        | Kw_serial -> M.return @@ as_keyword "serial" options.Options.keyword
        | Kw_index -> M.return @@ as_keyword "index" options.Options.keyword
        | Kw_instead -> M.return @@ as_keyword "instead" options.Options.keyword
        | Kw_view -> M.return @@ as_keyword "view" options.Options.keyword
        | Kw_enabled -> M.return @@ as_keyword "enabled" options.Options.keyword
        | Kw_disabled ->
          M.return @@ as_keyword "disabled" options.Options.keyword
        | Kw_key -> M.return @@ as_keyword "key" options.Options.keyword
        | Kw_document ->
          M.return @@ as_keyword "document" options.Options.keyword
        | Kw_content -> M.return @@ as_keyword "content" options.Options.keyword
        | Kw_empty -> M.return @@ as_keyword "empty" options.Options.keyword
        | Kw_ordinality ->
          M.return @@ as_keyword "ordinality" options.Options.keyword
        | Kw_path -> M.return @@ as_keyword "path" options.Options.keyword
        | Kw_querystring ->
          M.return @@ as_keyword "querystring" options.Options.keyword
        | Kw_namespace ->
          M.return @@ as_keyword "namespace" options.Options.keyword
        | Kw_result -> M.return @@ as_keyword "result" options.Options.keyword
        | Kw_accesspattern ->
          M.return @@ as_keyword "accesspattern" options.Options.keyword
        | Kw_auto_increment ->
          M.return @@ as_keyword "auto_increment" options.Options.keyword
        | Kw_wellformed ->
          M.return @@ as_keyword "wellformed" options.Options.keyword
        | Kw_texttable ->
          M.return @@ as_keyword "texttable" options.Options.keyword
        | Kw_arraytable ->
          M.return @@ as_keyword "arraytable" options.Options.keyword
        | Kw_jsontable ->
          M.return @@ as_keyword "jsontable" options.Options.keyword
        | Kw_selector ->
          M.return @@ as_keyword "selector" options.Options.keyword
        | Kw_skip -> M.return @@ as_keyword "skip" options.Options.keyword
        | Kw_width -> M.return @@ as_keyword "width" options.Options.keyword
        | Kw_passing -> M.return @@ as_keyword "passing" options.Options.keyword
        | Kw_name -> M.return @@ as_keyword "name" options.Options.keyword
        | Kw_columns -> M.return @@ as_keyword "columns" options.Options.keyword
        | Kw_nulls -> M.return @@ as_keyword "nulls" options.Options.keyword
        | Kw_objecttable ->
          M.return @@ as_keyword "objecttable" options.Options.keyword
        | Kw_version -> M.return @@ as_keyword "version" options.Options.keyword
        | Kw_including ->
          M.return @@ as_keyword "including" options.Options.keyword
        | Kw_excluding ->
          M.return @@ as_keyword "excluding" options.Options.keyword
        | Kw_variadic ->
          M.return @@ as_keyword "variadic" options.Options.keyword
        | Kw_raise -> M.return @@ as_keyword "raise" options.Options.keyword
        | Kw_chain -> M.return @@ as_keyword "chain" options.Options.keyword
        | Kw_jsonarray_agg ->
          M.return @@ as_keyword "jsonarray_agg" options.Options.keyword
        | Kw_jsonobject ->
          M.return @@ as_keyword "jsonobject" options.Options.keyword
        | Kw_preserve ->
          M.return @@ as_keyword "preserve" options.Options.keyword
        | Kw_upsert -> M.return @@ as_keyword "upsert" options.Options.keyword
        | Kw_after -> M.return @@ as_keyword "after" options.Options.keyword
        | Kw_type -> M.return @@ as_keyword "type" options.Options.keyword
        | Kw_translator ->
          M.return @@ as_keyword "translator" options.Options.keyword
        | Kw_jaas -> M.return @@ as_keyword "jaas" options.Options.keyword
        | Kw_condition ->
          M.return @@ as_keyword "condition" options.Options.keyword
        | Kw_mask -> M.return @@ as_keyword "mask" options.Options.keyword
        | Kw_access -> M.return @@ as_keyword "access" options.Options.keyword
        | Kw_control -> M.return @@ as_keyword "control" options.Options.keyword
        | Kw_none -> M.return @@ as_keyword "none" options.Options.keyword
        | Kw_data -> M.return @@ as_keyword "data" options.Options.keyword
        | Kw_database ->
          M.return @@ as_keyword "database" options.Options.keyword
        | Kw_privileges ->
          M.return @@ as_keyword "privileges" options.Options.keyword
        | Kw_role -> M.return @@ as_keyword "role" options.Options.keyword
        | Kw_schema -> M.return @@ as_keyword "schema" options.Options.keyword
        | Kw_use -> M.return @@ as_keyword "use" options.Options.keyword
        | Kw_repository ->
          M.return @@ as_keyword "repository" options.Options.keyword
        | Kw_rename -> M.return @@ as_keyword "rename" options.Options.keyword
        | Kw_domain -> M.return @@ as_keyword "domain" options.Options.keyword
        | Kw_usage -> M.return @@ as_keyword "usage" options.Options.keyword
        | Kw_explain -> M.return @@ as_keyword "explain" options.Options.keyword
        | Kw_analyze -> M.return @@ as_keyword "analyze" options.Options.keyword
        | Kw_text -> M.return @@ as_keyword "text" options.Options.keyword
        | Kw_format -> M.return @@ as_keyword "format" options.Options.keyword
        | Kw_yaml -> M.return @@ as_keyword "yaml" options.Options.keyword
        | Kw_policy -> M.return @@ as_keyword "policy" options.Options.keyword
        | Kw_session_user ->
          M.return @@ as_keyword "session_user" options.Options.keyword
        | Kw_interval ->
          M.return @@ as_keyword "interval" options.Options.keyword
        | Kw_tablesample ->
          M.return @@ as_keyword "tablesample" options.Options.keyword
        | Kw_bernoulli ->
          M.return @@ as_keyword "bernoulli" options.Options.keyword
        | Kw_system -> M.return @@ as_keyword "system" options.Options.keyword
        | Kw_repeatable ->
          M.return @@ as_keyword "repeatable" options.Options.keyword
        | Kw_unnest -> M.return @@ as_keyword "unnest" options.Options.keyword
        | Kw_module -> M.return @@ as_keyword "module" options.Options.keyword
        | Kw_collate -> M.return @@ as_keyword "collate" options.Options.keyword
        | Kw_cube -> M.return @@ as_keyword "cube" options.Options.keyword
        | Kw_grouping ->
          M.return @@ as_keyword "grouping" options.Options.keyword
        | Kw_sets -> M.return @@ as_keyword "sets" options.Options.keyword
        | Kw_ties -> M.return @@ as_keyword "ties" options.Options.keyword
        | Kw_others -> M.return @@ as_keyword "others" options.Options.keyword
        | Kw_exclude -> M.return @@ as_keyword "exclude" options.Options.keyword
        | Kw_window -> M.return @@ as_keyword "window" options.Options.keyword
        | Kw_using -> M.return @@ as_keyword "using" options.Options.keyword
        | Kw_natural -> M.return @@ as_keyword "natural" options.Options.keyword
        | Kw_corresponding ->
          M.return @@ as_keyword "corresponding" options.Options.keyword
        | Kw_recursive ->
          M.return @@ as_keyword "recursive" options.Options.keyword
        | Kw_cycle -> M.return @@ as_keyword "cycle" options.Options.keyword
        | Kw_default -> M.return @@ as_keyword "default" options.Options.keyword
        | Kw_set -> M.return @@ as_keyword "set" options.Options.keyword
        | Kw_depth -> M.return @@ as_keyword "depth" options.Options.keyword
        | Kw_breadth -> M.return @@ as_keyword "breadth" options.Options.keyword
        | Kw_search -> M.return @@ as_keyword "search" options.Options.keyword
        | Kw_values -> M.return @@ as_keyword "values" options.Options.keyword
        | Kw_value -> M.return @@ as_keyword "value" options.Options.keyword
        | Kw_element -> M.return @@ as_keyword "element" options.Options.keyword
        | Kw_zone -> M.return @@ as_keyword "zone" options.Options.keyword
        | Kw_local -> M.return @@ as_keyword "local" options.Options.keyword
        | Kw_at -> M.return @@ as_keyword "at" options.Options.keyword
        | Kw_abs -> M.return @@ as_keyword "abs" options.Options.keyword
        | Kw_array -> M.return @@ as_keyword "array" options.Options.keyword
        | Kw_multiset ->
          M.return @@ as_keyword "multiset" options.Options.keyword
        | Kw_localtime ->
          M.return @@ as_keyword "localtime" options.Options.keyword
        | Kw_localtimestamp ->
          M.return @@ as_keyword "localtimestamp" options.Options.keyword
        | Kw_characters ->
          M.return @@ as_keyword "characters" options.Options.keyword
        | Kw_code_units ->
          M.return @@ as_keyword "code_units" options.Options.keyword
        | Kw_octets -> M.return @@ as_keyword "octets" options.Options.keyword
        | Kw_without -> M.return @@ as_keyword "without" options.Options.keyword
        | Kw_scope -> M.return @@ as_keyword "scope" options.Options.keyword
        | Kw_ref -> M.return @@ as_keyword "ref" options.Options.keyword
        | Kw_precision ->
          M.return @@ as_keyword "precision" options.Options.keyword
        | Kw_numeric -> M.return @@ as_keyword "numeric" options.Options.keyword
        | Kw_dec -> M.return @@ as_keyword "dec" options.Options.keyword
        | Kw_int -> M.return @@ as_keyword "int" options.Options.keyword
        | Kw_binary -> M.return @@ as_keyword "binary" options.Options.keyword
        | Kw_large -> M.return @@ as_keyword "large" options.Options.keyword
        | Kw_national ->
          M.return @@ as_keyword "national" options.Options.keyword
        | Kw_varying -> M.return @@ as_keyword "varying" options.Options.keyword
        | Kw_character ->
          M.return @@ as_keyword "character" options.Options.keyword
        | Kw_nchar -> M.return @@ as_keyword "nchar" options.Options.keyword
        | Kw_nclob -> M.return @@ as_keyword "nclob" options.Options.keyword
        | Kw_collation ->
          M.return @@ as_keyword "collation" options.Options.keyword
        | Kw_indicator ->
          M.return @@ as_keyword "indicator" options.Options.keyword
        | Kw_current_user ->
          M.return @@ as_keyword "current_user" options.Options.keyword
        | Kw_system_user ->
          M.return @@ as_keyword "system_user" options.Options.keyword
        | Kw_current_default_transform_group ->
          M.return
          @@ as_keyword "current_default_transform_group"
               options.Options.keyword
        | Kw_current_transform_group_for_type ->
          M.return
          @@ as_keyword "current_transform_group_for_type"
               options.Options.keyword
        | Kw_current_path ->
          M.return @@ as_keyword "current_path" options.Options.keyword
        | Kw_current_role ->
          M.return @@ as_keyword "current_role" options.Options.keyword
        | Kw_nullif -> M.return @@ as_keyword "nullif" options.Options.keyword
        | Kw_coalesce ->
          M.return @@ as_keyword "coalesce" options.Options.keyword
        | Kw_groups -> M.return @@ as_keyword "groups" options.Options.keyword
        | Kw_glob -> M.return @@ as_keyword "glob" options.Options.keyword
        | Kw_match -> M.return @@ as_keyword "match" options.Options.keyword
        | Kw_regexp -> M.return @@ as_keyword "regexp" options.Options.keyword
        | Kw_materialized ->
          M.return @@ as_keyword "materialized" options.Options.keyword
        | Kw_abort -> M.return @@ as_keyword "abort" options.Options.keyword
        | Kw_ignore -> M.return @@ as_keyword "ignore" options.Options.keyword
        | Kw_replace -> M.return @@ as_keyword "replace" options.Options.keyword
        | Kw_rollback ->
          M.return @@ as_keyword "rollback" options.Options.keyword
        | Kw_fail -> M.return @@ as_keyword "fail" options.Options.keyword
        | Kw_update -> M.return @@ as_keyword "update" options.Options.keyword
        | Kw_returning ->
          M.return @@ as_keyword "returning" options.Options.keyword
        | Kw_delete -> M.return @@ as_keyword "delete" options.Options.keyword
        | Kw_savepoint ->
          M.return @@ as_keyword "savepoint" options.Options.keyword
        | Kw_transaction ->
          M.return @@ as_keyword "transaction" options.Options.keyword
        | Kw_if -> M.return @@ as_keyword "if" options.Options.keyword
        | Kw_drop -> M.return @@ as_keyword "drop" options.Options.keyword
        | Kw_begin -> M.return @@ as_keyword "begin" options.Options.keyword
        | Kw_commit -> M.return @@ as_keyword "commit" options.Options.keyword
        | Kw_trigger -> M.return @@ as_keyword "trigger" options.Options.keyword
        | Kw_references ->
          M.return @@ as_keyword "references" options.Options.keyword
        | Kw_constraint ->
          M.return @@ as_keyword "constraint" options.Options.keyword
        | Kw_primary -> M.return @@ as_keyword "primary" options.Options.keyword
        | Kw_unique -> M.return @@ as_keyword "unique" options.Options.keyword
        | Kw_generated ->
          M.return @@ as_keyword "generated" options.Options.keyword
        | Kw_always -> M.return @@ as_keyword "always" options.Options.keyword
        | Kw_check -> M.return @@ as_keyword "check" options.Options.keyword
        | Kw_cascade -> M.return @@ as_keyword "cascade" options.Options.keyword
        | Kw_restrict ->
          M.return @@ as_keyword "restrict" options.Options.keyword
        | Kw_action -> M.return @@ as_keyword "action" options.Options.keyword
        | Kw_deferrable ->
          M.return @@ as_keyword "deferrable" options.Options.keyword
        | Kw_initially ->
          M.return @@ as_keyword "initially" options.Options.keyword
        | Kw_deferred ->
          M.return @@ as_keyword "deferred" options.Options.keyword
        | Kw_immediate ->
          M.return @@ as_keyword "immediate" options.Options.keyword
        | Kw_create -> M.return @@ as_keyword "create" options.Options.keyword
        | Kw_temp -> M.return @@ as_keyword "temp" options.Options.keyword
        | Kw_temporary ->
          M.return @@ as_keyword "temporary" options.Options.keyword
        | Kw_foreign -> M.return @@ as_keyword "foreign" options.Options.keyword
        | Kw_alter -> M.return @@ as_keyword "alter" options.Options.keyword
        | Kw_add -> M.return @@ as_keyword "add" options.Options.keyword
        | Kw_column -> M.return @@ as_keyword "column" options.Options.keyword
        | Kw_before -> M.return @@ as_keyword "before" options.Options.keyword
        | Kw_each -> M.return @@ as_keyword "each" options.Options.keyword
        | Kw_of -> M.return @@ as_keyword "of" options.Options.keyword
        (* 'token *)
        | Tok_lparen -> M.return @@ "("
        | Tok_rparen -> M.return @@ ")"
        | Tok_ident v -> M.return @@ v
        | Tok_string v -> M.return @@ v
        | Tok_numeric v -> M.return @@ v
        | Tok_blob v -> M.return @@ v
        | Tok_period -> M.return @@ "."
        | Tok_comma -> M.return @@ ","
        | Tok_colon -> M.return @@ ":"
        | Tok_dollar -> M.return @@ "$"
        | Tok_lbrace -> M.return @@ "{"
        | Tok_rbrace -> M.return @@ "}"
        | Tok_lsbrace -> M.return @@ "["
        | Tok_rsbrace -> M.return @@ "]"
        | Tok_qmark -> M.return @@ "?"
        | Tok_semicolon -> M.return @@ ";"
        | Tok_quote -> M.return @@ "'"
        | Op_plus -> M.return @@ "+"
        | Op_minus -> M.return @@ "-"
        | Op_star -> M.return @@ "*"
        | Op_slash -> M.return @@ "/"
        | Op_concat -> M.return @@ "||"
        | Op_amp -> M.return @@ "&"
        | Op_pipe -> M.return @@ "|"
        | Op_eq -> M.return @@ "="
        | Op_eq2 -> M.return @@ "=="
        | Op_ge -> M.return @@ ">="
        | Op_gt -> M.return @@ ">"
        | Op_le -> M.return @@ "<="
        | Op_lt -> M.return @@ "<"
        | Op_ne -> M.return @@ "<>"
        | Op_ne2 -> M.return @@ "!="
        | Op_extract -> M.return @@ "->"
        | Op_extract_2 -> M.return @@ "->>"
        | Op_tilda -> M.return @@ "~"
        | Op_lshift -> M.return @@ "<<"
        | Op_rshift -> M.return @@ ">>"
        | _ -> M.fail "Can not stringify EOF"
      in
      let open M.Syntax in
      M.bump () *> M.pp (fun fmt -> Fmt.string fmt kw)
  end :
    PRINTER_M)
