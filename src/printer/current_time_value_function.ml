open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext current_time_value_function

module Make (V : GEN with type t = ext time_precision) : S = struct
  type t = ext current_time_value_function

  let print f t ~option =
    match t with
    | Current_time_value_function (e, _) ->
      Printer_token.print ~option f Kw_current_time;
      Option.iter
        (fun e ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f e)
            f ())
        e
end
