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
  let kw_explain = Cst_support.is_keyword Kw_explain

  (** [kw_analyze raw] selects [analyze] *)
  let kw_analyze = Cst_support.is_keyword Kw_analyze

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
  (** [kw_begin raw] selects keyword [begin] *)
  let kw_begin = Cst_support.is_keyword Kw_begin

  (** [kw_transaction raw] selects keyword [transaction] *)
  let kw_transaction = Cst_support.is_keyword Kw_transaction
end

(** CST for rollback_stmt *)
module Rollback_stmt = struct
  (** [kw_rollback raw] selects keyword [rollback] *)
  let kw_rollback = Cst_support.is_keyword Kw_rollback

  (** [kw_transaction raw] selects keyword [transaction] *)
  let kw_transaction = Cst_support.is_keyword Kw_transaction
end

(** CST for select_stmt *)
module Select_stmt = struct
  (** [kw_distinct raw] selects keyword [distinct] *)
  let kw_distinct = Cst_support.is_keyword Kw_distinct

  (** [kw_union raw] selects keyword [union] *)
  let kw_union = Cst_support.is_keyword Kw_union

  (** [kw_all raw] selects keyword [all] *)
  let kw_all = Cst_support.is_keyword Kw_all

  (** [kw_intersect raw] selects keyword [intersect] *)
  let kw_intersect = Cst_support.is_keyword Kw_intersect

  (** [kw_except raw] selects keyword [except] *)
  let kw_except = Cst_support.is_keyword Kw_except

  (** [n_with_clause raw] selects [with_clause] *)
  let n_with_clause = Cst_support.is_node N_with_clause

  (** [n_select_core raw] selects [select_core] *)
  let n_select_core = Cst_support.is_node N_select_core
end

(** CST for with_clause *)
module With_clause = struct
  (** [kw_with raw] selects keyword [with] *)
  let kw_with = Cst_support.is_keyword Kw_with

  (** [kw_recursive raw] selects keyword [recursive] *)
  let kw_recursive = Cst_support.is_keyword Kw_recursive

  (** [t_comma raw] selects keyword [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [n_common_table_expression raw] selects [common_table_expression] *)
  let n_common_table_expression = Cst_support.is_node N_common_table_expression
end

(** CST for common_table_expression *)
module Common_table_expression = struct
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
  let kw_as = Cst_support.is_keyword Kw_as

  (** [kw_not raw] selects [not] keyword *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_materialized raw] selects [materialized] keyword *)
  let kw_materialized = Cst_support.is_keyword Kw_materialized
end

(** CST for column_name_list *)
module Column_name_list = struct
  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

(** CST for select_core *)
module Select_core = struct
  (** [kw_select raw] selects [select] keyword *)
  let kw_select = Cst_support.is_keyword Kw_select

  (** [kw_distinct raw] selects [distinct] keyword *)
  let kw_distinct = Cst_support.is_keyword Kw_distinct

  (** [kw_all raw] selects [all] keyword *)
  let kw_all = Cst_support.is_keyword Kw_all

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
  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [n_result_column raw] selects [result_column] *)
  let n_result_column = Cst_support.is_node N_result_column
end

(** CST for result_column *)
module Result_column = struct
  (** [n_alias] selects [result_column_alias] node *)
  let n_alias = Cst_support.is_node N_result_column_alias

  (** [t_star] selects [star] *)
  let t_star = Cst_support.is_leaf L_star

  (** [n_table_name] selects [result_column_table_name] *)
  let n_table_name = Cst_support.is_node N_result_column_table_name
end

(** CST for result_column_alias *)
module Result_column_alias = struct
  (** [n_expr raw] selects [expr] node *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_as raw] selects [as] keyword *)
  let kw_as = Cst_support.is_keyword Kw_as

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

(** CST for result_column_table_name *)
module Result_column_table_name = struct
  (** [t_period raw] selects [period] *)
  let t_period = Cst_support.is_leaf L_period

  (** [t_star raw] selects [star] *)
  let t_star = Cst_support.is_leaf L_star

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

(** CST for type_name *)
module Type_name = struct
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

(** CST for expr_literal *)
module Expr_literal = struct
  (** [t_string raw] selects [string] *)
  let t_string = Cst_support.is_leaf L_string

  (** [t_numeric raw] selects [numeric] *)
  let t_numeric = Cst_support.is_leaf L_numeric

  (** [t_blob raw] selects [blob] *)
  let t_blob = Cst_support.is_leaf L_blob

  (** [kw_null raw] selects [null] keyword *)
  let kw_null = Cst_support.is_keyword Kw_null

  (** [kw_true raw] selects [true] keyword *)
  let kw_true = Cst_support.is_keyword Kw_true

  (** [kw_false raw] selects [false] keyword *)
  let kw_false = Cst_support.is_keyword Kw_false

  (** [kw_current_time raw] selects [current_time] keyword *)
  let kw_current_time = Cst_support.is_keyword Kw_current_time

  (** [kw_current_date raw] selects [current_date] keyword *)
  let kw_current_date = Cst_support.is_keyword Kw_current_date

  (** [kw_current_timestamp raw] selects [current_timestamp] keyword *)
  let kw_current_timestamp = Cst_support.is_keyword Kw_current_timestamp
end

module Expr_bind_parameter = struct
  (** [t_qmark raw] selects [qmark] *)
  let t_qmark = Cst_support.is_leaf L_qmark
end

(** CST for expr *)
module Expr = struct
  (** [n_bind_parameter raw] selects [bind_parameter] *)
  let n_bind_parameter = Cst_support.is_node N_expr_bind_parameter

  (** [n_expr_literal] selects [N_expr_literal] node *)
  let n_expr_literal = Cst_support.is_node N_expr_literal

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

  (** [n_expr_logical_op] selects [N_expr_logical_op] node *)
  let n_expr_logical_op = Cst_support.is_node N_expr_logical_op

  (** [n_expr_binary_op] selects [N_expr_binary_op] node *)
  let n_expr_binary_op = Cst_support.is_node N_expr_binary_op
end

(** CST for expr_logical_op *)
module Expr_logical_op = struct
  (** [kw_and raw] selects [and] keyword *)
  let kw_and = Cst_support.is_keyword Kw_and

  (** [kw_or raw] selects [or] keyword *)
  let kw_or = Cst_support.is_keyword Kw_or

  (** [kw_not raw] selects [not] keyword *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [n_expr raw] selects [expr] node *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for expr_binary_op *)
module Expr_binary_op = struct
  (** [n_expr] selects [expr] node *)
  let n_expr = Cst_support.is_node N_expr

  (** [t_extract] selects [extract] *)
  let t_extract = Cst_support.is_leaf L_extract

  (** [t_extract_2] selects [extract_2] *)
  let t_extract_2 = Cst_support.is_leaf L_extract_2

  (** [t_concat] selects [concat] *)
  let t_concat = Cst_support.is_leaf L_concat

  (** [t_plus raw] selects [plus] *)
  let t_plus = Cst_support.is_leaf L_plus

  (** [t_minus raw] selects [minus] *)
  let t_minus = Cst_support.is_leaf L_minus

  (** [t_star raw] selects [star] *)
  let t_star = Cst_support.is_leaf L_star

  (** [t_slash raw] selects [slash] *)
  let t_slash = Cst_support.is_leaf L_slash

  (** [t_modulo raw] selects [modulo] *)
  let t_modulo = Cst_support.is_leaf L_modulo

  (** [t_lt raw] selects [lt] *)
  let t_lt = Cst_support.is_leaf L_lt

  (** [t_gt raw] selects [gt] *)
  let t_gt = Cst_support.is_leaf L_gt

  (** [t_le raw] selects [le] *)
  let t_le = Cst_support.is_leaf L_le

  (** [t_ge raw] selects [ge] *)
  let t_ge = Cst_support.is_leaf L_ge

  (** [t_eq raw] selects [eq] *)
  let t_eq = Cst_support.is_leaf L_eq

  (** [t_eq2 raw] selects [eq2] *)
  let t_eq2 = Cst_support.is_leaf L_eq2

  (** [t_ne raw] selects [ne] *)
  let t_ne = Cst_support.is_leaf L_ne

  (** [t_ne2 raw] selects [ne2] *)
  let t_ne2 = Cst_support.is_leaf L_ne2

  (** [t_amp raw] selects [amp] *)
  let t_amp = Cst_support.is_leaf L_amp

  (** [t_pipe raw] selects [pipe] *)
  let t_pipe = Cst_support.is_leaf L_pipe

  (** [t_lshift raw] selects [lshift] *)
  let t_lshift = Cst_support.is_leaf L_lshift

  (** [t_rshift raw] selects [rshift] *)
  let t_rshift = Cst_support.is_leaf L_rshift
end

module Expr_name = struct
  (** [t_period raw] selects [period] *)
  let t_period = Cst_support.is_leaf L_period

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

module Expr_unary = struct
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

  (* built-in function keywords *)

  (** [kw_count raw] selects [count] *)
  let kw_count = Cst_support.is_keyword Kw_count

  (** [kw_avg raw] selects [avg] *)
  let kw_avg = Cst_support.is_keyword Kw_avg

  (** [kw_min raw] selects [min] *)
  let kw_min = Cst_support.is_keyword Kw_min

  (** [kw_max raw] selects [max] *)
  let kw_max = Cst_support.is_keyword Kw_max

  (** [kw_sum raw] selects [sum] *)
  let kw_sum = Cst_support.is_keyword Kw_sum

  (** [kw_every raw] selects [every] *)
  let kw_every = Cst_support.is_keyword Kw_every

  (** [kw_some raw] selects [some] *)
  let kw_some = Cst_support.is_keyword Kw_some

  (** [kw_any raw] selects [any] *)
  let kw_any = Cst_support.is_keyword Kw_any
end

(** CST for expr_collate *)
module Expr_collate = struct
  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_collate raw] selects [collate] *)
  let kw_collate = Cst_support.is_keyword Kw_collate

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident
end

(** CST for expr_like *)
module Expr_like = struct
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
  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_glob raw] selects [glob] *)
  let kw_glob = Cst_support.is_keyword Kw_glob
end

(** CST for expr_in *)
module Expr_in = struct
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
  (** [n_expr_between_predicand raw] selects [expr_between_predicand] *)
  let n_expr_between_predicand = Cst_support.is_node N_expr_between_predicand

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_between raw] selects [between] *)
  let kw_between = Cst_support.is_keyword Kw_between

  (** [kw_and raw] selects [and] *)
  let kw_and = Cst_support.is_keyword Kw_and
end

(** CST for expr_between_predicand *)
module Expr_between_predicand = struct
  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for expr_regexp *)
module Expr_regexp = struct
  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_regexp raw] selects [regexp] *)
  let kw_regexp = Cst_support.is_keyword Kw_regexp
end

(** CST for expr_match *)
module Expr_match = struct
  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_match raw] selects [match] *)
  let kw_match = Cst_support.is_keyword Kw_match
end

(** CST for expr_is *)
module Expr_is = struct
  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_is raw] selects [is] *)
  let kw_is = Cst_support.is_keyword Kw_is

  (** [kw_distinct raw] selects [distinct] *)
  let kw_distinct = Cst_support.is_keyword Kw_distinct

  (** [kw_from raw] selects [from] *)
  let kw_from = Cst_support.is_keyword Kw_from

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for expr_exists *)
module Expr_exists = struct
  (** [kw_not raw] selects [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_exists raw] selects [exists] *)
  let kw_exists = Cst_support.is_keyword Kw_exists

  (** [n_select_stmt raw] selects [select_stmt] *)
  let n_select_stmt = Cst_support.is_node N_select_stmt

  (** [t_lparen] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen
end

(** CST for expr_case *)
module Expr_case = struct
  (** [kw_end raw] selects [end] *)
  let kw_end = Cst_support.is_keyword Kw_end

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [n_expr_case_when raw] selects [expr_case_when] *)
  let n_expr_case_when = Cst_support.is_node N_expr_case_when

  (** [n_expr_case_case raw] selects [expr_case_case] *)
  let n_expr_case_case = Cst_support.is_node N_expr_case_case

  (** [n_expr_case_else raw] selects [expr_case_else] *)
  let n_expr_case_else = Cst_support.is_node N_expr_case_else
end

(** CST for expr_case_when *)
module Expr_case_when = struct
  (** [kw_when raw] selects [when] *)
  let kw_when = Cst_support.is_keyword Kw_when

  (** [kw_then raw] selects [then] *)
  let kw_then = Cst_support.is_keyword Kw_then

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for expr_case_case *)
module Expr_case_case = struct
  (** [kw_case raw] selects [case] *)
  let kw_case = Cst_support.is_keyword Kw_case

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for expr_case_else *)
module Expr_case_else = struct
  (** [kw_else raw] selects [else] *)
  let kw_else = Cst_support.is_keyword Kw_else

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for where_clause *)
module Where_clause = struct
  (** [kw_where raw] selects [where] *)
  let kw_where = Cst_support.is_keyword Kw_where

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for group_by_clause *)
module Group_by_clause = struct
  (** [kw_group raw] selects [group] *)
  let kw_group = Cst_support.is_keyword Kw_group

  (** [kw_by raw] selects [by] *)
  let kw_by = Cst_support.is_keyword Kw_by

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for having_clause *)
module Having_clause = struct
  (** [kw_having raw] selects [having] *)
  let kw_having = Cst_support.is_keyword Kw_having

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for from_clause *)
module From_clause = struct
  (** [kw_from raw] selects [from] *)
  let kw_from = Cst_support.is_keyword Kw_from

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [n_table_or_subquery raw] selects [table_or_subquery] *)
  let n_table_or_subquery = Cst_support.is_node N_table_or_subquery

  (** [n_join_clause raw] selects [join_clause] *)
  let n_join_clause = Cst_support.is_node N_join_clause
end

(** CST for table_or_subquery *)
module Table_or_subquery = struct
  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen

  (** [n_table_name raw] selects [table_name] *)
  let n_table_name = Cst_support.is_node N_table_or_subquery_table_name

  (** [n_table_function raw] selects [table_function] *)
  let n_table_function = Cst_support.is_node N_table_or_subquery_table_function

  (** [n_join_clause raw] selects [join_clause] *)
  let n_join_clause = Cst_support.is_node N_join_clause
end

(** CST for table_or_subquery_table_name *)
module Table_or_subquery_table_name = struct
  (** [t_period raw] selects [period] *)
  let t_period = Cst_support.is_leaf L_period

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [kw_as raw] selects [as] keyword *)
  let kw_as = Cst_support.is_keyword Kw_as
end

(** CST for table_or_subquery_table_function *)
module Table_or_subquery_table_function = struct
  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr

  (** [kw_as raw] selects [as] keyword *)
  let kw_as = Cst_support.is_keyword Kw_as
end

(** CST for join_clause *)
module Join_clause = struct
  (** [n_table_or_subquery raw] selects [table_or_subquery] *)
  let n_table_or_subquery = Cst_support.is_node N_table_or_subquery

  (** [n_join_constraint raw] selects [join_constraint] *)
  let n_join_constraint = Cst_support.is_node N_join_constraint

  (** [n_join_operator raw] selects [join_operator] *)
  let n_join_operator = Cst_support.is_node N_join_operator
end

(** CST for join_constraint *)
module Join_constraint = struct
  (** [kw_on raw] selects [on] *)
  let kw_on = Cst_support.is_keyword Kw_on

  (** [kw_using raw] selects [using] *)
  let kw_using = Cst_support.is_keyword Kw_using

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [t_ident raw] selects [ident] *)
  let t_ident = Cst_support.is_leaf L_ident

  (** [n_expr raw] selects [expr] *)
  let n_expr = Cst_support.is_node N_expr
end

(** CST for join_operator *)
module Join_operator = struct
  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [kw_join raw] selects [join] *)
  let kw_join = Cst_support.is_keyword Kw_join

  (** [kw_natural raw] selects [natural] *)
  let kw_natural = Cst_support.is_keyword Kw_natural

  (** [kw_left raw] selects [left] *)
  let kw_left = Cst_support.is_keyword Kw_left

  (** [kw_right raw] selects [right] *)
  let kw_right = Cst_support.is_keyword Kw_right

  (** [kw_full raw] selects [full] *)
  let kw_full = Cst_support.is_keyword Kw_full

  (** [kw_outer raw] selects [outer] *)
  let kw_outer = Cst_support.is_keyword Kw_outer

  (** [kw_cross raw] selects [cross] *)
  let kw_cross = Cst_support.is_keyword Kw_cross

  (** [kw_inner raw] selects [inner] *)
  let kw_inner = Cst_support.is_keyword Kw_inner
end

(** CST for create_index_stmt *)
module Create_index_stmt = struct
  (** [kw_create raw] selects keyword [create] *)
  let kw_create = Cst_support.is_keyword Kw_create

  (** [kw_index raw] selects keyword [index] *)
  let kw_index = Cst_support.is_keyword Kw_index

  (** [kw_if raw] selects keyword [if] *)
  let kw_if = Cst_support.is_keyword Kw_if

  (** [kw_not raw] selects keyword [not] *)
  let kw_not = Cst_support.is_keyword Kw_not

  (** [kw_exists raw] selects [exists] keyword *)
  let kw_exists = Cst_support.is_keyword Kw_exists

  (** [kw_unique raw] selects [unique] keyword *)
  let kw_unique = Cst_support.is_keyword Kw_unique

  (** [kw_on raw] selects [on] keyword *)
  let kw_on = Cst_support.is_keyword Kw_on

  (** [t_lparen raw] selects [lparen] *)
  let t_lparen = Cst_support.is_leaf L_lparen

  (** [t_rparen raw] selects [rparen] *)
  let t_rparen = Cst_support.is_leaf L_rparen

  (** [t_comma raw] selects [comma] *)
  let t_comma = Cst_support.is_leaf L_comma

  (** [n_indexed_column raw] selects [indexed_column] *)
  let n_indexed_column = Cst_support.is_node N_indexed_column

  (** [n_where_clause raw] selects [where_clause] *)
  let n_where_clause = Cst_support.is_node N_where_clause
end
