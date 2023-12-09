(** CST in SQL for formatter.

    Each CST is a list of selectors. Each selector has type [Raw.t -> Raw.t option]. And each selector has name prefix
    of target, e.g. [kw_] for keyword, [n_] for node. *)

module Sql_stmt_list = struct
  (** [n_sql_stmt raw] selects [sql_stmt] *)
  let n_sql_stmt = Cst_support.is_node N_sql_stmt

  (** [t_semicolon raw] selects *)
  let t_semicolon = Cst_support.is_leaf L_semicolon
end

(** CST for sql_stmt *)
module Sql_stmt = struct
  module T = Types.Token

  (** [kw_explain raw] selects [explain] *)
  let kw_explain = Cst_support.is_keyword Types.Keyword.Kw_explain

  (** [kw_analyze raw] selects [analyze] *)
  let kw_analyze = Cst_support.is_keyword Types.Keyword.Kw_analyze

  (** [n_select_stmt raw] selects [select_stmt] *)
  let n_select_stmt = Cst_support.is_node N_select_stmt

  (** [n_delete_stmt raw] selects [delete_stmt] *)
  let n_delete_stmt = Cst_support.is_node N_delete_stmt

  (** [n_rollback_stmt raw] selects [rollback_stmt] *)
  let n_rollback_stmt = Cst_support.is_node N_rollback_stmt

  (** [n_begin_stmt raw] selects [begin_stmt] *)
  let n_begin_stmt = Cst_support.is_node N_begin_stmt

  (** [n_commit_stmt raw] selects [commit_stmt] *)
  let n_commit_stmt = Cst_support.is_node N_commit_stmt

  (** [n_create_index_stmt raw] selects [create_index_stmt] *)
  let n_create_index_stmt = Cst_support.is_node N_create_index_stmt
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
  let n_with_clause = Cst_support.is_node N_with_clause

  (** [n_select_core raw] selects [select_core] *)
  let n_select_core = Cst_support.is_node N_select_core
end

(** CST for with_clause *)
module With_clause = struct
  module K = Types.Keyword

  (** [kw_with raw] selects keyword [with] *)
  let kw_with = Cst_support.is_keyword K.Kw_with

  (** [kw_recursive raw] selects keyword [recursive] *)
  let kw_recursive = Cst_support.is_keyword K.Kw_recursive

  (** [t_comma raw] selects keyword [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [n_common_table_expression raw] selects [common_table_expression] *)
  let n_common_table_expression = Cst_support.is_node N_common_table_expression

  (** [n_select_stmt raw] selects [select_stmt] *)
  let n_select_stmt = Cst_support.is_node N_select_stmt
end

(** CST for common_table_expression *)
module Common_table_expression = struct
  module K = Types.Keyword

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen

  (** [n_select_stmt raw] selects [select_stmt] *)
  let n_select_stmt = Cst_support.is_node N_select_stmt

  (** [n_column_name_list raw] selects [column_name_list] *)
  let n_column_name_list = Cst_support.is_node N_column_name_list

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
  let t_comma = Cst_support.is_leaf L_comma

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

(** CST for select_core *)
module Select_core = struct
  module K = Types.Keyword

  (** [n_result_column_list raw] selects [result_column_list] *)
  let n_result_column_list = Cst_support.is_node N_result_column_list

  (** [n_from_clause raw] selects [from_clause] *)
  let n_from_clause = Cst_support.is_node N_from_clause

  (** [n_where_clause raw] selects [where_clause] *)
  let n_where_clause = Cst_support.is_node N_where_clause

  (** [n_group_by_clause raw] selects [group_by_clause] *)
  let n_group_by_clause = Cst_support.is_node N_group_by_clause

  (** [n_having_clause raw] selects [having_clause] *)
  let n_having_clause = Cst_support.is_node N_having_clause

  (** [n_window_clause raw] selects [window_clause] *)
  let n_window_clause = Cst_support.is_node N_window_clause
end

(** CST for result_column_list *)
module Result_column_list = struct
  module K = Types.Keyword

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [n_result_column raw] selects [result_column] *)
  let n_result_column = Cst_support.is_node N_result_column
end

(** CST for result_column *)
module Result_column = struct
  module K = Types.Keyword

  (** [n_alias] selects [result_column_alias] node *)
  let n_alias = Cst_support.is_node N_result_column_alias

  (** [t_star] selects [star] *)
  let t_star = Cst_support.is_leaf L_star

  (** [n_table_name] selects [result_column_table_name] *)
  let n_table_name = Cst_support.is_node N_result_column_table_name
end

(** CST for result_column_alias *)
module Result_column_alias = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] node *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_as raw] selects [as] keyword *)
  let kw_as = Cst_support.is_keyword Kw_as

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

(** CST for result_column_table_name *)
module Result_column_table_name = struct
  module K = Types.Keyword

  (** [t_period raw] selects [period] *)
  let t_period = Cst_support.is_leaf L_period

  (** [t_star raw] selects [star] *)
  let t_star = Cst_support.is_leaf L_star

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

(** CST for type_name *)
module Type_name = struct
  module K = Types.Keyword

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [t_numeric raw] selects [numeric] *)
  let t_numeric = Cst_support.is_leaf L_numeric

  (** [t_plus raw] selects [plus] *)
  let t_plus = Cst_support.is_leaf L_plus

  (** [t_minus raw] selects [minus] *)
  let t_minus = Cst_support.is_leaf L_minus
end

(** CST for filter_clause *)
module Filter_clause = struct
  (** [kw_filter raw] selects [filter] keyword *)
  let kw_filter = Cst_support.is_keyword Kw_filter

  (** [kw_where raw] selects [where] keyword *)
  let kw_where = Cst_support.is_keyword Kw_where

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen
end

(** CST for over_clause *)
module Over_clause = struct
  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [kw_over raw] select [over] keyword *)
  let kw_over = Cst_support.is_keyword Kw_over

  (** [n_window_defn raw] select [window_defn] node *)
  let n_window_defn = Cst_support.is_node N_window_defn
end

(** CST for window_defn *)
module Window_defn = struct
  (** [kw_partition raw] selects [partition] keyword *)
  let kw_partition = Cst_support.is_keyword Kw_partition

  (** [kw_by raw] selects [by] keyword *)
  let kw_by = Cst_support.is_keyword Kw_by

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [n_expr raw] selects [expr] node *)
  let n_expr = Cst_support.is_node N_expr

  (** [n_order_by_clause raw] selects [order_by_clause] node *)
  let n_order_by_clause = Cst_support.is_node N_order_by_clause

  (** [n_frame_spec raw] selects [frame_spec] node *)
  let n_frame_spec = Cst_support.is_node N_frame_spec
end

(** CST for order_by_clause *)
module Order_by_clause = struct
  (** [kw_order raw] selects [order] keyword *)
  let kw_order = Cst_support.is_keyword Kw_order

  (** [kw_by raw] selects [by] keyword *)
  let kw_by = Cst_support.is_keyword Kw_by

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [n_ordering_term raw] selects [ordering_term] node *)
  let n_ordering_term = Cst_support.is_node N_ordering_term
end

(** CST for ordering_term *)
module Ordering_term = struct
  (** [n_expr raw] selects [expr] node *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_asc raw] selects [asc] keyword *)
  let kw_asc = Cst_support.is_keyword Kw_asc

  (** [kw_desc raw] selects [desc] keyword *)
  let kw_desc = Cst_support.is_keyword Kw_desc

  (** [kw_nulls raw] selects [nulls] keyword *)
  let kw_nulls = Cst_support.is_keyword Kw_nulls

  (** [kw_first raw] selects [first] keyword *)
  let kw_first = Cst_support.is_keyword Kw_first

  (** [kw_last raw] selects [last] keyword *)
  let kw_last = Cst_support.is_keyword Kw_last
end

(** CST for frame_spec *)
module Frame_spec = struct
  (** [kw_and raw] selects [and] keyword *)
  let kw_and = Cst_support.is_keyword Kw_and

  (** [kw_rows raw] selects [rows] keyword *)
  let kw_rows = Cst_support.is_keyword Kw_rows

  (** [kw_range raw] selects [range] keyword *)
  let kw_range = Cst_support.is_keyword Kw_range

  (** [kw_between raw] selects [between] keyword *)
  let kw_between = Cst_support.is_keyword Kw_between

  (** [kw_unbounded raw] selects [unbounded] keyword *)
  let kw_unbounded = Cst_support.is_keyword Kw_unbounded

  (** [kw_preceding raw] selects [preceding] keyword *)
  let kw_preceding = Cst_support.is_keyword Kw_preceding

  (** [kw_following raw] selects [following] keyword *)
  let kw_following = Cst_support.is_keyword Kw_following

  (** [kw_current raw] selects [current] keyword *)
  let kw_current = Cst_support.is_keyword Kw_current

  (** [kw_row raw] selects [row] keyword *)
  let kw_row = Cst_support.is_keyword Kw_row

  (** [kw_groups raw] selects [groups] keyword *)
  let kw_groups = Cst_support.is_keyword Kw_groups

  (** [kw_no raw] selects [no] keyword *)
  let kw_no = Cst_support.is_keyword Kw_no

  (** [kw_others raw] selects [others] keyword *)
  let kw_others = Cst_support.is_keyword Kw_others

  (** [kw_ties raw] selects [ties] keyword *)
  let kw_ties = Cst_support.is_keyword Kw_ties

  (** [kw_group raw] selects [group] keyword *)
  let kw_group = Cst_support.is_keyword Kw_group

  (** [kw_exclude raw] selects [exclude] keyword *)
  let kw_exclude = Cst_support.is_keyword Kw_exclude

  (** [n_expr raw] selects [expr] node *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for expr *)
module Expr = struct
  module K = Types.Keyword

  (** [t_qmark raw] selects [qmark] *)
  let t_qmark = Cst_support.is_leaf L_qmark

  (** [t_string raw] selects [Tok_string] *)
  let t_string = Cst_support.is_leaf L_string

  (** [t_numeric raw] selects [Tok_numeric] *)
  let t_numeric = Cst_support.is_leaf L_numeric

  (** [t_blob raw] selects [Tok_blob] *)
  let t_blob = Cst_support.is_leaf L_blob

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
  let n_expr_name = Cst_support.is_node N_expr_name

  (** [n_expr_unary] selects [N_expr_unary] node *)
  let n_expr_unary = Cst_support.is_node N_expr_unary

  (** [n_expr_function] selects [N_expr_function] node *)
  let n_expr_function = Cst_support.is_node N_expr_function

  (** [n_expr_cast] selects [N_expr_cast] node *)
  let n_expr_cast = Cst_support.is_node N_expr_cast

  (** [n_expr_collate] selects [N_expr_collate] node *)
  let n_expr_collate = Cst_support.is_node N_expr_collate

  (** [n_expr_like] selects [N_expr_like] node *)
  let n_expr_like = Cst_support.is_node N_expr_like

  (** [n_expr_in] selects [N_expr_in] node *)
  let n_expr_in = Cst_support.is_node N_expr_in

  (** [n_expr_between] selects [N_expr_between] node *)
  let n_expr_between = Cst_support.is_node N_expr_between

  (** [n_expr_glob] selects [N_expr_glob] node *)
  let n_expr_glob = Cst_support.is_node N_expr_glob

  (** [n_expr_regexp] selects [N_expr_regexp] node *)
  let n_expr_regexp = Cst_support.is_node N_expr_regexp

  (** [n_expr_match] selects [N_expr_match] node *)
  let n_expr_match = Cst_support.is_node N_expr_match

  (** [n_expr_is] selects [N_expr_is] node *)
  let n_expr_is = Cst_support.is_node N_expr_is

  (** [n_expr_exists] selects [N_expr_exists] node *)
  let n_expr_exists = Cst_support.is_node N_expr_exists

  (** [n_expr_case] selects [N_expr_case] node *)
  let n_expr_case = Cst_support.is_node N_expr_case
end

module Expr_name = struct
  module K = Types.Keyword

  (** [t_period raw] selects [period] *)
  let t_period = Cst_support.is_leaf L_period

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

module Expr_unary = struct
  module K = Types.Keyword

  (** [t_minus raw] selects [minus] *)
  let t_minus = Cst_support.is_leaf L_minus

  (** [t_plus raw] selects [plus] *)
  let t_plus = Cst_support.is_leaf L_plus

  (** [t_tilde raw] selects [tilde] *)
  let t_tilde = Cst_support.is_leaf L_tilde

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for expr_cast *)
module Expr_cast = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_as raw] selects [as] *)
  let kw_as = Cst_support.is_keyword Kw_as

  (** [kw_cast raw] selects [cast] *)
  let kw_cast = Cst_support.is_keyword Kw_cast

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen

  (** [n_type_name raw] selects [type_name] *)
  let n_type_name = Cst_support.is_node N_type_name
end

(** CST for expr_function *)
module Expr_function = struct
  module K = Types.Keyword

  (** [kw_distinct raw] selects [distinct] *)
  let kw_distinct = Cst_support.is_keyword Kw_distinct

  (** [t_star raw] selects [star] *)
  let t_star = Cst_support.is_leaf L_star

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [t_period raw] selects [period] *)
  let t_period = Cst_support.is_leaf L_period

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [n_order_by_clause raw] selects [order_by_clause] *)
  let n_order_by_clause = Cst_support.is_node N_order_by_clause

  (** [n_filter_clause raw] selects [filter_clause] *)
  let n_filter_clause = Cst_support.is_node N_filter_clause

  (** [n_over_clause raw] selects [over_clause] *)
  let n_over_clause = Cst_support.is_node N_over_clause
end

(** CST for expr_collate *)
module Expr_collate = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_collate raw] selects [collate] *)
  let kw_collate = Cst_support.is_keyword Kw_collate

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

(** CST for expr_like *)
module Expr_like = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_like raw] selects [like] *)
  let kw_like = Cst_support.is_keyword Kw_like

  (** [kw_escape raw] selects [escape] *)
  let kw_escape = Cst_support.is_keyword Kw_escape
end

(** CST for expr_glob *)
module Expr_glob = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_glob raw] selects [glob] *)
  let kw_glob = Cst_support.is_keyword Kw_glob
end

(** CST for expr_in *)
module Expr_in = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_in raw] selects [in] *)
  let kw_in = Cst_support.is_keyword Kw_in

  let t_lparen = Cst_support.is_leaf L_lparen

  let t_rparen = Cst_support.is_leaf L_rparen

  let t_comma = Cst_support.is_leaf L_comma

  let t_period = Cst_support.is_leaf L_period

  let t_ident = Cst_support.is_leaf L_ident

  let n_select_stmt = Cst_support.is_node N_select_stmt
end

(** CST for expr_between *)
module Expr_between = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_between raw] selects [between] *)
  let kw_between = Cst_support.is_keyword Kw_between

  (** [kw_and raw] selects [and] *)
  let kw_and = Cst_support.is_keyword Kw_and
end

(** CST for expr_regexp *)
module Expr_regexp = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_regexp raw] selects [regexp] *)
  let kw_regexp = Cst_support.is_keyword Kw_regexp
end

(** CST for expr_match *)
module Expr_match = struct
  module K = Types.Keyword

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_match raw] selects [match] *)
  let kw_match = Cst_support.is_keyword Kw_match
end

(** CST for expr_is *)
