open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext with_list_element

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext with_list_element

  let print f t ~option =
    match t with
    | With_list_element _ -> failwith "TODO: need implementation"
end
