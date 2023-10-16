open Types.Token

let kw_select =
  [%sedlex.regexp?
    Chars "sS", Chars "eE", Chars "lL", Chars "eE", Chars "cC", Chars "tT"]

let kw_from = [%sedlex.regexp? Chars "fF", Chars "rR", Chars "oO", Chars "mM"]

let kw_as = [%sedlex.regexp? Chars "aA", Chars "sS"]

let kw_true = [%sedlex.regexp? Chars "tT", Chars "rR", Chars "uU", Chars "eE"]

let kw_false =
  [%sedlex.regexp? Chars "fF", Chars "aA", Chars "lL", Chars "sS", Chars "eE"]

let kw_unknown =
  [%sedlex.regexp?
    ( Chars "uU"
    , Chars "nN"
    , Chars "kK"
    , Chars "nN"
    , Chars "oO"
    , Chars "wW"
    , Chars "nN" )]

let kw_null = [%sedlex.regexp? Chars "nN", Chars "uU", Chars "lL", Chars "lL"]

let kw_date = [%sedlex.regexp? Chars "dD", Chars "aA", Chars "tT", Chars "eE"]

let kw_time = [%sedlex.regexp? Chars "tT", Chars "iI", Chars "mM", Chars "eE"]

let kw_timestamp =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "iI"
    , Chars "mM"
    , Chars "eE"
    , Chars "sS"
    , Chars "tT"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP" )]

let kw_into = [%sedlex.regexp? Chars "iI", Chars "nN", Chars "tT", Chars "oO"]

let kw_or = [%sedlex.regexp? Chars "oO", Chars "rR"]

let kw_and = [%sedlex.regexp? Chars "aA", Chars "nN", Chars "dD"]

let kw_not = [%sedlex.regexp? Chars "nN", Chars "oO", Chars "tT"]

let kw_union =
  [%sedlex.regexp? Chars "uU", Chars "nN", Chars "iI", Chars "oO", Chars "nN"]

let kw_except =
  [%sedlex.regexp?
    Chars "eE", Chars "xX", Chars "cC", Chars "eE", Chars "pP", Chars "tT"]

let kw_intersect =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "nN"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR"
    , Chars "sS"
    , Chars "eE"
    , Chars "cC"
    , Chars "tT" )]

let kw_into = [%sedlex.regexp? Chars "iI", Chars "nN", Chars "tT", Chars "oO"]

let kw_or = [%sedlex.regexp? Chars "oO", Chars "rR"]

let kw_group =
  [%sedlex.regexp? Chars "gG", Chars "rR", Chars "oO", Chars "uU", Chars "pP"]

let kw_rollup =
  [%sedlex.regexp?
    Chars "rR", Chars "oO", Chars "lL", Chars "lL", Chars "uU", Chars "pP"]

let kw_having =
  [%sedlex.regexp?
    Chars "hH", Chars "aA", Chars "vV", Chars "iI", Chars "nN", Chars "gG"]

let kw_where =
  [%sedlex.regexp? Chars "wW", Chars "hH", Chars "eE", Chars "rR", Chars "eE"]

let kw_by = [%sedlex.regexp? Chars "bB", Chars "yY"]

let kw_order =
  [%sedlex.regexp? Chars "oO", Chars "rR", Chars "dD", Chars "eE", Chars "rR"]

let kw_asc = [%sedlex.regexp? Chars "aA", Chars "sS", Chars "cC"]

let kw_desc = [%sedlex.regexp? Chars "dD", Chars "eE", Chars "sS", Chars "cC"]

let kw_first =
  [%sedlex.regexp? Chars "fF", Chars "iI", Chars "rR", Chars "sS", Chars "tT"]

let kw_last = [%sedlex.regexp? Chars "lL", Chars "aA", Chars "sS", Chars "tT"]

let kw_limit =
  [%sedlex.regexp? Chars "lL", Chars "iI", Chars "mM", Chars "iI", Chars "tT"]

let kw_offset =
  [%sedlex.regexp?
    Chars "oO", Chars "fF", Chars "fF", Chars "sS", Chars "eE", Chars "tT"]

let kw_row = [%sedlex.regexp? Chars "rR", Chars "oO", Chars "wW"]

let kw_rows = [%sedlex.regexp? Chars "rR", Chars "oO", Chars "wW", Chars "sS"]

let kw_fetch =
  [%sedlex.regexp? Chars "fF", Chars "eE", Chars "tT", Chars "cC", Chars "hH"]

let kw_next = [%sedlex.regexp? Chars "nN", Chars "eE", Chars "xX", Chars "tT"]

let kw_only = [%sedlex.regexp? Chars "oO", Chars "nN", Chars "lL", Chars "yY"]

let kw_all = [%sedlex.regexp? Chars "aA", Chars "lL", Chars "lL"]

let kw_distinct =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "iI"
    , Chars "sS"
    , Chars "tT"
    , Chars "iI"
    , Chars "nN"
    , Chars "cC"
    , Chars "tT" )]

let kw_is = [%sedlex.regexp? Chars "iI", Chars "sS"]

let kw_between =
  [%sedlex.regexp?
    ( Chars "bB"
    , Chars "eE"
    , Chars "tT"
    , Chars "wW"
    , Chars "eE"
    , Chars "eE"
    , Chars "nN" )]

let kw_like_regex =
  [%sedlex.regexp?
    ( Chars "lL"
    , Chars "iI"
    , Chars "kK"
    , Chars "eE"
    , '_'
    , Chars "rR"
    , Chars "eE"
    , Chars "gG"
    , Chars "eE"
    , Chars "xX" )]

let kw_similar =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "iI"
    , Chars "mM"
    , Chars "iI"
    , Chars "lL"
    , Chars "aA"
    , Chars "rR" )]

let kw_to = [%sedlex.regexp? Chars "tT", Chars "oO"]

let kw_escape =
  [%sedlex.regexp?
    Chars "eE", Chars "sS", Chars "cC", Chars "aA", Chars "pP", Chars "eE"]

let kw_like = [%sedlex.regexp? Chars "lL", Chars "iI", Chars "kK", Chars "eE"]

let kw_any = [%sedlex.regexp? Chars "aA", Chars "nN", Chars "yY"]

let kw_some = [%sedlex.regexp? Chars "sS", Chars "oO", Chars "mM", Chars "eE"]

let kw_in = [%sedlex.regexp? Chars "iI", Chars "nN"]

let kw_exists =
  [%sedlex.regexp?
    Chars "eE", Chars "xX", Chars "iI", Chars "sS", Chars "tT", Chars "sS"]

let kw_with = [%sedlex.regexp? Chars "wW", Chars "iI", Chars "tT", Chars "hH"]

let kw_table =
  [%sedlex.regexp? Chars "tT", Chars "aA", Chars "bB", Chars "lL", Chars "eE"]

let kw_lateral =
  [%sedlex.regexp?
    ( Chars "lL"
    , Chars "aA"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR"
    , Chars "aA"
    , Chars "lL" )]

let kw_left = [%sedlex.regexp? Chars "lL", Chars "eE", Chars "fF", Chars "tT"]

let kw_right =
  [%sedlex.regexp? Chars "rR", Chars "iI", Chars "gG", Chars "hH", Chars "tT"]

let kw_full = [%sedlex.regexp? Chars "fF", Chars "uU", Chars "lL", Chars "lL"]

let kw_outer =
  [%sedlex.regexp? Chars "oO", Chars "uU", Chars "tT", Chars "eE", Chars "rR"]

let kw_inner =
  [%sedlex.regexp? Chars "iI", Chars "nN", Chars "nN", Chars "eE", Chars "rR"]

let kw_cross =
  [%sedlex.regexp? Chars "cC", Chars "rR", Chars "oO", Chars "sS", Chars "sS"]

let kw_join = [%sedlex.regexp? Chars "jJ", Chars "oO", Chars "iI", Chars "nN"]

let kw_on = [%sedlex.regexp? Chars "oO", Chars "nN"]

let kw_case = [%sedlex.regexp? Chars "cC", Chars "aA", Chars "sS", Chars "eE"]

let kw_when = [%sedlex.regexp? Chars "wW", Chars "hH", Chars "eE", Chars "nN"]

let kw_then = [%sedlex.regexp? Chars "tT", Chars "hH", Chars "eE", Chars "nN"]

let kw_end = [%sedlex.regexp? Chars "eE", Chars "nN", Chars "dD"]

let kw_else = [%sedlex.regexp? Chars "eE", Chars "lL", Chars "sS", Chars "eE"]

let kw_textagg =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "eE"
    , Chars "xX"
    , Chars "tT"
    , Chars "aA"
    , Chars "gG"
    , Chars "gG" )]

let kw_for = [%sedlex.regexp? Chars "fF", Chars "oO", Chars "rR"]

let kw_delimiter =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "eE"
    , Chars "lL"
    , Chars "iI"
    , Chars "mM"
    , Chars "iI"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR" )]

let kw_quote =
  [%sedlex.regexp? Chars "qQ", Chars "uU", Chars "oO", Chars "tT", Chars "eE"]

let kw_no = [%sedlex.regexp? Chars "nN", Chars "oO"]

let kw_header =
  [%sedlex.regexp?
    Chars "hH", Chars "eE", Chars "aA", Chars "dD", Chars "eE", Chars "rR"]

let kw_encoding =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "nN"
    , Chars "cC"
    , Chars "oO"
    , Chars "dD"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_count =
  [%sedlex.regexp? Chars "cC", Chars "oO", Chars "uU", Chars "nN", Chars "tT"]

let kw_count_big =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "uU"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "bB"
    , Chars "iI"
    , Chars "gG" )]

let kw_sum = [%sedlex.regexp? Chars "sS", Chars "uU", Chars "mM"]

let kw_avg = [%sedlex.regexp? Chars "aA", Chars "vV", Chars "gG"]

let kw_min = [%sedlex.regexp? Chars "mM", Chars "iI", Chars "nN"]

let kw_max = [%sedlex.regexp? Chars "mM", Chars "aA", Chars "xX"]

let kw_every =
  [%sedlex.regexp? Chars "eE", Chars "vV", Chars "eE", Chars "rR", Chars "yY"]

let kw_stddev_pop =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "tT"
    , Chars "dD"
    , Chars "dD"
    , Chars "eE"
    , Chars "vV"
    , '_'
    , Chars "pP"
    , Chars "oO"
    , Chars "pP" )]

let kw_stddev_samp =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "tT"
    , Chars "dD"
    , Chars "dD"
    , Chars "eE"
    , Chars "vV"
    , '_'
    , Chars "sS"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP" )]

let kw_var_samp =
  [%sedlex.regexp?
    ( Chars "vV"
    , Chars "aA"
    , Chars "rR"
    , '_'
    , Chars "sS"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP" )]

let kw_var_pop =
  [%sedlex.regexp?
    Chars "vV", Chars "aA", Chars "rR", '_', Chars "pP", Chars "oO", Chars "pP"]

let kw_filter =
  [%sedlex.regexp?
    Chars "fF", Chars "iI", Chars "lL", Chars "tT", Chars "eE", Chars "rR"]

let kw_over = [%sedlex.regexp? Chars "oO", Chars "vV", Chars "eE", Chars "rR"]

let kw_partition =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "aA"
    , Chars "rR"
    , Chars "tT"
    , Chars "iI"
    , Chars "tT"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN" )]

let kw_range =
  [%sedlex.regexp? Chars "rR", Chars "aA", Chars "nN", Chars "gG", Chars "eE"]

let kw_unbounded =
  [%sedlex.regexp?
    ( Chars "uU"
    , Chars "nN"
    , Chars "bB"
    , Chars "oO"
    , Chars "uU"
    , Chars "nN"
    , Chars "dD"
    , Chars "eE"
    , Chars "dD" )]

let kw_following =
  [%sedlex.regexp?
    ( Chars "fF"
    , Chars "oO"
    , Chars "lL"
    , Chars "lL"
    , Chars "oO"
    , Chars "wW"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_preceding =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "rR"
    , Chars "eE"
    , Chars "cC"
    , Chars "eE"
    , Chars "dD"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_current =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT" )]

let kw_row_number =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "oO"
    , Chars "wW"
    , '_'
    , Chars "nN"
    , Chars "uU"
    , Chars "mM"
    , Chars "bB"
    , Chars "eE"
    , Chars "rR" )]

let kw_rank = [%sedlex.regexp? Chars "rR", Chars "aA", Chars "nN", Chars "kK"]

let kw_dense_rank =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "eE"
    , Chars "nN"
    , Chars "sS"
    , Chars "eE"
    , Chars "__"
    , Chars "rR"
    , Chars "aA"
    , Chars "nN"
    , Chars "kK" )]

let kw_percent_rank =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "eE"
    , Chars "rR"
    , Chars "cC"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "rR"
    , Chars "aA"
    , Chars "nN"
    , Chars "kK" )]

let kw_cume_dist =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "mM"
    , Chars "eE"
    , '_'
    , Chars "dD"
    , Chars "iI"
    , Chars "sS"
    , Chars "tT" )]

let kw_varchar =
  [%sedlex.regexp?
    ( Chars "vV"
    , Chars "aA"
    , Chars "rR"
    , Chars "cC"
    , Chars "hH"
    , Chars "aA"
    , Chars "rR" )]

let kw_boolean =
  [%sedlex.regexp?
    ( Chars "bB"
    , Chars "oO"
    , Chars "oO"
    , Chars "lL"
    , Chars "eE"
    , Chars "aA"
    , Chars "nN" )]

let kw_byte = [%sedlex.regexp? Chars "bB", Chars "yY", Chars "tT", Chars "eE"]

let kw_tinyint =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "iI"
    , Chars "nN"
    , Chars "yY"
    , Chars "iI"
    , Chars "nN"
    , Chars "tT" )]

let kw_short =
  [%sedlex.regexp? Chars "sS", Chars "hH", Chars "oO", Chars "rR", Chars "tT"]

let kw_smallint =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "mM"
    , Chars "aA"
    , Chars "lL"
    , Chars "lL"
    , Chars "iI"
    , Chars "nN"
    , Chars "tT" )]

let kw_char = [%sedlex.regexp? Chars "cC", Chars "hH", Chars "aA", Chars "rR"]

let kw_integer =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "nN"
    , Chars "tT"
    , Chars "eE"
    , Chars "gG"
    , Chars "eE"
    , Chars "rR" )]

let kw_long = [%sedlex.regexp? Chars "lL", Chars "oO", Chars "nN", Chars "gG"]

let kw_bigint =
  [%sedlex.regexp?
    Chars "bB", Chars "iI", Chars "gG", Chars "iI", Chars "nN", Chars "tT"]

let kw_biginteger =
  [%sedlex.regexp?
    ( Chars "bB"
    , Chars "iI"
    , Chars "gG"
    , Chars "iI"
    , Chars "nN"
    , Chars "tT"
    , Chars "eE"
    , Chars "gG"
    , Chars "eE"
    , Chars "rR" )]

let kw_float =
  [%sedlex.regexp? Chars "fF", Chars "lL", Chars "oO", Chars "aA", Chars "tT"]

let kw_real = [%sedlex.regexp? Chars "rR", Chars "eE", Chars "aA", Chars "lL"]

let kw_double =
  [%sedlex.regexp?
    Chars "dD", Chars "oO", Chars "uU", Chars "bB", Chars "lL", Chars "eE"]

let kw_bigdecimal =
  [%sedlex.regexp?
    ( Chars "bB"
    , Chars "iI"
    , Chars "gG"
    , Chars "dD"
    , Chars "eE"
    , Chars "cC"
    , Chars "iI"
    , Chars "mM"
    , Chars "aA"
    , Chars "lL" )]

let kw_decimal =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "eE"
    , Chars "cC"
    , Chars "iI"
    , Chars "mM"
    , Chars "aA"
    , Chars "lL" )]

let kw_object =
  [%sedlex.regexp?
    Chars "oO", Chars "bB", Chars "jJ", Chars "eE", Chars "cC", Chars "tT"]

let kw_blob = [%sedlex.regexp? Chars "bB", Chars "lL", Chars "oO", Chars "bB"]

let kw_clob = [%sedlex.regexp? Chars "cC", Chars "lL", Chars "oO", Chars "bB"]

let kw_json = [%sedlex.regexp? Chars "jJ", Chars "sS", Chars "oO", Chars "nN"]

let kw_varbinary =
  [%sedlex.regexp?
    ( Chars "vV"
    , Chars "aA"
    , Chars "rR"
    , Chars "bB"
    , Chars "iI"
    , Chars "nN"
    , Chars "aA"
    , Chars "rR"
    , Chars "yY" )]

let kw_geometry =
  [%sedlex.regexp?
    ( Chars "gG"
    , Chars "eE"
    , Chars "oO"
    , Chars "mM"
    , Chars "eE"
    , Chars "tT"
    , Chars "rR"
    , Chars "yY" )]

let kw_geography =
  [%sedlex.regexp?
    ( Chars "gG"
    , Chars "eE"
    , Chars "oO"
    , Chars "gG"
    , Chars "rR"
    , Chars "aA"
    , Chars "pP"
    , Chars "hH"
    , Chars "yY" )]

let kw_xml = [%sedlex.regexp? Chars "xX", Chars "mM", Chars "lL"]

let kw_convert =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "nN"
    , Chars "vV"
    , Chars "eE"
    , Chars "rR"
    , Chars "tT" )]

let kw_cast = [%sedlex.regexp? Chars "cC", Chars "aA", Chars "sS", Chars "tT"]

let kw_substring =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "uU"
    , Chars "bB"
    , Chars "sS"
    , Chars "tT"
    , Chars "rR"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_extract =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "xX"
    , Chars "tT"
    , Chars "rR"
    , Chars "aA"
    , Chars "cC"
    , Chars "tT" )]

let kw_year = [%sedlex.regexp? Chars "yY", Chars "eE", Chars "aA", Chars "rR"]

let kw_month =
  [%sedlex.regexp? Chars "mM", Chars "oO", Chars "nN", Chars "tT", Chars "hH"]

let kw_day = [%sedlex.regexp? Chars "dD", Chars "aA", Chars "yY"]

let kw_hour = [%sedlex.regexp? Chars "hH", Chars "oO", Chars "uU", Chars "rR"]

let kw_minute =
  [%sedlex.regexp?
    Chars "mM", Chars "iI", Chars "nN", Chars "uU", Chars "tT", Chars "eE"]

let kw_second =
  [%sedlex.regexp?
    Chars "sS", Chars "eE", Chars "cC", Chars "oO", Chars "nN", Chars "dD"]

let kw_quarter =
  [%sedlex.regexp?
    ( Chars "qQ"
    , Chars "uU"
    , Chars "aA"
    , Chars "rR"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR" )]

let kw_epoch =
  [%sedlex.regexp? Chars "eE", Chars "pP", Chars "oO", Chars "cC", Chars "hH"]

let kw_trim = [%sedlex.regexp? Chars "tT", Chars "rR", Chars "iI", Chars "mM"]

let kw_leading =
  [%sedlex.regexp?
    ( Chars "lL"
    , Chars "eE"
    , Chars "aA"
    , Chars "dD"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_trailing =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "rR"
    , Chars "aA"
    , Chars "iI"
    , Chars "lL"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_both = [%sedlex.regexp? Chars "bB", Chars "oO", Chars "tT", Chars "hH"]

let kw_to_chars =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "oO"
    , '_'
    , Chars "cC"
    , Chars "hH"
    , Chars "aA"
    , Chars "rR"
    , Chars "sS" )]

let kw_to_bytes =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "oO"
    , '_'
    , Chars "bB"
    , Chars "yY"
    , Chars "tT"
    , Chars "eE"
    , Chars "sS" )]

let kw_insert =
  [%sedlex.regexp?
    Chars "iI", Chars "nN", Chars "sS", Chars "eE", Chars "rR", Chars "tT"]

let kw_translate =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "rR"
    , Chars "aA"
    , Chars "nN"
    , Chars "sS"
    , Chars "lL"
    , Chars "aA"
    , Chars "tT"
    , Chars "eE" )]

let kw_position =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "oO"
    , Chars "sS"
    , Chars "iI"
    , Chars "tT"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN" )]

let kw_listagg =
  [%sedlex.regexp?
    ( Chars "lL"
    , Chars "iI"
    , Chars "sS"
    , Chars "tT"
    , Chars "aA"
    , Chars "gG"
    , Chars "gG" )]

let kw_within =
  [%sedlex.regexp?
    Chars "wW", Chars "iI", Chars "tT", Chars "hH", Chars "iI", Chars "nN"]

let kw_current_date =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "dD"
    , Chars "aA"
    , Chars "tT"
    , Chars "eE" )]

let kw_exception =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "xX"
    , Chars "cC"
    , Chars "eE"
    , Chars "pP"
    , Chars "tT"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN" )]

let kw_serial =
  [%sedlex.regexp?
    Chars "sS", Chars "eE", Chars "rR", Chars "iI", Chars "aA", Chars "lL"]

let kw_index =
  [%sedlex.regexp? Chars "iI", Chars "nN", Chars "dD", Chars "eE", Chars "xX"]

let kw_instead =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "nN"
    , Chars "sS"
    , Chars "tT"
    , Chars "eE"
    , Chars "aA"
    , Chars "dD" )]

let kw_view = [%sedlex.regexp? Chars "vV", Chars "iI", Chars "eE", Chars "wW"]

let kw_enabled =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "nN"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE"
    , Chars "dD" )]

let kw_disabled =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "iI"
    , Chars "sS"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE"
    , Chars "dD" )]

let kw_key = [%sedlex.regexp? Chars "kK", Chars "eE", Chars "yY"]

let kw_document =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "oO"
    , Chars "cC"
    , Chars "uU"
    , Chars "mM"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT" )]

let kw_content =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "nN"
    , Chars "tT"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT" )]

let kw_empty =
  [%sedlex.regexp? Chars "eE", Chars "mM", Chars "pP", Chars "tT", Chars "yY"]

let kw_ordinality =
  [%sedlex.regexp?
    ( Chars "oO"
    , Chars "rR"
    , Chars "dD"
    , Chars "iI"
    , Chars "nN"
    , Chars "aA"
    , Chars "lL"
    , Chars "iI"
    , Chars "tT"
    , Chars "yY" )]

let kw_path = [%sedlex.regexp? Chars "pP", Chars "aA", Chars "tT", Chars "hH"]

let kw_querystring =
  [%sedlex.regexp?
    ( Chars "qQ"
    , Chars "uU"
    , Chars "eE"
    , Chars "rR"
    , Chars "yY"
    , Chars "sS"
    , Chars "tT"
    , Chars "rR"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_namespace =
  [%sedlex.regexp?
    ( Chars "nN"
    , Chars "aA"
    , Chars "mM"
    , Chars "eE"
    , Chars "sS"
    , Chars "pP"
    , Chars "aA"
    , Chars "cC"
    , Chars "eE" )]

let kw_result =
  [%sedlex.regexp?
    Chars "rR", Chars "eE", Chars "sS", Chars "uU", Chars "lL", Chars "tT"]

let kw_accesspattern =
  [%sedlex.regexp?
    ( Chars "aA"
    , Chars "cC"
    , Chars "cC"
    , Chars "eE"
    , Chars "sS"
    , Chars "sS"
    , Chars "pP"
    , Chars "aA"
    , Chars "tT"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR"
    , Chars "nN" )]

let kw_auto_increment =
  [%sedlex.regexp?
    ( Chars "aA"
    , Chars "uU"
    , Chars "tT"
    , Chars "oO"
    , '_'
    , Chars "iI"
    , Chars "nN"
    , Chars "cC"
    , Chars "rR"
    , Chars "eE"
    , Chars "mM"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT" )]

let kw_wellformed =
  [%sedlex.regexp?
    ( Chars "wW"
    , Chars "eE"
    , Chars "lL"
    , Chars "lL"
    , Chars "fF"
    , Chars "oO"
    , Chars "rR"
    , Chars "mM"
    , Chars "eE"
    , Chars "dD" )]

let kw_texttable =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "eE"
    , Chars "xX"
    , Chars "tT"
    , Chars "tT"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE" )]

let kw_arraytable =
  [%sedlex.regexp?
    ( Chars "aA"
    , Chars "rR"
    , Chars "rR"
    , Chars "aA"
    , Chars "yY"
    , Chars "tT"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE" )]

let kw_jsontable =
  [%sedlex.regexp?
    ( Chars "jJ"
    , Chars "sS"
    , Chars "oO"
    , Chars "nN"
    , Chars "tT"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE" )]

let kw_selector =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "eE"
    , Chars "lL"
    , Chars "eE"
    , Chars "cC"
    , Chars "tT"
    , Chars "oO"
    , Chars "rR" )]

let kw_skip = [%sedlex.regexp? Chars "sS", Chars "kK", Chars "iI", Chars "pP"]

let kw_width =
  [%sedlex.regexp? Chars "wW", Chars "iI", Chars "dD", Chars "tT", Chars "hH"]

let kw_passing =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "aA"
    , Chars "sS"
    , Chars "sS"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_name = [%sedlex.regexp? Chars "nN", Chars "aA", Chars "mM", Chars "eE"]

let kw_columns =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "lL"
    , Chars "uU"
    , Chars "mM"
    , Chars "nN"
    , Chars "sS" )]

let kw_nulls =
  [%sedlex.regexp? Chars "nN", Chars "uU", Chars "lL", Chars "lL", Chars "sS"]

let kw_objecttable =
  [%sedlex.regexp?
    ( Chars "oO"
    , Chars "bB"
    , Chars "jJ"
    , Chars "eE"
    , Chars "cC"
    , Chars "tT"
    , Chars "tT"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE" )]

let kw_version =
  [%sedlex.regexp?
    ( Chars "vV"
    , Chars "eE"
    , Chars "rR"
    , Chars "sS"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN" )]

let kw_including =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "nN"
    , Chars "cC"
    , Chars "lL"
    , Chars "uU"
    , Chars "dD"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_excluding =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "xX"
    , Chars "cC"
    , Chars "lL"
    , Chars "uU"
    , Chars "dD"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_variadic =
  [%sedlex.regexp?
    ( Chars "vV"
    , Chars "aA"
    , Chars "rR"
    , Chars "iI"
    , Chars "aA"
    , Chars "dD"
    , Chars "iI"
    , Chars "cC" )]

let kw_raise =
  [%sedlex.regexp? Chars "rR", Chars "aA", Chars "iI", Chars "sS", Chars "eE"]

let kw_chain =
  [%sedlex.regexp? Chars "cC", Chars "hH", Chars "aA", Chars "iI", Chars "nN"]

let kw_jsonarray_agg =
  [%sedlex.regexp?
    ( Chars "jJ"
    , Chars "sS"
    , Chars "oO"
    , Chars "nN"
    , Chars "aA"
    , Chars "rR"
    , Chars "rR"
    , Chars "aA"
    , Chars "yY"
    , '_'
    , Chars "aA"
    , Chars "gG"
    , Chars "gG" )]

let kw_jsonobject =
  [%sedlex.regexp?
    ( Chars "jJ"
    , Chars "sS"
    , Chars "oO"
    , Chars "nN"
    , Chars "oO"
    , Chars "bB"
    , Chars "jJ"
    , Chars "eE"
    , Chars "cC"
    , Chars "tT" )]

let kw_preserve =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "rR"
    , Chars "eE"
    , Chars "sS"
    , Chars "eE"
    , Chars "rR"
    , Chars "vV"
    , Chars "eE" )]

let kw_upsert =
  [%sedlex.regexp?
    Chars "uU", Chars "pP", Chars "sS", Chars "eE", Chars "rR", Chars "tT"]

let kw_after =
  [%sedlex.regexp? Chars "aA", Chars "fF", Chars "tT", Chars "eE", Chars "rR"]

let kw_type = [%sedlex.regexp? Chars "tT", Chars "yY", Chars "pP", Chars "eE"]

let kw_translator =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "rR"
    , Chars "aA"
    , Chars "nN"
    , Chars "sS"
    , Chars "lL"
    , Chars "aA"
    , Chars "tT"
    , Chars "oO"
    , Chars "rR" )]

let kw_jaas = [%sedlex.regexp? Chars "jJ", Chars "aA", Chars "aA", Chars "sS"]

let kw_condition =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "nN"
    , Chars "dD"
    , Chars "iI"
    , Chars "tT"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN" )]

let kw_mask = [%sedlex.regexp? Chars "mM", Chars "aA", Chars "sS", Chars "kK"]

let kw_access =
  [%sedlex.regexp?
    Chars "aA", Chars "cC", Chars "cC", Chars "eE", Chars "sS", Chars "sS"]

let kw_control =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "nN"
    , Chars "tT"
    , Chars "rR"
    , Chars "oO"
    , Chars "lL" )]

let kw_none = [%sedlex.regexp? Chars "nN", Chars "oO", Chars "nN", Chars "eE"]

let kw_data = [%sedlex.regexp? Chars "dD", Chars "aA", Chars "tT", Chars "aA"]

let kw_database =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "aA"
    , Chars "tT"
    , Chars "aA"
    , Chars "bB"
    , Chars "aA"
    , Chars "sS"
    , Chars "eE" )]

let kw_privileges =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "rR"
    , Chars "iI"
    , Chars "vV"
    , Chars "iI"
    , Chars "lL"
    , Chars "eE"
    , Chars "gG"
    , Chars "eE"
    , Chars "sS" )]

let kw_role = [%sedlex.regexp? Chars "rR", Chars "oO", Chars "lL", Chars "eE"]

let kw_schema =
  [%sedlex.regexp?
    Chars "sS", Chars "cC", Chars "hH", Chars "eE", Chars "mM", Chars "aA"]

let kw_use = [%sedlex.regexp? Chars "uU", Chars "sS", Chars "eE"]

let kw_repository =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "eE"
    , Chars "pP"
    , Chars "oO"
    , Chars "sS"
    , Chars "iI"
    , Chars "tT"
    , Chars "oO"
    , Chars "rR"
    , Chars "yY" )]

let kw_rename =
  [%sedlex.regexp?
    Chars "rR", Chars "eE", Chars "nN", Chars "aA", Chars "mM", Chars "eE"]

let kw_domain =
  [%sedlex.regexp?
    Chars "dD", Chars "oO", Chars "mM", Chars "aA", Chars "iI", Chars "nN"]

let kw_usage =
  [%sedlex.regexp? Chars "uU", Chars "sS", Chars "aA", Chars "gG", Chars "eE"]

let kw_explain =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "xX"
    , Chars "pP"
    , Chars "lL"
    , Chars "aA"
    , Chars "iI"
    , Chars "nN" )]

let kw_analyze =
  [%sedlex.regexp?
    ( Chars "aA"
    , Chars "nN"
    , Chars "aA"
    , Chars "lL"
    , Chars "yY"
    , Chars "zZ"
    , Chars "eE" )]

let kw_text = [%sedlex.regexp? Chars "tT", Chars "eE", Chars "xX", Chars "tT"]

let kw_format =
  [%sedlex.regexp?
    Chars "fF", Chars "oO", Chars "rR", Chars "mM", Chars "aA", Chars "tT"]

let kw_yaml = [%sedlex.regexp? Chars "yY", Chars "aA", Chars "mM", Chars "lL"]

let kw_policy =
  [%sedlex.regexp?
    Chars "pP", Chars "oO", Chars "lL", Chars "iI", Chars "cC", Chars "yY"]

let kw_current_timestamp =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "tT"
    , Chars "iI"
    , Chars "mM"
    , Chars "eE"
    , Chars "sS"
    , Chars "tT"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP" )]

let kw_current_time =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "tT"
    , Chars "iI"
    , Chars "mM"
    , Chars "eE" )]

let kw_session_user =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "eE"
    , Chars "sS"
    , Chars "sS"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN"
    , '_'
    , Chars "uU"
    , Chars "sS"
    , Chars "eE"
    , Chars "rR" )]

let kw_interval =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "nN"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR"
    , Chars "vV"
    , Chars "aA"
    , Chars "lL" )]

let kw_tablesample =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE"
    , Chars "sS"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP"
    , Chars "lL"
    , Chars "eE" )]

let kw_bernoulli =
  [%sedlex.regexp?
    ( Chars "bB"
    , Chars "eE"
    , Chars "rR"
    , Chars "nN"
    , Chars "oO"
    , Chars "uU"
    , Chars "lL"
    , Chars "lL"
    , Chars "iI" )]

let kw_repeatable =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "eE"
    , Chars "pP"
    , Chars "eE"
    , Chars "aA"
    , Chars "tT"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE" )]

let kw_system =
  [%sedlex.regexp?
    Chars "sS", Chars "yY", Chars "sS", Chars "tT", Chars "eE", Chars "mM"]

let kw_unnest =
  [%sedlex.regexp?
    Chars "uU", Chars "nN", Chars "nN", Chars "eE", Chars "sS", Chars "tT"]

let kw_module =
  [%sedlex.regexp?
    Chars "mM", Chars "oO", Chars "dD", Chars "uU", Chars "lL", Chars "eE"]

let kw_collate =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "lL"
    , Chars "lL"
    , Chars "aA"
    , Chars "tT"
    , Chars "eE" )]

let kw_cube = [%sedlex.regexp? Chars "cC", Chars "uU", Chars "bB", Chars "eE"]

let kw_grouping =
  [%sedlex.regexp?
    ( Chars "gG"
    , Chars "rR"
    , Chars "oO"
    , Chars "uU"
    , Chars "pP"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_sets = [%sedlex.regexp? Chars "sS", Chars "eE", Chars "tT", Chars "sS"]

let kw_ties = [%sedlex.regexp? Chars "tT", Chars "iI", Chars "eE", Chars "sS"]

let kw_others =
  [%sedlex.regexp?
    Chars "oO", Chars "tT", Chars "hH", Chars "eE", Chars "rR", Chars "sS"]

let kw_exclude =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "xX"
    , Chars "cC"
    , Chars "lL"
    , Chars "uU"
    , Chars "dD"
    , Chars "eE" )]

let kw_window =
  [%sedlex.regexp?
    Chars "wW", Chars "iI", Chars "nN", Chars "dD", Chars "oO", Chars "wW"]

let kw_using =
  [%sedlex.regexp? Chars "uU", Chars "sS", Chars "iI", Chars "nN", Chars "gG"]

let kw_natural =
  [%sedlex.regexp?
    ( Chars "nN"
    , Chars "aA"
    , Chars "tT"
    , Chars "uU"
    , Chars "rR"
    , Chars "aA"
    , Chars "lL" )]

let kw_corresponding =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "sS"
    , Chars "pP"
    , Chars "oO"
    , Chars "nN"
    , Chars "dD"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_recursive =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "eE"
    , Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "sS"
    , Chars "iI"
    , Chars "vV"
    , Chars "eE" )]

let kw_cycle =
  [%sedlex.regexp? Chars "cC", Chars "yY", Chars "cC", Chars "lL", Chars "eE"]

let kw_default =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "eE"
    , Chars "fF"
    , Chars "aA"
    , Chars "uU"
    , Chars "lL"
    , Chars "tT" )]

let kw_set = [%sedlex.regexp? Chars "sS", Chars "eE", Chars "tT"]

let kw_depth =
  [%sedlex.regexp? Chars "dD", Chars "eE", Chars "pP", Chars "tT", Chars "hH"]

let kw_breadth =
  [%sedlex.regexp?
    ( Chars "bB"
    , Chars "rR"
    , Chars "eE"
    , Chars "aA"
    , Chars "dD"
    , Chars "tT"
    , Chars "hH" )]

let kw_search =
  [%sedlex.regexp?
    Chars "sS", Chars "eE", Chars "aA", Chars "rR", Chars "cC", Chars "hH"]

let kw_values =
  [%sedlex.regexp?
    Chars "vV", Chars "aA", Chars "lL", Chars "uU", Chars "eE", Chars "sS"]

let kw_value =
  [%sedlex.regexp? Chars "vV", Chars "aA", Chars "lL", Chars "uU", Chars "eE"]

let kw_element =
  [%sedlex.regexp?
    ( Chars "eE"
    , Chars "lL"
    , Chars "eE"
    , Chars "mM"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT" )]

let kw_zone = [%sedlex.regexp? Chars "zZ", Chars "oO", Chars "nN", Chars "eE"]

let kw_local =
  [%sedlex.regexp? Chars "lL", Chars "oO", Chars "cC", Chars "aA", Chars "lL"]

let kw_at = [%sedlex.regexp? Chars "aA", Chars "tT"]

let kw_abs = [%sedlex.regexp? Chars "aA", Chars "bB", Chars "sS"]

let kw_array =
  [%sedlex.regexp? Chars "aA", Chars "rR", Chars "rR", Chars "aA", Chars "yY"]

let kw_multiset =
  [%sedlex.regexp?
    ( Chars "mM"
    , Chars "uU"
    , Chars "lL"
    , Chars "tT"
    , Chars "iI"
    , Chars "sS"
    , Chars "eE"
    , Chars "tT" )]

let kw_localtime =
  [%sedlex.regexp?
    ( Chars "lL"
    , Chars "oO"
    , Chars "cC"
    , Chars "aA"
    , Chars "lL"
    , Chars "tT"
    , Chars "iI"
    , Chars "mM"
    , Chars "eE" )]

let kw_localtimestamp =
  [%sedlex.regexp?
    ( Chars "lL"
    , Chars "oO"
    , Chars "cC"
    , Chars "aA"
    , Chars "lL"
    , Chars "tT"
    , Chars "iI"
    , Chars "mM"
    , Chars "eE"
    , Chars "sS"
    , Chars "tT"
    , Chars "aA"
    , Chars "mM"
    , Chars "pP" )]

let kw_characters =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "hH"
    , Chars "aA"
    , Chars "rR"
    , Chars "aA"
    , Chars "cC"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR"
    , Chars "sS" )]

let kw_code_units =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "dD"
    , Chars "eE"
    , '_'
    , Chars "uU"
    , Chars "nN"
    , Chars "iI"
    , Chars "tT"
    , Chars "sS" )]

let kw_octets =
  [%sedlex.regexp?
    Chars "oO", Chars "cC", Chars "tT", Chars "eE", Chars "tT", Chars "sS"]

let kw_without =
  [%sedlex.regexp?
    ( Chars "wW"
    , Chars "iI"
    , Chars "tT"
    , Chars "hH"
    , Chars "oO"
    , Chars "uU"
    , Chars "tT" )]

let kw_scope =
  [%sedlex.regexp? Chars "sS", Chars "cC", Chars "oO", Chars "pP", Chars "eE"]

let kw_ref = [%sedlex.regexp? Chars "rR", Chars "eE", Chars "fF"]

let kw_precision =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "rR"
    , Chars "eE"
    , Chars "cC"
    , Chars "iI"
    , Chars "sS"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN" )]

let kw_numeric =
  [%sedlex.regexp?
    ( Chars "nN"
    , Chars "uU"
    , Chars "mM"
    , Chars "eE"
    , Chars "rR"
    , Chars "iI"
    , Chars "cC" )]

let kw_int = [%sedlex.regexp? Chars "iI", Chars "nN", Chars "tT"]

let kw_dec = [%sedlex.regexp? Chars "dD", Chars "eE", Chars "cC"]

let kw_binary =
  [%sedlex.regexp?
    Chars "bB", Chars "iI", Chars "nN", Chars "aA", Chars "rR", Chars "yY"]

let kw_large =
  [%sedlex.regexp? Chars "lL", Chars "aA", Chars "rR", Chars "gG", Chars "eE"]

let kw_national =
  [%sedlex.regexp?
    ( Chars "nN"
    , Chars "aA"
    , Chars "tT"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN"
    , Chars "aA"
    , Chars "lL" )]

let kw_varying =
  [%sedlex.regexp?
    ( Chars "vV"
    , Chars "aA"
    , Chars "rR"
    , Chars "yY"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_character =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "hH"
    , Chars "aA"
    , Chars "rR"
    , Chars "aA"
    , Chars "cC"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR" )]

let kw_nchar =
  [%sedlex.regexp? Chars "nN", Chars "cC", Chars "hH", Chars "aA", Chars "rR"]

let kw_nclob =
  [%sedlex.regexp? Chars "nN", Chars "cC", Chars "lL", Chars "oO", Chars "bB"]

let kw_indicator =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "nN"
    , Chars "dD"
    , Chars "iI"
    , Chars "cC"
    , Chars "aA"
    , Chars "tT"
    , Chars "oO"
    , Chars "rR" )]

let kw_current_default_transform_group =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "dD"
    , Chars "eE"
    , Chars "fF"
    , Chars "aA"
    , Chars "uU"
    , Chars "lL"
    , Chars "tT"
    , '_'
    , Chars "tT"
    , Chars "rR"
    , Chars "aA"
    , Chars "nN"
    , Chars "sS"
    , Chars "fF"
    , Chars "oO"
    , Chars "rR"
    , Chars "mM"
    , '_'
    , Chars "gG"
    , Chars "rR"
    , Chars "oO"
    , Chars "uU"
    , Chars "pP" )]

let kw_current_transform_group_for_type =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "tT"
    , Chars "rR"
    , Chars "aA"
    , Chars "nN"
    , Chars "sS"
    , Chars "fF"
    , Chars "oO"
    , Chars "rR"
    , Chars "mM"
    , '_'
    , Chars "gG"
    , Chars "rR"
    , Chars "oO"
    , Chars "uU"
    , Chars "pP"
    , '_'
    , Chars "fF"
    , Chars "oO"
    , Chars "rR"
    , '_'
    , Chars "tT"
    , Chars "yY"
    , Chars "pP"
    , Chars "eE" )]

let kw_current_path =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "pP"
    , Chars "aA"
    , Chars "tT"
    , Chars "hH" )]

let kw_current_role =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "rR"
    , Chars "oO"
    , Chars "lL"
    , Chars "eE" )]

let kw_system_user =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "yY"
    , Chars "sS"
    , Chars "tT"
    , Chars "eE"
    , Chars "mM"
    , '_'
    , Chars "uU"
    , Chars "sS"
    , Chars "eE"
    , Chars "rR" )]

let kw_current_user =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "uU"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "tT"
    , '_'
    , Chars "uU"
    , Chars "sS"
    , Chars "eE"
    , Chars "rR" )]

let kw_nullif =
  [%sedlex.regexp?
    Chars "nN", Chars "uU", Chars "lL", Chars "lL", Chars "iI", Chars "fF"]

let kw_coalesce =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "aA"
    , Chars "lL"
    , Chars "eE"
    , Chars "sS"
    , Chars "cC"
    , Chars "eE" )]

let kw_groups =
  [%sedlex.regexp?
    Chars "gG", Chars "rR", Chars "oO", Chars "uU", Chars "pP", Chars "sS"]

let kw_glob = [%sedlex.regexp? Chars "gG", Chars "lL", Chars "oO", Chars "bB"]

let kw_regexp =
  [%sedlex.regexp?
    Chars "rR", Chars "eE", Chars "gG", Chars "eE", Chars "xX", Chars "pP"]

let kw_match =
  [%sedlex.regexp? Chars "mM", Chars "aA", Chars "tT", Chars "cC", Chars "hH"]

let kw_materialized =
  [%sedlex.regexp?
    ( Chars "mM"
    , Chars "aA"
    , Chars "tT"
    , Chars "eE"
    , Chars "rR"
    , Chars "iI"
    , Chars "aA"
    , Chars "lL"
    , Chars "iI"
    , Chars "zZ"
    , Chars "eE"
    , Chars "dD" )]

let kw_abort =
  [%sedlex.regexp? Chars "aA", Chars "bB", Chars "oO", Chars "rR", Chars "tT"]

let kw_ignore =
  [%sedlex.regexp?
    Chars "iI", Chars "gG", Chars "nN", Chars "oO", Chars "rR", Chars "eE"]

let kw_replace =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "eE"
    , Chars "pP"
    , Chars "lL"
    , Chars "aA"
    , Chars "cC"
    , Chars "eE" )]

let kw_rollback =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "oO"
    , Chars "lL"
    , Chars "lL"
    , Chars "bB"
    , Chars "aA"
    , Chars "cC"
    , Chars "kK" )]

let kw_fail = [%sedlex.regexp? Chars "fF", Chars "aA", Chars "iI", Chars "lL"]

let kw_update =
  [%sedlex.regexp?
    Chars "uU", Chars "pP", Chars "dD", Chars "aA", Chars "tT", Chars "eE"]

let kw_returning =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "eE"
    , Chars "tT"
    , Chars "uU"
    , Chars "rR"
    , Chars "nN"
    , Chars "iI"
    , Chars "nN"
    , Chars "gG" )]

let kw_delete =
  [%sedlex.regexp?
    Chars "dD", Chars "eE", Chars "lL", Chars "eE", Chars "tT", Chars "eE"]

let kw_savepoint =
  [%sedlex.regexp?
    ( Chars "sS"
    , Chars "aA"
    , Chars "vV"
    , Chars "eE"
    , Chars "pP"
    , Chars "oO"
    , Chars "iI"
    , Chars "nN"
    , Chars "tT" )]

let kw_transaction =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "rR"
    , Chars "aA"
    , Chars "nN"
    , Chars "sS"
    , Chars "aA"
    , Chars "cC"
    , Chars "tT"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN" )]

let kw_if = [%sedlex.regexp? Chars "iI", Chars "fF"]

let kw_drop = [%sedlex.regexp? Chars "dD", Chars "rR", Chars "oO", Chars "pP"]

let kw_begin =
  [%sedlex.regexp? Chars "bB", Chars "eE", Chars "gG", Chars "iI", Chars "nN"]

let kw_commit =
  [%sedlex.regexp?
    Chars "cC", Chars "oO", Chars "mM", Chars "mM", Chars "iI", Chars "tT"]

let kw_trigger =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "rR"
    , Chars "iI"
    , Chars "gG"
    , Chars "gG"
    , Chars "eE"
    , Chars "rR" )]

let kw_references =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "eE"
    , Chars "fF"
    , Chars "eE"
    , Chars "rR"
    , Chars "eE"
    , Chars "nN"
    , Chars "cC"
    , Chars "eE"
    , Chars "sS" )]

let kw_constraint =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "nN"
    , Chars "sS"
    , Chars "tT"
    , Chars "rR"
    , Chars "aA"
    , Chars "iI"
    , Chars "nN"
    , Chars "tT" )]

let kw_primary =
  [%sedlex.regexp?
    ( Chars "pP"
    , Chars "rR"
    , Chars "iI"
    , Chars "mM"
    , Chars "aA"
    , Chars "rR"
    , Chars "yY" )]

let kw_unique =
  [%sedlex.regexp?
    Chars "uU", Chars "nN", Chars "iI", Chars "qQ", Chars "uU", Chars "eE"]

let kw_generated =
  [%sedlex.regexp?
    ( Chars "gG"
    , Chars "eE"
    , Chars "nN"
    , Chars "eE"
    , Chars "rR"
    , Chars "aA"
    , Chars "tT"
    , Chars "eE"
    , Chars "dD" )]

let kw_always =
  [%sedlex.regexp?
    Chars "aA", Chars "lL", Chars "wW", Chars "aA", Chars "yY", Chars "sS"]

let kw_check =
  [%sedlex.regexp? Chars "cC", Chars "hH", Chars "eE", Chars "cC", Chars "kK"]

let kw_restrict =
  [%sedlex.regexp?
    ( Chars "rR"
    , Chars "eE"
    , Chars "sS"
    , Chars "tT"
    , Chars "rR"
    , Chars "iI"
    , Chars "cC"
    , Chars "tT" )]

let kw_cascade =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "aA"
    , Chars "sS"
    , Chars "cC"
    , Chars "aA"
    , Chars "dD"
    , Chars "eE" )]

let kw_action =
  [%sedlex.regexp?
    Chars "aA", Chars "cC", Chars "tT", Chars "iI", Chars "oO", Chars "nN"]

let kw_deferrable =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "eE"
    , Chars "fF"
    , Chars "eE"
    , Chars "rR"
    , Chars "rR"
    , Chars "aA"
    , Chars "bB"
    , Chars "lL"
    , Chars "eE" )]

let kw_initially =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "nN"
    , Chars "iI"
    , Chars "tT"
    , Chars "iI"
    , Chars "aA"
    , Chars "lL"
    , Chars "lL"
    , Chars "yY" )]

let kw_deferred =
  [%sedlex.regexp?
    ( Chars "dD"
    , Chars "eE"
    , Chars "fF"
    , Chars "eE"
    , Chars "rR"
    , Chars "rR"
    , Chars "eE"
    , Chars "dD" )]

let kw_immediate =
  [%sedlex.regexp?
    ( Chars "iI"
    , Chars "mM"
    , Chars "mM"
    , Chars "eE"
    , Chars "dD"
    , Chars "iI"
    , Chars "aA"
    , Chars "tT"
    , Chars "eE" )]

let kw_create =
  [%sedlex.regexp?
    Chars "cC", Chars "rR", Chars "eE", Chars "aA", Chars "tT", Chars "eE"]

let kw_temp = [%sedlex.regexp? Chars "tT", Chars "eE", Chars "mM", Chars "pP"]

let kw_temporary =
  [%sedlex.regexp?
    ( Chars "tT"
    , Chars "eE"
    , Chars "mM"
    , Chars "pP"
    , Chars "oO"
    , Chars "rR"
    , Chars "aA"
    , Chars "rR"
    , Chars "yY" )]

let kw_foreign =
  [%sedlex.regexp?
    ( Chars "fF"
    , Chars "oO"
    , Chars "rR"
    , Chars "eE"
    , Chars "iI"
    , Chars "gG"
    , Chars "nN" )]

let kw_alter =
  [%sedlex.regexp? Chars "aA", Chars "lL", Chars "tT", Chars "eE", Chars "rR"]

let kw_add = [%sedlex.regexp? Chars "aA", Chars "dD", Chars "dD"]

let kw_column =
  [%sedlex.regexp?
    Chars "cC", Chars "oO", Chars "lL", Chars "uU", Chars "mM", Chars "nN"]

let kw_before =
  [%sedlex.regexp?
    Chars "bB", Chars "eE", Chars "fF", Chars "oO", Chars "rR", Chars "eE"]

let kw_each = [%sedlex.regexp? Chars "eE", Chars "aA", Chars "cC", Chars "hH"]

let kw_of = [%sedlex.regexp? Chars "oO", Chars "fF"]

(* 'token *)
let space = [%sedlex.regexp? Plus (Chars " \t")]

let newline = [%sedlex.regexp? "\r\n" | "\n" | "\r"]

let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z' | 0x0153 .. 0xfffd]

let digit = [%sedlex.regexp? '0' .. '9']

let hexit = [%sedlex.regexp? 'a' .. 'f' | 'A' .. 'F' | '0' .. '9']

let unsigned_integer = [%sedlex.regexp? Plus digit]

let decimal =
  [%sedlex.regexp?
    ( unsigned_integer
    | unsigned_integer, '.', unsigned_integer
    | '.', unsigned_integer )]

let exponent = [%sedlex.regexp? Chars "eE", Opt (Chars "+-"), unsigned_integer]

let hexdecimal = [%sedlex.regexp? "0x", Plus hexit]

let numeric = [%sedlex.regexp? decimal, Opt exponent | hexdecimal]

let identifier_start = [%sedlex.regexp? lu | ll | lt | lm | lo | nl]

let identifier_extend = [%sedlex.regexp? mn | mc | nd | pc | cf]

let identifier_part = [%sedlex.regexp? identifier_start | identifier_extend]

let regular_identifier =
  [%sedlex.regexp? identifier_start, Star identifier_part]

let delimited_identifier =
  [%sedlex.regexp? '"', Star ("\"\"" | Sub (any, '"')), '"']

let identifier = [%sedlex.regexp? regular_identifier | delimited_identifier]

let string = [%sedlex.regexp? "'", Star ("''" | Sub (any, "'")), "'"]

let blob = [%sedlex.regexp? Chars "xX", string]

let unicode_representation = [%sedlex.regexp? Rep (hexit, 4) | Rep (hexit, 6)]

let unicode_string =
  [%sedlex.regexp?
    ( Chars "uU"
    , "&"
    , "'"
    , Star ("''" | Sub (any, "'") | unicode_representation)
    , "'" )]

let escaped_type = [%sedlex.regexp? '{', "d" | "t" | "ts" | "b"]

let typed_string = [%sedlex.regexp? escaped_type, string, '}']

let bin_string = [%sedlex.regexp? "X", "'", Plus (Rep (hexit, 2)), "'"]

let rec token buf =
  match%sedlex buf with
  | kw_select -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_select)
  | kw_from -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_from)
  | kw_as -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_as)
  | kw_true -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_true)
  | kw_false -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_false)
  | kw_unknown -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_unknown)
  | kw_null -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_null)
  | kw_date -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_date)
  | kw_time -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_time)
  | kw_timestamp -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_timestamp)
  | kw_into -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_into)
  | kw_or -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_or)
  | kw_not -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_not)
  | kw_union -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_union)
  | kw_except -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_except)
  | kw_intersect -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_intersect)
  | kw_and -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_and)
  | kw_group -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_group)
  | kw_by -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_by)
  | kw_rollup -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_rollup)
  | kw_having -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_having)
  | kw_where -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_where)
  | kw_order -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_order)
  | kw_asc -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_asc)
  | kw_desc -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_desc)
  | kw_first -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_first)
  | kw_last -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_last)
  | kw_limit -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_limit)
  | kw_offset -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_offset)
  | kw_row -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_row)
  | kw_rows -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_rows)
  | kw_fetch -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_fetch)
  | kw_next -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_next)
  | kw_only -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_only)
  | kw_all -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_all)
  | kw_distinct -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_distinct)
  | kw_is -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_is)
  | kw_between -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_between)
  | kw_like_regex -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_like_regex)
  | kw_similar -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_similar)
  | kw_to -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_to)
  | kw_escape -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_escape)
  | kw_like -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_like)
  | kw_any -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_any)
  | kw_some -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_some)
  | kw_in -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_in)
  | kw_exists -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_exists)
  | kw_with -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_with)
  | kw_table -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_table)
  | kw_lateral -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_lateral)
  | kw_left -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_left)
  | kw_right -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_right)
  | kw_full -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_full)
  | kw_outer -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_outer)
  | kw_inner -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_inner)
  | kw_cross -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_cross)
  | kw_join -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_join)
  | kw_on -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_on)
  | kw_case -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_case)
  | kw_when -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_when)
  | kw_then -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_then)
  | kw_end -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_end)
  | kw_else -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_else)
  | kw_textagg -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_textagg)
  | kw_for -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_for)
  | kw_delimiter -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_delimiter)
  | kw_quote -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_quote)
  | kw_no -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_no)
  | kw_header -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_header)
  | kw_encoding -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_encoding)
  | kw_count -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_count)
  | kw_count_big -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_count_big)
  | kw_avg -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_avg)
  | kw_sum -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_sum)
  | kw_min -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_min)
  | kw_max -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_max)
  | kw_every -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_every)
  | kw_stddev_pop -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_stddev_pop)
  | kw_stddev_samp -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_stddev_samp)
  | kw_var_samp -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_var_samp)
  | kw_var_pop -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_var_pop)
  | kw_filter -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_filter)
  | kw_over -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_over)
  | kw_partition -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_partition)
  | kw_range -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_range)
  | kw_unbounded -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_unbounded)
  | kw_following -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_following)
  | kw_preceding -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_preceding)
  | kw_current -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current)
  | kw_row_number -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_row_number)
  | kw_rank -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_rank)
  | kw_dense_rank -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_dense_rank)
  | kw_percent_rank -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_percent_rank)
  | kw_cume_dist -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_cume_dist)
  | kw_convert -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_convert)
  | kw_cast -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_cast)
  | kw_substring -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_substring)
  | kw_extract -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_extract)
  | kw_year -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_year)
  | kw_month -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_month)
  | kw_day -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_day)
  | kw_hour -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_hour)
  | kw_minute -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_minute)
  | kw_second -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_second)
  | kw_quarter -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_quarter)
  | kw_epoch -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_epoch)
  | kw_trim -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_trim)
  | kw_leading -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_leading)
  | kw_trailing -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_trailing)
  | kw_both -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_both)
  | kw_to_chars -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_to_chars)
  | kw_to_bytes -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_to_bytes)
  | kw_insert -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_insert)
  | kw_translate -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_translate)
  | kw_position -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_position)
  | kw_listagg -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_listagg)
  | kw_within -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_within)
  | kw_current_date -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current_date)
  | kw_current_timestamp ->
    Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current_timestamp)
  | kw_current_time -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current_time)
  | kw_exception -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_exception)
  | kw_serial -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_serial)
  | kw_index -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_index)
  | kw_instead -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_instead)
  | kw_view -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_view)
  | kw_enabled -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_enabled)
  | kw_disabled -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_disabled)
  | kw_key -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_key)
  | kw_document -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_document)
  | kw_content -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_content)
  | kw_empty -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_empty)
  | kw_ordinality -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_ordinality)
  | kw_path -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_path)
  | kw_querystring -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_querystring)
  | kw_namespace -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_namespace)
  | kw_result -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_result)
  | kw_accesspattern -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_accesspattern)
  | kw_auto_increment ->
    Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_auto_increment)
  | kw_wellformed -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_wellformed)
  | kw_texttable -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_texttable)
  | kw_arraytable -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_arraytable)
  | kw_jsontable -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_jsontable)
  | kw_selector -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_selector)
  | kw_skip -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_skip)
  | kw_width -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_width)
  | kw_passing -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_passing)
  | kw_name -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_name)
  | kw_columns -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_columns)
  | kw_nulls -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_nulls)
  | kw_objecttable -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_objecttable)
  | kw_version -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_version)
  | kw_including -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_including)
  | kw_excluding -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_excluding)
  | kw_variadic -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_variadic)
  | kw_raise -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_raise)
  | kw_chain -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_chain)
  | kw_jsonarray_agg -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_jsonarray_agg)
  | kw_jsonobject -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_jsonobject)
  | kw_preserve -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_preserve)
  | kw_upsert -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_upsert)
  | kw_after -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_after)
  | kw_type -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_type)
  | kw_translator -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_translator)
  | kw_jaas -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_jaas)
  | kw_condition -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_condition)
  | kw_mask -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_mask)
  | kw_access -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_access)
  | kw_control -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_control)
  | kw_none -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_none)
  | kw_data -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_data)
  | kw_database -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_database)
  | kw_privileges -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_privileges)
  | kw_role -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_role)
  | kw_schema -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_schema)
  | kw_use -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_use)
  | kw_repository -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_repository)
  | kw_rename -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_rename)
  | kw_domain -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_domain)
  | kw_usage -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_usage)
  | kw_explain -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_explain)
  | kw_analyze -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_analyze)
  | kw_text -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_text)
  | kw_format -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_format)
  | kw_yaml -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_yaml)
  | kw_policy -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_policy)
  | kw_session_user -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_session_user)
  | kw_interval -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_interval)
  | kw_tablesample -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_tablesample)
  | kw_bernoulli -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_bernoulli)
  | kw_system -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_system)
  | kw_repeatable -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_repeatable)
  | kw_unnest -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_unnest)
  | kw_module -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_module)
  | kw_collate -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_collate)
  | kw_cube -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_cube)
  | kw_grouping -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_grouping)
  | kw_sets -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_sets)
  | kw_ties -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_ties)
  | kw_others -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_others)
  | kw_exclude -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_exclude)
  | kw_window -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_window)
  | kw_using -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_using)
  | kw_natural -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_natural)
  | kw_corresponding -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_corresponding)
  | kw_recursive -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_recursive)
  | kw_cycle -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_cycle)
  | kw_default -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_default)
  | kw_set -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_set)
  | kw_depth -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_depth)
  | kw_breadth -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_breadth)
  | kw_search -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_search)
  | kw_values -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_values)
  | kw_value -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_value)
  | kw_element -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_element)
  | kw_zone -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_zone)
  | kw_local -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_local)
  | kw_at -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_at)
  | kw_abs -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_abs)
  | kw_array -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_array)
  | kw_multiset -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_multiset)
  | kw_localtime -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_localtime)
  | kw_localtimestamp ->
    Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_localtimestamp)
  | kw_characters -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_characters)
  | kw_code_units -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_code_units)
  | kw_octets -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_octets)
  | kw_without -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_without)
  | kw_scope -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_scope)
  | kw_ref -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_ref)
  | kw_precision -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_precision)
  | kw_numeric -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_numeric)
  | kw_dec -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_dec)
  | kw_int -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_int)
  | kw_binary -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_binary)
  | kw_large -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_large)
  | kw_national -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_national)
  | kw_varying -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_varying)
  | kw_character -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_character)
  | kw_nchar -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_nchar)
  | kw_nclob -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_nclob)
  | kw_indicator -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_indicator)
  | kw_current_user -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current_user)
  | kw_system_user -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_system_user)
  | kw_current_default_transform_group ->
    Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current_default_transform_group)
  | kw_current_transform_group_for_type ->
    Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current_transform_group_for_type)
  | kw_current_path -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current_path)
  | kw_current_role -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_current_role)
  | kw_nullif -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_nullif)
  | kw_coalesce -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_coalesce)
  | kw_groups -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_groups)
  | kw_glob -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_glob)
  | kw_match -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_match)
  | kw_regexp -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_regexp)
  | kw_materialized -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_materialized)
  | kw_abort -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_abort)
  | kw_ignore -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_ignore)
  | kw_replace -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_replace)
  | kw_rollback -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_rollback)
  | kw_fail -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_fail)
  | kw_update -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_update)
  | kw_returning -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_returning)
  | kw_delete -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_delete)
  | kw_savepoint -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_savepoint)
  | kw_transaction -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_transaction)
  | kw_if -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_if)
  | kw_drop -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_drop)
  | kw_begin -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_begin)
  | kw_commit -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_commit)
  | kw_trigger -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_trigger)
  | kw_references -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_references)
  | kw_constraint -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_constraint)
  | kw_primary -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_primary)
  | kw_unique -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_unique)
  | kw_generated -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_generated)
  | kw_always -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_always)
  | kw_check -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_check)
  | kw_cascade -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_cascade)
  | kw_restrict -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_restrict)
  | kw_action -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_action)
  | kw_deferrable -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_deferrable)
  | kw_initially -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_initially)
  | kw_deferred -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_deferred)
  | kw_immediate -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_immediate)
  | kw_create -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_create)
  | kw_temp -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_temp)
  | kw_temporary -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_temporary)
  | kw_foreign -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_foreign)
  | kw_alter -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_alter)
  | kw_add -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_add)
  | kw_column -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_column)
  | kw_before -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_before)
  | kw_each -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_each)
  | kw_of -> Tok_keyword (Sedlexing.Utf8.lexeme buf, Kw_of)
  (* literals *)
  | "--" -> inline_comment (Buffer.create 10) buf
  | "/*" -> block_comment (Buffer.create 10) buf
  | string -> Tok_string (Sedlexing.Utf8.lexeme buf)
  | blob -> Tok_blob (Sedlexing.Utf8.lexeme buf)
  | identifier -> Tok_ident (Sedlexing.Utf8.lexeme buf)
  | numeric -> Tok_numeric (Sedlexing.Utf8.lexeme buf)
  | space -> Tok_space
  | newline ->
    Sedlexing.new_line buf;
    Tok_newline
  | '(' -> Tok_lparen
  | ')' -> Tok_rparen
  | '.' -> Tok_period
  | ',' -> Tok_comma
  | ':' -> Tok_colon
  | '$' -> Tok_dollar
  | '{' -> Tok_lbrace
  | '}' -> Tok_rbrace
  | '[' -> Tok_lsbrace
  | ']' -> Tok_rsbrace
  | '?' -> Tok_qmark
  | ';' -> Tok_semicolon
  | '\'' -> Tok_quote
  | "->>" -> Op_extract_2
  | "->" -> Op_extract
  | '+' -> Op_plus
  | '-' -> Op_minus
  | '*' -> Op_star
  | '/' -> Op_slash
  | "||" -> Op_concat
  | "&" -> Op_amp
  | "|" -> Op_pipe
  | "==" -> Op_eq2
  | '=' -> Op_eq
  | ">=" -> Op_ge
  | '>' -> Op_gt
  | "<=" -> Op_le
  | '<' -> Op_lt
  | "<>" -> Op_ne
  | "!=" -> Op_ne2
  | "~" -> Op_tilda
  | "<<" -> Op_lshift
  | ">>" -> Op_rshift
  | eof -> Tok_eof
  | _ ->
    failwith
      (Printf.sprintf "Malformed source: `%s'" @@ Sedlexing.Utf8.lexeme buf)

and inline_comment buffer buf =
  match%sedlex buf with
  | newline ->
    Sedlexing.new_line buf;
    Tok_line_comment (Buffer.contents buffer)
  | eof -> Tok_eof
  | any ->
    Buffer.add_string buffer (Sedlexing.Utf8.lexeme buf);
    inline_comment buffer buf
  | _ ->
    failwith
      (Printf.sprintf "Malformed source: `%s'" @@ Sedlexing.Utf8.lexeme buf)

and block_comment buffer buf =
  match%sedlex buf with
  | newline ->
    Sedlexing.new_line buf;
    Buffer.add_string buffer (Sedlexing.Utf8.lexeme buf);
    block_comment buffer buf
  | eof -> Tok_eof
  | "*/" ->
    Buffer.add_string buffer (Sedlexing.Utf8.lexeme buf);
    Tok_block_comment (Buffer.contents buffer)
  | any ->
    Buffer.add_string buffer (Sedlexing.Utf8.lexeme buf);
    block_comment buffer buf
  | _ ->
    failwith
      (Printf.sprintf "Malformed source: `%s'" @@ Sedlexing.Utf8.lexeme buf)
