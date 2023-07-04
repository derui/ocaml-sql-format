open Types.Ast
open Intf

module type S = PRINTER with type t = ext datetime_literal

module Make
    (D : GEN with type t = ext date_literal)
    (T : GEN with type t = ext time_literal)
    (TS : GEN with type t = ext timestamp_literal) : S = struct
  type t = ext datetime_literal

  let print f t ~option =
    match t with
    | Datetime_literal (`date d, _) ->
      let module D = (val D.generate ()) in
      D.print ~option f d
    | Datetime_literal (`time d, _) ->
      let module T = (val T.generate ()) in
      T.print ~option f d
    | Datetime_literal (`timestamp d, _) ->
      let module TS = (val TS.generate ()) in
      TS.print ~option f d
end
