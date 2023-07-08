open Basic

(** literals *)
type 'a identifier = Identifier of string * 'a

and 'a non_reserved_identifier =
  | Non_reserved_identifier of
      [ `exception'
      | `serial
      | `object'
      | `index
      | `json
      | `geometry
      | `geography
      | `basic of 'a basic_non_reserved
      ]
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

(* does not handle structure of unsigned numeric literal. exact and approximate should be handle in lexer. *)
and 'a unsigned_numeric_literal = Unsigned_numeric_literal of string * 'a

and 'a signed_numeric_literal =
  | Signed_numeric_literal of sign option * 'a unsigned_numeric_literal * 'a

and 'a unsigned_integer = Unsigned_integer of string * 'a

and 'a signed_integer =
  | Signed_integer of sign option * 'a unsigned_integer * 'a

and 'a character_string_literal = Character_string_literal of string * 'a

and 'a national_character_string_literal =
  | National_character_string_literal of string * 'a

and 'a unicode_character_string_literal =
  | Unicode_character_string_literal of string * 'a

and 'a binary_string_literal = Binary_string_literal of string * 'a

and 'a datetime_literal =
  | Datetime_literal of
      [ `date of 'a date_literal
      | `time of 'a time_literal
      | `timestamp of 'a timestamp_literal
      ]
      * 'a

(* does not handle structure of datetime literal in current formatter *)
and 'a date_literal = Date_literal of string * 'a

and 'a time_literal = Time_literal of string * 'a

and 'a timestamp_literal = Timestamp_literal of string * 'a

and 'a interval_literal =
  | Interval_literal of sign option * string * 'a interval_qualifier * 'a

and 'a interval_qualifier =
  | Interval_qualifier of
      [ `single of
        [ `primary of
          non_second_primary_datetime_field * 'a unsigned_integer option
        | `second of 'a unsigned_integer option * 'a unsigned_integer option
        ]
      | `start_end of
        (non_second_primary_datetime_field * 'a unsigned_integer option)
        * [ `primary of non_second_primary_datetime_field
          | `second of 'a unsigned_integer option
          ]
      ]
      * 'a

and 'a boolean_literal =
  | Boolean_literal of [ `true' | `false' | `unknown ] * 'a

and 'a general_literal =
  | General_literal of
      [ `character of 'a character_string_literal
      | `national of 'a national_character_string_literal
      | `unicode of 'a unicode_character_string_literal
      | `binary of 'a binary_string_literal
      | `datetime of 'a datetime_literal
      | `interval of 'a interval_literal
      | `boolean of 'a boolean_literal
      ]
      * 'a

and 'a unsigned_literal =
  | Unsigned_literal of
      [ `numeric of 'a unsigned_numeric_literal
      | `general of 'a general_literal
      ]
      * 'a

and 'a literal =
  | Literal of
      [ `numeric of 'a signed_numeric_literal | `general of 'a general_literal ]
      * 'a
