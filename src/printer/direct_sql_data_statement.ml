open Types.Ast
open Intf

module type S = PRINTER with type t = ext direct_sql_data_statement

module Make (V : GEN with type t = ext direct_select_statement) : S = struct
  type t = ext direct_sql_data_statement

  let print f t ~option =
    match t with
    | Direct_sql_data_statement (`select v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
