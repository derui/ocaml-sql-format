(** CST in SQL for formatter.

    Each CST is a list of selectors. Each selector has type [Raw.t -> Raw.t option]. And each selector has name prefix
    of target, e.g. [kw_] for keyword, [n_] for node. *)

module Sql_stmt_list = struct
  (** [n_sql_stmt raw] selects [sql_stmt] *)
  let n_sql_stmt = function
    | Raw.Node { kind = Kind.N_sql_stmt; _ } as v -> Some v
    | _ -> None

  (** [t_semicolonf raw] selects *)
  let t_semicolon = function
    | Raw.Leaf { kind = Kind.L_semicolon; _ } as v -> Some v
    | _ -> None
end

(** CST for sql_stmt *)
module Sql_stmt = struct
  module T = Types.Token

  (** [kw_explain raw] selects [explain] *)
  let kw_explain = Cst_support.is_keyword Types.Keyword.Kw_explain

  (** [kw_analyze raw] selects [analyze] *)
  let kw_analyze = Cst_support.is_keyword Types.Keyword.Kw_analyze

  (** [n_select_stmt raw] selects [select_stmt] *)
  let n_select_stmt = function
    | Raw.Node { kind = Kind.N_select_stmt; _ } as v -> Some v
    | _ -> None

  (** [n_delete_stmt raw] selects [delete_stmt] *)
  let n_delete_stmt = function
    | Raw.Node { kind = Kind.N_delete_stmt; _ } as v -> Some v
    | _ -> None

  (** [n_rollback_stmt raw] selects [rollback_stmt] *)
  let n_rollback_stmt = function
    | Raw.Node { kind = Kind.N_rollback_stmt; _ } as v -> Some v
    | _ -> None

  (** [n_begin_stmt raw] selects [begin_stmt] *)
  let n_begin_stmt = function
    | Raw.Node { kind = Kind.N_begin_stmt; _ } as v -> Some v
    | _ -> None

  (** [n_commit_stmt raw] selects [commit_stmt] *)
  let n_commit_stmt = function
    | Raw.Node { kind = Kind.N_commit_stmt; _ } as v -> Some v
    | _ -> None

  (** [n_create_index_stmt raw] selects [create_index_stmt] *)
  let n_create_index_stmt = function
    | Raw.Node { kind = Kind.N_create_index_stmt; _ } as v -> Some v
    | _ -> None
end

(** CST for begin_stmt *)
module Begin_stmt = struct
  module K = Types.Keyword

  (** [kw_begin raw] selects keyword [begin] *)
  let kw_begin = Cst_support.is_keyword K.Kw_begin

  (** [kw_transaction raw] selects keyword [transaction] *)
  let kw_transaction = Cst_support.is_keyword K.Kw_transaction
end

(** CST for rollback_stmt *)
module Rollback_stmt = struct
  module K = Types.Keyword

  (** [kw_rollback raw] selects keyword [rollback] *)
  let kw_rollback = Cst_support.is_keyword K.Kw_rollback

  (** [kw_transaction raw] selects keyword [transaction] *)
  let kw_transaction = Cst_support.is_keyword K.Kw_transaction
end

(** CST for select_stmt *)
module Select_stmt = struct
  module K = Types.Keyword

  (** [kw_distinct raw] selects keyword [distinct] *)
  let kw_distinct = Cst_support.is_keyword K.Kw_distinct

  (** [kw_union raw] selects keyword [union] *)
  let kw_union = Cst_support.is_keyword K.Kw_union

  (** [kw_all raw] selects keyword [all] *)
  let kw_all = Cst_support.is_keyword K.Kw_all

  (** [kw_intersect raw] selects keyword [intersect] *)
  let kw_intersect = Cst_support.is_keyword K.Kw_intersect

  (** [kw_except raw] selects keyword [except] *)
  let kw_except = Cst_support.is_keyword K.Kw_except

  (** [n_with_clause raw] selects [with_clause] *)
  let n_with_clause = function
    | Raw.Node { kind = Kind.N_with_clause; _ } as v -> Some v
    | _ -> None

  (** [n_select_core raw] selects [select_core] *)
  let n_select_core = function
    | Raw.Node { kind = Kind.N_select_core; _ } as v -> Some v
    | _ -> None
end

(** CST for with_clause *)
module With_clause = struct
  module K = Types.Keyword

  (** [kw_with raw] selects keyword [with] *)
  let kw_with = Cst_support.is_keyword K.Kw_with

  (** [kw_recursive raw] selects keyword [recursive] *)
  let kw_recursive = Cst_support.is_keyword K.Kw_recursive

  (** [t_comma raw] selects keyword [comma] *)
  let t_comma = function
    | Raw.Leaf { kind = Kind.L_comma; _ } as v -> Some v
    | _ -> None

  (** [n_common_table_expression raw] selects [common_table_expression] *)
  let n_common_table_expression = function
    | Raw.Node { kind = Kind.N_common_table_expression; _ } as v -> Some v
    | _ -> None

  (** [n_select_stmt raw] selects [select_stmt] *)
  let n_select_stmt = function
    | Raw.Node { kind = Kind.N_select_stmt; _ } as v -> Some v
    | _ -> None
end

(** CST for common_table_expression *)
module Common_table_expression = struct
  module K = Types.Keyword

  (** [t_ident raw] selects [ident] *)
  let t_ident = function
    | Raw.Leaf { kind = L_ident; _ } as v -> Some v
    | _ -> None

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = function
    | Raw.Leaf { kind = L_lparen; _ } as v -> Some v
    | _ -> None

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = function
    | Raw.Leaf { kind = L_rparen; _ } as v -> Some v
    | _ -> None

  (** [n_select_stmt raw] selects [select_stmt] *)
  let n_select_stmt = function
    | Raw.Node { kind = Kind.N_select_stmt; _ } as v -> Some v
    | _ -> None

  (** [n_column_name_list raw] selects [column_name_list] *)
  let n_column_name_list = function
    | Raw.Node { kind = Kind.N_column_name_list; _ } as v -> Some v
    | _ -> None

  (** [kw_as raw] selects [as] keyword *)
  let kw_as = Cst_support.is_keyword K.Kw_as

  (** [kw_not raw] selects [not] keyword *)
  let kw_not = Cst_support.is_keyword K.Kw_not

  (** [kw_materialized raw] selects [materialized] keyword *)
  let kw_materialized = Cst_support.is_keyword K.Kw_materialized
end

(** CST for column_name_list *)
module Column_name_list = struct
  module K = Types.Keyword

  (** [t_comma raw] selects [comma] *)
  let t_comma = function
    | Raw.Leaf { kind = L_comma; _ } as v -> Some v
    | _ -> None

  (** [t_ident raw] selects [ident] *)
  let t_ident = function
    | Raw.Leaf { kind = L_ident; _ } as v -> Some v
    | _ -> None
end

(** CST for select_core *)
module Select_core = struct
  module K = Types.Keyword

  (** [n_result_column_list raw] selects [result_column_list] *)
  let n_result_column_list = function
    | Raw.Node { kind = Kind.N_result_column_list; _ } as v -> Some v
    | _ -> None

  (** [n_from_clause raw] selects [from_clause] *)
  let n_from_clause = function
    | Raw.Node { kind = Kind.N_from_clause; _ } as v -> Some v
    | _ -> None

  (** [n_where_clause raw] selects [where_clause] *)
  let n_where_clause = function
    | Raw.Node { kind = Kind.N_where_clause; _ } as v -> Some v
    | _ -> None

  (** [n_group_by_clause raw] selects [group_by_clause] *)
  let n_group_by_clause = function
    | Raw.Node { kind = Kind.N_group_by_clause; _ } as v -> Some v
    | _ -> None

  (** [n_having_clause raw] selects [having_clause] *)
  let n_having_clause = function
    | Raw.Node { kind = Kind.N_having_clause; _ } as v -> Some v
    | _ -> None

  (** [n_window_clause raw] selects [window_clause] *)
  let n_window_clause = function
    | Raw.Node { kind = Kind.N_window_clause; _ } as v -> Some v
    | _ -> None
end

(** CST for result_column_list *)
module Result_column_list = struct
  module K = Types.Keyword

  (** [t_comma raw] selects [comma] *)
  let t_comma = function
    | Raw.Leaf { kind = L_comma; _ } as v -> Some v
    | _ -> None

  (** [n_result_column raw] selects [result_column] *)
  let n_result_column = function
    | Raw.Node { kind = Kind.N_result_column; _ } as v -> Some v
    | _ -> None
end

(** CST for result_column *)
module Result_column = struct
  module K = Types.Keyword

  (** [n_alias] selects [result_column_alias] node *)
  let n_alias = function
    | Raw.Node { kind = Kind.N_result_column_alias; _ } as v -> Some v
    | _ -> None

  (** [t_star] selects [star] *)
  let t_star = function
    | Raw.Leaf { kind = L_star; _ } as v -> Some v
    | _ -> None

  (** [n_table_name] selects [result_column_table_name] *)
  let n_table_name = function
    | Raw.Node { kind = Kind.N_result_column_table_name; _ } as v -> Some v
    | _ -> None
end

(** CST for result_column_alias *)
module Result_column_alias = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] node *)
  let n_expr = function
    | Raw.Node { kind = N_expr; _ } as v -> Some v
    | _ -> None

  (** [kw_as raw] selects [as] keyword *)
  let kw_as = Cst_support.is_keyword Kw_as

  (** [t_ident raw] selects [ident] *)
  let t_ident = function
    | Raw.Leaf { kind = L_ident; _ } as v -> Some v
    | _ -> None
end

(** CST for result_column_table_name *)
module Result_column_table_name = struct
  module K = Types.Keyword

  (** [t_period raw] selects [period] *)
  let t_period = function
    | Raw.Leaf { kind = L_period; _ } as v -> Some v
    | _ -> None

  (** [t_star raw] selects [star] *)
  let t_star = function
    | Raw.Leaf { kind = L_star; _ } as v -> Some v
    | _ -> None

  (** [t_ident raw] selects [ident] *)
  let t_ident = function
    | Raw.Leaf { kind = L_ident; _ } as v -> Some v
    | _ -> None
end

(** CST for expr *)
module Expr = struct
  module K = Types.Keyword

  (** [t_qmark raw] selects [qmark] *)
  let t_qmark = function
    | Raw.Leaf { kind = L_qmark; _ } as v -> Some v
    | _ -> None

  (** [t_string raw] selects [Tok_string] *)
  let t_string = function
    | Raw.Leaf { kind = L_string; _ } as v -> Some v
    | _ -> None

  (** [t_numeric raw] selects [Tok_numeric] *)
  let t_numeric = function
    | Raw.Leaf { kind = L_numeric; _ } as v -> Some v
    | _ -> None

  (** [t_blob raw] selects [Tok_blob] *)
  let t_blob = function
    | Raw.Leaf { kind = L_blob; _ } as v -> Some v
    | _ -> None

  (** [kw_null raw] selects [null] keyword *)
  let kw_null = Cst_support.is_keyword K.Kw_null

  (** [kw_true raw] selects [true] keyword *)
  let kw_true = Cst_support.is_keyword K.Kw_true

  (** [kw_false raw] selects [false] keyword *)
  let kw_false = Cst_support.is_keyword K.Kw_false

  (** [kw_current_time raw] selects [current_time] keyword *)
  let kw_current_time = Cst_support.is_keyword K.Kw_current_time

  (** [kw_current_date raw] selects [current_date] keyword *)
  let kw_current_date = Cst_support.is_keyword K.Kw_current_date

  (** [kw_current_timestamp raw] selects [current_timestamp] keyword *)
  let kw_current_timestamp = Cst_support.is_keyword K.Kw_current_timestamp

  (** [n_expr_name] selects [N_expr_name] node *)
  let n_expr_name = function
    | Raw.Node { kind = N_expr_name; _ } as v -> Some v
    | _ -> None

  (** [n_expr_unary] selects [N_expr_unary] node *)
  let n_expr_unary = function
    | Raw.Node { kind = N_expr_unary; _ } as v -> Some v
    | _ -> None

  (** [n_expr_function] selects [N_expr_function] node *)
  let n_expr_function = function
    | Raw.Node { kind = N_expr_function; _ } as v -> Some v
    | _ -> None

  (** [n_expr_cast] selects [N_expr_cast] node *)
  let n_expr_cast = function
    | Raw.Node { kind = N_expr_cast; _ } as v -> Some v
    | _ -> None

  (** [n_expr_collate] selects [N_expr_collate] node *)
  let n_expr_collate = function
    | Raw.Node { kind = N_expr_collate; _ } as v -> Some v
    | _ -> None

  (** [n_expr_like] selects [N_expr_like] node *)
  let n_expr_like = function
    | Raw.Node { kind = N_expr_like; _ } as v -> Some v
    | _ -> None

  (** [n_expr_in] selects [N_expr_in] node *)
  let n_expr_in = function
    | Raw.Node { kind = N_expr_in; _ } as v -> Some v
    | _ -> None

  (** [n_expr_between] selects [N_expr_between] node *)
  let n_expr_between = function
    | Raw.Node { kind = N_expr_between; _ } as v -> Some v
    | _ -> None

  (** [n_expr_glob] selects [N_expr_glob] node *)
  let n_expr_glob = function
    | Raw.Node { kind = N_expr_glob; _ } as v -> Some v
    | _ -> None

  (** [n_expr_regexp] selects [N_expr_regexp] node *)
  let n_expr_regexp = function
    | Raw.Node { kind = N_expr_regexp; _ } as v -> Some v
    | _ -> None

  (** [n_expr_match] selects [N_expr_match] node *)
  let n_expr_match = function
    | Raw.Node { kind = N_expr_match; _ } as v -> Some v
    | _ -> None

  (** [n_expr_is] selects [N_expr_is] node *)
  let n_expr_is = function
    | Raw.Node { kind = N_expr_is; _ } as v -> Some v
    | _ -> None

  (** [n_expr_exists] selects [N_expr_exists] node *)
  let n_expr_exists = function
    | Raw.Node { kind = N_expr_exists; _ } as v -> Some v
    | _ -> None

  (** [n_expr_case] selects [N_expr_case] node *)
  let n_expr_case = function
    | Raw.Node { kind = N_expr_case; _ } as v -> Some v
    | _ -> None
end

module Expr_name = struct
  module K = Types.Keyword

  (** [t_period raw] selects [period] *)
  let t_period = function
    | Raw.Leaf { kind = L_period; _ } as v -> Some v
    | _ -> None

  (** [t_ident raw] selects [ident] *)
  let t_ident = function
    | Raw.Leaf { kind = L_ident; _ } as v -> Some v
    | _ -> None
end

module Expr_unary = struct
  module K = Types.Keyword

  (** [t_minus raw] selects [minus] *)
  let t_minus = function
    | Raw.Leaf { kind = L_minus; _ } as v -> Some v
    | _ -> None

  (** [t_plus raw] selects [plus] *)
  let t_plus = function
    | Raw.Leaf { kind = L_plus; _ } as v -> Some v
    | _ -> None

  (** [t_tilde raw] selects [tilde] *)
  let t_tilde = function
    | Raw.Leaf { kind = L_tilde; _ } as v -> Some v
    | _ -> None

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [n_expr raw] selects [expr] *)
  let n_expr = function
    | Raw.Node { kind = N_expr; _ } as v -> Some v
    | _ -> None
end
