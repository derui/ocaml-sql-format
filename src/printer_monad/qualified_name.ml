open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext qualified_name

module Make
    (V : GEN with type t = ext schema_name)
    (T : GEN with type t = ext table_name)
    (C : GEN with type t = ext column_name) : S = struct
  type t = ext qualified_name

  let print f t ~option =
    match t with
    | Qualified_name (sname, tname, cname, _) ->
      Option.iter
        (fun v ->
          let module V = (val V.generate ()) in
          V.print ~option f v;
          Token.print ~option f Tok_period)
        sname;
      Option.iter
        (fun v ->
          let module T = (val T.generate ()) in
          T.print ~option f v;
          Token.print ~option f Tok_period)
        tname;

      let module C = (val C.generate ()) in
      C.print ~option f cname
end
