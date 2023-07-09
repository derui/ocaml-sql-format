open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext sequence_column

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext sequence_column

  let print f t ~option =
    match t with
    | Sequence_column _ -> failwith "TODO: need implementation"
end
