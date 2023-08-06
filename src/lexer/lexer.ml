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

let kw_collation =
  [%sedlex.regexp?
    ( Chars "cC"
    , Chars "oO"
    , Chars "lL"
    , Chars "lL"
    , Chars "aA"
    , Chars "tT"
    , Chars "iI"
    , Chars "oO"
    , Chars "nN" )]

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
  | kw_select -> Kw_select
  | kw_from -> Kw_from
  | kw_as -> Kw_as
  | kw_true -> Kw_true
  | kw_false -> Kw_false
  | kw_unknown -> Kw_unknown
  | kw_null -> Kw_null
  | kw_date -> Kw_date
  | kw_time -> Kw_time
  | kw_timestamp -> Kw_timestamp
  | kw_into -> Kw_into
  | kw_or -> Kw_or
  | kw_not -> Kw_not
  | kw_union -> Kw_union
  | kw_except -> Kw_except
  | kw_intersect -> Kw_intersect
  | kw_and -> Kw_and
  | kw_group -> Kw_group
  | kw_by -> Kw_by
  | kw_rollup -> Kw_rollup
  | kw_having -> Kw_having
  | kw_where -> Kw_where
  | kw_order -> Kw_order
  | kw_asc -> Kw_asc
  | kw_desc -> Kw_desc
  | kw_first -> Kw_first
  | kw_last -> Kw_last
  | kw_limit -> Kw_limit
  | kw_offset -> Kw_offset
  | kw_row -> Kw_row
  | kw_rows -> Kw_rows
  | kw_fetch -> Kw_fetch
  | kw_next -> Kw_next
  | kw_only -> Kw_only
  | kw_all -> Kw_all
  | kw_distinct -> Kw_distinct
  | kw_is -> Kw_is
  | kw_between -> Kw_between
  | kw_like_regex -> Kw_like_regex
  | kw_similar -> Kw_similar
  | kw_to -> Kw_to
  | kw_escape -> Kw_escape
  | kw_like -> Kw_like
  | kw_any -> Kw_any
  | kw_some -> Kw_some
  | kw_in -> Kw_in
  | kw_exists -> Kw_exists
  | kw_with -> Kw_with
  | kw_table -> Kw_table
  | kw_lateral -> Kw_lateral
  | kw_left -> Kw_left
  | kw_right -> Kw_right
  | kw_full -> Kw_full
  | kw_outer -> Kw_outer
  | kw_inner -> Kw_inner
  | kw_cross -> Kw_cross
  | kw_join -> Kw_join
  | kw_on -> Kw_on
  | kw_case -> Kw_case
  | kw_when -> Kw_when
  | kw_then -> Kw_then
  | kw_end -> Kw_end
  | kw_else -> Kw_else
  | kw_textagg -> Kw_textagg
  | kw_for -> Kw_for
  | kw_delimiter -> Kw_delimiter
  | kw_quote -> Kw_quote
  | kw_no -> Kw_no
  | kw_header -> Kw_header
  | kw_encoding -> Kw_encoding
  | kw_count -> Kw_count
  | kw_count_big -> Kw_count_big
  | kw_avg -> Kw_avg
  | kw_sum -> Kw_sum
  | kw_min -> Kw_min
  | kw_max -> Kw_max
  | kw_every -> Kw_every
  | kw_stddev_pop -> Kw_stddev_pop
  | kw_stddev_samp -> Kw_stddev_samp
  | kw_var_samp -> Kw_var_samp
  | kw_var_pop -> Kw_var_pop
  | kw_filter -> Kw_filter
  | kw_over -> Kw_over
  | kw_partition -> Kw_partition
  | kw_range -> Kw_range
  | kw_unbounded -> Kw_unbounded
  | kw_following -> Kw_following
  | kw_preceding -> Kw_preceding
  | kw_current -> Kw_current
  | kw_row_number -> Kw_row_number
  | kw_rank -> Kw_rank
  | kw_dense_rank -> Kw_dense_rank
  | kw_percent_rank -> Kw_percent_rank
  | kw_cume_dist -> Kw_cume_dist
  | kw_convert -> Kw_convert
  | kw_cast -> Kw_cast
  | kw_substring -> Kw_substring
  | kw_extract -> Kw_extract
  | kw_year -> Kw_year
  | kw_month -> Kw_month
  | kw_day -> Kw_day
  | kw_hour -> Kw_hour
  | kw_minute -> Kw_minute
  | kw_second -> Kw_second
  | kw_quarter -> Kw_quarter
  | kw_epoch -> Kw_epoch
  | kw_trim -> Kw_trim
  | kw_leading -> Kw_leading
  | kw_trailing -> Kw_trailing
  | kw_both -> Kw_both
  | kw_to_chars -> Kw_to_chars
  | kw_to_bytes -> Kw_to_bytes
  | kw_insert -> Kw_insert
  | kw_translate -> Kw_translate
  | kw_position -> Kw_position
  | kw_listagg -> Kw_listagg
  | kw_within -> Kw_within
  | kw_current_date -> Kw_current_date
  | kw_current_timestamp -> Kw_current_timestamp
  | kw_current_time -> Kw_current_time
  | kw_exception -> Kw_exception
  | kw_serial -> Kw_serial
  | kw_index -> Kw_index
  | kw_instead -> Kw_instead
  | kw_view -> Kw_view
  | kw_enabled -> Kw_enabled
  | kw_disabled -> Kw_disabled
  | kw_key -> Kw_key
  | kw_document -> Kw_document
  | kw_content -> Kw_content
  | kw_empty -> Kw_empty
  | kw_ordinality -> Kw_ordinality
  | kw_path -> Kw_path
  | kw_querystring -> Kw_querystring
  | kw_namespace -> Kw_namespace
  | kw_result -> Kw_result
  | kw_accesspattern -> Kw_accesspattern
  | kw_auto_increment -> Kw_auto_increment
  | kw_wellformed -> Kw_wellformed
  | kw_texttable -> Kw_texttable
  | kw_arraytable -> Kw_arraytable
  | kw_jsontable -> Kw_jsontable
  | kw_selector -> Kw_selector
  | kw_skip -> Kw_skip
  | kw_width -> Kw_width
  | kw_passing -> Kw_passing
  | kw_name -> Kw_name
  | kw_columns -> Kw_columns
  | kw_nulls -> Kw_nulls
  | kw_objecttable -> Kw_objecttable
  | kw_version -> Kw_version
  | kw_including -> Kw_including
  | kw_excluding -> Kw_excluding
  | kw_variadic -> Kw_variadic
  | kw_raise -> Kw_raise
  | kw_chain -> Kw_chain
  | kw_jsonarray_agg -> Kw_jsonarray_agg
  | kw_jsonobject -> Kw_jsonobject
  | kw_preserve -> Kw_preserve
  | kw_upsert -> Kw_upsert
  | kw_after -> Kw_after
  | kw_type -> Kw_type
  | kw_translator -> Kw_translator
  | kw_jaas -> Kw_jaas
  | kw_condition -> Kw_condition
  | kw_mask -> Kw_mask
  | kw_access -> Kw_access
  | kw_control -> Kw_control
  | kw_none -> Kw_none
  | kw_data -> Kw_data
  | kw_database -> Kw_database
  | kw_privileges -> Kw_privileges
  | kw_role -> Kw_role
  | kw_schema -> Kw_schema
  | kw_use -> Kw_use
  | kw_repository -> Kw_repository
  | kw_rename -> Kw_rename
  | kw_domain -> Kw_domain
  | kw_usage -> Kw_usage
  | kw_explain -> Kw_explain
  | kw_analyze -> Kw_analyze
  | kw_text -> Kw_text
  | kw_format -> Kw_format
  | kw_yaml -> Kw_yaml
  | kw_policy -> Kw_policy
  | kw_session_user -> Kw_session_user
  | kw_interval -> Kw_interval
  | kw_tablesample -> Kw_tablesample
  | kw_bernoulli -> Kw_bernoulli
  | kw_system -> Kw_system
  | kw_repeatable -> Kw_repeatable
  | kw_unnest -> Kw_unnest
  | kw_module -> Kw_module
  | kw_collate -> Kw_collate
  | kw_cube -> Kw_cube
  | kw_grouping -> Kw_grouping
  | kw_sets -> Kw_sets
  | kw_ties -> Kw_ties
  | kw_others -> Kw_others
  | kw_exclude -> Kw_exclude
  | kw_window -> Kw_window
  | kw_using -> Kw_using
  | kw_natural -> Kw_natural
  | kw_corresponding -> Kw_corresponding
  | kw_recursive -> Kw_recursive
  | kw_cycle -> Kw_cycle
  | kw_default -> Kw_default
  | kw_set -> Kw_set
  | kw_depth -> Kw_depth
  | kw_breadth -> Kw_breadth
  | kw_search -> Kw_search
  | kw_values -> Kw_values
  | kw_value -> Kw_value
  | kw_element -> Kw_element
  | kw_zone -> Kw_zone
  | kw_local -> Kw_local
  | kw_at -> Kw_at
  | kw_abs -> Kw_abs
  | kw_array -> Kw_array
  | kw_multiset -> Kw_multiset
  | kw_localtime -> Kw_localtime
  | kw_localtimestamp -> Kw_localtimestamp
  | kw_characters -> Kw_characters
  | kw_code_units -> Kw_code_units
  | kw_octets -> Kw_octets
  | kw_without -> Kw_without
  | kw_scope -> Kw_scope
  | kw_ref -> Kw_ref
  | kw_precision -> Kw_precision
  | kw_numeric -> Kw_numeric
  | kw_dec -> Kw_dec
  | kw_int -> Kw_int
  | kw_binary -> Kw_binary
  | kw_large -> Kw_large
  | kw_national -> Kw_national
  | kw_varying -> Kw_varying
  | kw_character -> Kw_character
  | kw_nchar -> Kw_nchar
  | kw_nclob -> Kw_nclob
  | kw_collation -> Kw_collation
  | kw_indicator -> Kw_indicator
  | kw_current_user -> Kw_current_user
  | kw_system_user -> Kw_system_user
  | kw_current_default_transform_group -> Kw_current_default_transform_group
  | kw_current_transform_group_for_type -> Kw_current_transform_group_for_type
  | kw_current_path -> Kw_current_path
  | kw_current_role -> Kw_current_role
  | kw_nullif -> Kw_nullif
  | kw_coalesce -> Kw_coalesce
  | kw_groups -> Kw_groups
  | kw_glob -> Kw_glob
  | kw_match -> Kw_match
  | kw_regexp -> Kw_regexp
  | kw_materialized -> Kw_materialized
  | kw_abort -> Kw_abort
  | kw_ignore -> Kw_ignore
  | kw_replace -> Kw_replace
  | kw_rollback -> Kw_rollback
  | kw_fail -> Kw_fail
  | kw_update -> Kw_update
  | kw_returning -> Kw_returning
  | kw_delete -> Kw_delete
  | kw_savepoint -> Kw_savepoint
  (* literals *)
  | string -> Tok_string (Sedlexing.Utf8.lexeme buf)
  | blob -> Tok_blob (Sedlexing.Utf8.lexeme buf)
  | identifier -> Tok_ident (Sedlexing.Utf8.lexeme buf)
  | numeric -> Tok_numeric (Sedlexing.Utf8.lexeme buf)
  | space -> token buf
  | newline ->
    Sedlexing.new_line buf;
    token buf
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
