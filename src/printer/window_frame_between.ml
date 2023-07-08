open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_between

module Make
    (B1 : GEN with type t = ext window_frame_bound_1)
    (B2 : GEN with type t = ext window_frame_bound_2) : S = struct
  type t = ext window_frame_between

  let print f t ~option =
    match t with
    | Window_frame_between (b1, b2, _) ->
      Printer_token.print ~option f Kw_between;
      Fmt.string f " ";
      let module B1 = (val B1.generate ()) in
      B1.print ~option f b1;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_and;
      Fmt.string f " ";
      let module B2 = (val B2.generate ()) in
      B2.print ~option f b2
end
