open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_defn

module Make () : S = struct
  type t = ext window_defn

  let print f t ~option =
    match t with
    | Window_defn _ -> ()
end
