open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext time_interval

module Make () : S = struct
  type t = ext time_interval

  let print f t ~option =
    let kw =
      match t with
      | Time_interval (`frac_second, _) -> Kw_sql_tsi_frac_second
      | Time_interval (`second, _) -> Kw_sql_tsi_second
      | Time_interval (`minute, _) -> Kw_sql_tsi_minute
      | Time_interval (`hour, _) -> Kw_sql_tsi_hour
      | Time_interval (`day, _) -> Kw_sql_tsi_day
      | Time_interval (`week, _) -> Kw_sql_tsi_week
      | Time_interval (`month, _) -> Kw_sql_tsi_month
      | Time_interval (`quarter, _) -> Kw_sql_tsi_quarter
      | Time_interval (`year, _) -> Kw_sql_tsi_year
    in
    Printer_token.print f kw ~option
end
