open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext rollback_statement

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext rollback_statement

  let print f t ~option =
    match t with
    | Rollback_statement (v, _) ->
      Sfmt.keyword ~option f [ Kw_rollback; Kw_transaction ];

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_to; Kw_savepoint ];
          Fmt.string f " ";
          let module I = (val I.generate ()) in
          I.print ~option f v)
        v
end
