open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_clause

module Make (Def : GEN with type t = ext window_definition_list) : S = struct
  type t = ext window_clause

  let print f t ~option =
    match t with
    | Window_clause (list, _) ->
      Printer_token.print ~option f Kw_window;
      Fmt.string f " ";
      let module Def = (val Def.generate ()) in
      Def.print ~option f list
end
