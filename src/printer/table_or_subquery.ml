open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_or_subquery

module Make
    (V : GEN with type t = ext schema_name)
    (T : GEN with type t = ext table_name)
    (I : GEN with type t = ext identifier) : S = struct
  type t = ext table_or_subquery

  let print f t ~option =
    match t with
    | Table_or_subquery (`name (sname, tname, alias), _) ->
      Option.iter
        (fun v ->
          let module V = (val V.generate ()) in
          V.print ~option f v;
          Token.print ~option f Tok_period)
        sname;

      let module T = (val T.generate ()) in
      T.print ~option f tname;

      Option.iter
        (fun v ->
          Sfmt.keyword ~option f [ Kw_as ];
          let module I = (val I.generate ()) in
          I.print ~option f v)
        alias
end
