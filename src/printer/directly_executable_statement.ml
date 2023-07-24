open Types.Ast
open Intf

module type S = PRINTER with type t = ext directly_executable_statement

module Make (V : GEN with type t = ext direct_sql_data_statement) : S = struct
  type t = ext directly_executable_statement

  let print f t ~option =
    match t with
    | Directly_executable_statement (`data v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
end
