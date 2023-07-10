open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_function

module Make
    (V : GEN with type t = ext window_function_type)
    (NS : GEN with type t = ext window_name_or_specification) : S = struct
  type t = ext window_function

  let print f t ~option =
    match t with
    | Window_function (typ, ns, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f typ;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_over;
      Fmt.string f " ";
      let module NS = (val NS.generate ()) in
      NS.print ~option f ns
end
