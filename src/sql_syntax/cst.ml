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
