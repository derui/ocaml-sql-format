open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext time_zone_specifier

module Make (V : GEN with type t = ext interval_primary) : S = struct
  type t = ext time_zone_specifier

  let print f t ~option =
    match t with
    | Time_zone_specifier (`local, _) -> Printer_token.print ~option f Kw_local
    | Time_zone_specifier (`time_zone e, _) ->
      Printer_token.print ~option f Kw_time;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_zone;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e
end
