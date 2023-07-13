open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext reference_type

module Make
    (V : GEN with type t = ext referenced_type)
    (S : GEN with type t = ext scope_clause) : S = struct
  type t = ext reference_type

  let print f t ~option =
    match t with
    | Reference_type (e, s, _) ->
      Printer_token.print ~option f Kw_ref;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ();

      Option.iter
        (fun e ->
          Fmt.string f " ";
          let module S = (val S.generate ()) in
          S.print ~option f e)
        s
end
