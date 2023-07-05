open Types.Literal
open Types.Ext
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_literal

module Make () : S = struct
  type t = ext boolean_literal

  let print f t ~option =
    match t with
    | Boolean_literal (v, _) ->
      let kw =
        match v with
        | `true' -> Kw_true
        | `false' -> Kw_false
        | `unknown -> Kw_unknown
      in
      Printer_token.print ~option f kw
end
