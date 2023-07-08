open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_definition

module Make
    (I : GEN with type t = ext new_window_name)
    (Spec : GEN with type t = ext window_specification) : S = struct
  type t = ext window_definition

  let print f t ~option =
    match t with
    | Window_definition (i, s, _) ->
      let module I = (val I.generate ()) in
      I.print ~option f i;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_as;
      Fmt.string f " ";
      let module Spec = (val Spec.generate ()) in
      Spec.print ~option f s
end
