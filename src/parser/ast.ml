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

and select_list = Sl_asterisk [@@deriving show, eq]
