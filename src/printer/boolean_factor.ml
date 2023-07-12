open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_factor

module Make (V : GEN with type t = ext boolean_test) : S = struct
  type t = ext boolean_factor

  let print f t ~option =
    match t with
    | Boolean_factor (not', e, _) ->
      Option.iter
        (fun _ ->
          Printer_token.print ~option f Kw_not;
          Fmt.string f " ")
        not';

      let module V = (val V.generate ()) in
      V.print ~option f e
end
