open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext result_column

module Make
    (V : GEN with type t = ext table_name)
    (I : GEN with type t = ext identifier)
    (E : GEN with type t = ext expr) : S = struct
  type t = ext result_column

  let print f t ~option =
    match t with
    | Result_column (`asterisk, _) -> Token.print ~option f Op_star
    | Result_column (`expr (e, alias), _) ->
      let module E = (val E.generate ()) in
      E.print ~option f e;
      Option.iter
        (fun v ->
          Sfmt.keyword ~option f [ Kw_as ];
          let module I = (val I.generate ()) in
          I.print ~option f v)
        alias
    | Result_column (`qualified_asterisk name, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f name
end
