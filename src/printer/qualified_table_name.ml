open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext qualified_table_name

module Make
    (V : GEN with type t = ext table_name)
    (S : GEN with type t = ext schema_name) : S = struct
  type t = ext qualified_table_name

  let print f t ~option =
    match t with
    | Qualified_table_name (sname, tname, _) ->
      Option.iter
        (fun v ->
          let module S = (val S.generate ()) in
          S.print ~option f v;
          Token.print ~option f Tok_period)
        sname;

      let module V = (val V.generate ()) in
      V.print ~option f tname
end
