open Types.Ast
open Intf

module type S = PRINTER with type t = ext sql_statement

module Make
    (V : GEN with type t = ext select_statement)
    (U : GEN with type t = ext update_statement)
    (D : GEN with type t = ext delete_statement)
    (I : GEN with type t = ext insert_statement)
    (Savepoint : GEN with type t = ext savepoint_statement)
    (Rollback : GEN with type t = ext rollback_statement)
    (Drop_table : GEN with type t = ext drop_table_statement)
    (Begin : GEN with type t = ext begin_statement) : S = struct
  type t = ext sql_statement

  let print f t ~option =
    match t with
    | Sql_statement (`select v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Sql_statement (`update v, _) ->
      let module U = (val U.generate ()) in
      U.print ~option f v
    | Sql_statement (`delete v, _) ->
      let module D = (val D.generate ()) in
      D.print ~option f v
    | Sql_statement (`insert v, _) ->
      let module I = (val I.generate ()) in
      I.print ~option f v
    | Sql_statement (`savepoint v, _) ->
      let module Savepoint = (val Savepoint.generate ()) in
      Savepoint.print ~option f v
    | Sql_statement (`rollback v, _) ->
      let module Rollback = (val Rollback.generate ()) in
      Rollback.print ~option f v
    | Sql_statement (`drop_table v, _) ->
      let module Drop_table = (val Drop_table.generate ()) in
      Drop_table.print ~option f v
    | Sql_statement (`begin' v, _) ->
      let module Begin = (val Begin.generate ()) in
      Begin.print ~option f v
end
