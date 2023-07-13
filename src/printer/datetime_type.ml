open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext datetime_type

module Make
    (V : GEN with type t = ext time_precision)
    (T : GEN with type t = ext timestamp_precision)
    (W : GEN with type t = ext with_or_without_time_zone) : S = struct
  type t = ext datetime_type

  let print f t ~option =
    match t with
    | Datetime_type (`date, _) -> Printer_token.print ~option f Kw_date
    | Datetime_type (`time (e, w), _) ->
      Printer_token.print ~option f Kw_time;
      Option.iter
        (fun e ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f e)
            f ())
        e;
      Option.iter
        (fun w ->
          let module W = (val W.generate ()) in
          W.print ~option f w)
        w
    | Datetime_type (`timestamp (e, w), _) ->
      Printer_token.print ~option f Kw_timestamp;
      Option.iter
        (fun e ->
          Sfmt.parens ~option
            (fun f _ ->
              let module T = (val T.generate ()) in
              T.print ~option f e)
            f ())
        e;
      Option.iter
        (fun w ->
          let module W = (val W.generate ()) in
          W.print ~option f w)
        w
end
