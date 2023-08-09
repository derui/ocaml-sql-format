open Types.Ast
open Intf

module type S = PRINTER with type t = ext column_def

module Make
    (V : GEN with type t = ext column_name)
    (Typ : GEN with type t = ext type_name)
    (Const : GEN with type t = ext column_constraint) : S = struct
  type t = ext column_def

  let print f t ~option =
    match t with
    | Column_def (n, typ, cl, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f n;

      Option.iter
        (fun v ->
          Fmt.string f " ";

          let module Typ = (val Typ.generate ()) in
          Typ.print ~option f v)
        typ;

      let module Const = (val Const.generate ()) in
      List.iter
        (fun v ->
          Fmt.string f " ";
          Const.print ~option f v)
        cl
end
