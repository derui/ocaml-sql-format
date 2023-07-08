open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_frame_following

module Make (C : GEN with type t = ext unsigned_value_specification) : S =
struct
  type t = ext window_frame_following

  let print f t ~option =
    match t with
    | Window_frame_following (v, _) ->
      let module C = (val C.generate ()) in
      C.print ~option f v;
      Fmt.string f " ";
      Printer_token.print ~option f Kw_following
end
