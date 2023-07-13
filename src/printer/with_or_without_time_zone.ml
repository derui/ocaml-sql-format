open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext with_or_without_time_zone

module Make () : S = struct
  type t = ext with_or_without_time_zone

  let print f t ~option =
    match t with
    | With_or_without_time_zone (`with', _) ->
      Printer_token.print ~option f Kw_with;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_time;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_zone
    | With_or_without_time_zone (`without, _) ->
      Printer_token.print ~option f Kw_without;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_time;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_zone
end
