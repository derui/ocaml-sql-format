open Types.Ast
open Types.Token
open Types.Literal
open Intf

module type S = PRINTER with type t = ext interval_type

module Make (V : GEN with type t = ext interval_qualifier) : S = struct
  type t = ext interval_type

  let print f t ~option =
    match t with
    | Interval_type (q, _) ->
      Printer_token.print ~option f Kw_interval;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f q
end
