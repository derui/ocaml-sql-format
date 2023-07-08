open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_exclusion

module Make () : S = struct
  type t = ext window_frame_exclusion

  let print f t ~option =
    match t with
    | Window_frame_exclusion (`current_row, _) ->
      Printer_token.print ~option f Kw_exclude;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_current;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_row
    | Window_frame_exclusion (`group, _) ->
      Printer_token.print ~option f Kw_exclude;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_group
    | Window_frame_exclusion (`ties, _) ->
      Printer_token.print ~option f Kw_exclude;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_ties
    | Window_frame_exclusion (`no_others, _) ->
      Printer_token.print ~option f Kw_exclude;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_no;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_others
end
