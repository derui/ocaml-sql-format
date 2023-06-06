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

and value_expression_primary = Vep_column of identifier list
[@@deriving show, eq]

and unsigned_numeric_literal =
  [ `unsigned of Literal.unsigned_integer
  | `approximate of Literal.approximate_numeric
  | `decimal of Literal.decimal_numeric
  ]
[@@deriving show, eq]
