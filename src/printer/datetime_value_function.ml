open Types.Ast
open Intf

module type S = PRINTER with type t = ext datetime_value_function

module Make
    (V : GEN with type t = ext current_date_value_function)
    (Time : GEN with type t = ext current_time_value_function)
    (LTime : GEN with type t = ext current_local_time_value_function)
    (Timestamp : GEN with type t = ext current_timestamp_value_function)
    (LTimestamp : GEN with type t = ext current_local_timestamp_value_function) :
  S = struct
  type t = ext datetime_value_function

  let print f t ~option =
    match t with
    | Datetime_value_function (`date e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Datetime_value_function (`time e, _) ->
      let module Time = (val Time.generate ()) in
      Time.print ~option f e
    | Datetime_value_function (`local_time e, _) ->
      let module LTime = (val LTime.generate ()) in
      LTime.print ~option f e
    | Datetime_value_function (`timestamp e, _) ->
      let module Timestamp = (val Timestamp.generate ()) in
      Timestamp.print ~option f e
    | Datetime_value_function (`local_timestamp e, _) ->
      let module LTimestamp = (val LTimestamp.generate ()) in
      LTimestamp.print ~option f e
end
