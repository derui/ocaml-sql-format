open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext savepoint_statement

module Make (V : GEN with type t = ext identifier) : S = struct
  type t = ext savepoint_statement

  let print f t ~option =
    match t with
    | Savepoint_statement (v, _) ->
      Sfmt.keyword ~option f [ Kw_savepoint ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f v
end
