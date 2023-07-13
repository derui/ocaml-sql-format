open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext current_timestamp_value_function

module Make (V : GEN with type t = ext timestamp_precision) : S = struct
  type t = ext current_timestamp_value_function

  let print f t ~option =
    match t with
    | Current_timestamp_value_function (e, _) ->
      Printer_token.print ~option f Kw_current_timestamp;
      Option.iter
        (fun e ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f e)
            f ())
        e
end
