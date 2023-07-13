open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext multiset_type

module Make (V : GEN with type t = ext data_type) : S = struct
  type t = ext multiset_type

  let print f t ~option =
    match t with
    | Multiset_type (e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_multiset
end
