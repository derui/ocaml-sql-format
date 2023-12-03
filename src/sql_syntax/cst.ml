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

  (** [kw_select raw] selects keyword [select] *)
  let kw_select = Cst_support.is_keyword K.Kw_select

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
