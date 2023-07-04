open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = non_second_primary_datetime_field

module Make () : S = struct
  type t = non_second_primary_datetime_field

  let print f t ~option =
    let kw =
      match t with
      | `year -> Kw_year
      | `month -> Kw_month
      | `day -> Kw_day
      | `hour -> Kw_hour
      | `minute -> Kw_minute
    in
    Printer_token.print ~option f kw
end
