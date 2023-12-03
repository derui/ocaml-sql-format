(** Define a formatter for each kind *)
module M = Monad

module C = Sql_syntax.CST
module Sp = Support

(* formatter entry point *)
let rec format pp options language =
  let module L = Sql_syntax.Language in
  L.walk ~f:(fun r -> M.Run.run (format_sql_stmt_list ()) options pp r |> Option.some) language

and format_sql_stmt_list () =
  let open M.Let_syntax in
  let* () =
    Sp.iter (fun () ->
        let* _ = Sp.node C.Sql_stmt_list.n_sql_stmt format_sql_stmt in
        let* _ = Sp.leaf C.Sql_stmt_list.t_semicolon in
        Sp.cut ())
  in
  Sp.vbox

and format_sql_stmt () =
  let open M.Let_syntax in
  let* () =
    Sp.iter (fun () ->
        let* _ = Sp.keyword ~trailing:Sp.nonbreak C.Sql_stmt.kw_explain in
        let* _ = Sp.keyword ~trailing:Sp.nonbreak C.Sql_stmt.kw_analyze in
        let* _ = Sp.node C.Sql_stmt.n_begin_stmt format_begin_stmt in
        let* _ = Sp.node C.Sql_stmt.n_rollback_stmt format_rollback_stmt in
        let* _ = Sp.node C.Sql_stmt.n_select_stmt format_select_stmt in
        let* _ = Sp.node C.Sql_stmt.n_create_index_stmt format_create_index_stmt in
        M.return ())
  in
  Sp.vbox

and format_begin_stmt () =
  let open M.Let_syntax in
  Sp.iter (fun () ->
      let* _ = Sp.keyword C.Begin_stmt.kw_begin in
      let* _ = Sp.keyword ~leading:Sp.nonbreak C.Begin_stmt.kw_transaction in
      M.return ())

and format_rollback_stmt () =
  let open M.Let_syntax in
  Sp.iter (fun () ->
      let* _ = Sp.keyword C.Rollback_stmt.kw_rollback in
      let* _ = Sp.keyword ~leading:Sp.nonbreak C.Rollback_stmt.kw_transaction in
      M.return ())

and format_select_stmt () = M.return ()

and format_create_index_stmt () = M.return ()
