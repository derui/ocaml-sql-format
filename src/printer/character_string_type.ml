open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext character_string_type

module Make (V : GEN with type t = ext xxx) : S = struct
  type t = ext character_string_type

  let print f t ~option =
    match t with
    | Character_string_type _ -> failwith "TODO: need implementation"
end
