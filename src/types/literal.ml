(** literals *)
type 'a identifier = Identifier of [ `keyword of Token.t | `raw of string ] * 'a

and 'a non_reserved_identifier =
  | Non_reserved_identifier of
      [ `exception' | `serial | `object' | `index | `json | `geometry | `geography | `basic of 'a basic_non_reserved ]
      * 'a

and 'a basic_non_reserved =
  | Basic_non_reserved of
      [ `instead
      | `view
      | `enabled
      | `disabled
      | `key
      | `textagg
      | `count
      | `count_big
      | `row_number
      | `rank
      | `dense_rank
      | `sum
      | `avg
      | `min
      | `max
      | `every
      | `stddev_pop
      | `stddev_samp
      | `var_samp
      | `var_pop
      | `document
      | `content
      | `trim
      | `empty
      | `ordinality
      | `path
      | `first
      | `last
      | `next
      | `substring
      | `extract
      | `to_chars
      | `to_bytes
      | `timestampadd
      | `timestampdiff
      | `querystring
      | `namespace
      | `result
      | `accesspattern
      | `auto_increment
      | `wellformed
      | `sql_tsi_frac_second
      | `sql_tsi_second
      | `sql_tsi_minute
      | `sql_tsi_hour
      | `sql_tsi_day
      | `sql_tsi_week
      | `sql_tsi_month
      | `sql_tsi_quarter
      | `sql_tsi_year
      | `texttable
      | `arraytable
      | `jsontable
      | `selector
      | `skip
      | `width
      | `passing
      | `name
      | `encoding
      | `columns
      | `delimiter
      | `quote
      | `header
      | `nulls
      | `objecttable
      | `version
      | `including
      | `excluding
      | `xmldeclaration
      | `variadic
      | `raise
      | `chain
      | `jsonarray_agg
      | `jsonobject
      | `preserve
      | `upsert
      | `after
      | `type'
      | `translator
      | `jaas
      | `condition
      | `mask
      | `access
      | `control
      | `none
      | `data
      | `database
      | `privileges
      | `role
      | `schema
      | `use
      | `repository
      | `rename
      | `domain
      | `usage
      | `position
      | `current
      | `unbounded
      | `preceding
      | `following
      | `listagg
      | `explain
      | `analyze
      | `text
      | `format
      | `yaml
      | `epoch
      | `quarter
      | `policy
      ]
      * 'a

and 'a non_numeric_literal =
  | Non_numeric_literal of
      [ `string of string
      | `typed_string of string
      | `bin_string of string
      | `TRUE
      | `FALSE
      | `UNKNOWN
      | `NULL
      | `datetime_string of string
      ]
      * 'a

and 'a literal_value =
  | Literal_value of
      [ `null
      | `true'
      | `false'
      | `current_time
      | `current_date
      | `current_timestamp
      | `blob of 'a blob_literal
      | `string of 'a string_literal
      | `numeric of 'a numeric_literal
      ]
      * 'a

and 'a numeric_literal = Numeric_literal of string * 'a

and 'a string_literal = String_literal of string * 'a

and 'a blob_literal = Blob_literal of string * 'a
