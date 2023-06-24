open Types.Ast
open Intf

module type S = PRINTER with type t = ext expression

module Make (C : GEN with type t = ext condition) : S = struct
  type t = ext expression

  let print f t ~option =
    match t with
    | Expression (exp, _) ->
      let module C = (val C.generate ()) in
      C.print f exp ~option
end
