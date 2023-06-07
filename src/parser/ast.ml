module Literal = struct
  type unsigned_integer = Unsigned_integer of string [@@deriving show, eq]

  and approximate_numeric =
    | Approximate_numeric of
        { digit : string
        ; fraction : unsigned_integer
        ; exponent_sign : [ `plus | `minus ]
        ; exponent : unsigned_integer
        }
  [@@deriving show, eq]

  and decimal_numeric =
    | Decimal_numeric of
        { digit : string option
        ; fraction : unsigned_integer
        }
  [@@deriving show, eq]

  type sql_string = string [@@deriving show, eq]

  type bin_string = string [@@deriving show, eq]

  type sql_false = [ `FALSE ] [@@deriving show, eq]

  type sql_true = [ `TRUE ] [@@deriving show, eq]

  type unknown = [ `UNKNOWN ] [@@deriving show, eq]

  type null = [ `NULL ] [@@deriving show, eq]

  type datetime_string =
    [ `date of string
    | `time of string
    | `timestamp of string
    ]
  [@@deriving show, eq]
end

type statement =
  | Stmt_select of
      { qualifier : qualifier option
      ; select_list : select_list
      }
[@@deriving show, eq]

and qualifier =
  | Distinct
  | All
[@@deriving show, eq]

and select_list =
  | Sl_asterisk
  | Sl_sublists of select_sublist list
[@@deriving show, eq]

and select_sublist =
  | Ss_derived_column of
      { exp : value_expression
      ; as_clause : identifier option
      }
  | Ss_qualified_asterisk of identifier list
[@@deriving show, eq]

and identifier = Ident of string [@@deriving show, eq]

and value_expression =
  | Exp_parenthesized of value_expression
  | Exp_nonparenthesized of value_expression_primary
[@@deriving show, eq]

and common_value_expression =
  | Cve_numeric of (numeric_value_expression * [ `amp | `concat ] option) list
[@@deriving show, eq]

and numeric_value_expression =
  | Nve_exp of (term * [ `plus | `minus ] option) list
[@@deriving show, eq]

and term = Term of (value_expression_primary * [ `star | `slash ] option) list
[@@deriving show, eq]

and value_expression_primary =
  | Vep_column of identifier list
  | Vep_non_numeric of non_numeric_literal
[@@deriving show, eq]

and non_numeric_literal =
  | Lit_string of Literal.sql_string
  | Lit_bin_string of Literal.bin_string
  | Lit_true of Literal.sql_true
  | Lit_false of Literal.sql_false
  | Lit_unknown of Literal.unknown
  | Lit_null of Literal.null
  | Lit_datetime_string of Literal.datetime_string

and unsigned_numeric_literal =
  [ `unsigned of Literal.unsigned_integer
  | `approximate of Literal.approximate_numeric
  | `decimal of Literal.decimal_numeric
  ]
[@@deriving show, eq]
