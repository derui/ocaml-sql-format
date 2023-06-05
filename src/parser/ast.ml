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

and value_expression_primary = Vep_column of identifier list
[@@deriving show, eq]
