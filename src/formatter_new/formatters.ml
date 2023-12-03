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
  let open M in
  return ()
