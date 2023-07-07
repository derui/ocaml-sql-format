open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext table_name

module Make
    (I : GEN with type t = ext identifier)
    (S : GEN with type t = ext schema_name) : S = struct
  type t = ext table_name

  let print f t ~option =
    match t with
    | Table_name (q, i, _) ->
      Option.iter
        (fun q ->
          let module S = (val S.generate ()) in
          (match q with
          | `schema s -> S.print ~option f s
          | `module' -> Printer_token.print ~option f Kw_module);
          Printer_token.print ~option f Tok_period)
        q;

      let module I = (val I.generate ()) in
      I.print ~option f i
end
