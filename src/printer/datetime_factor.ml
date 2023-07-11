open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext datetime_factor

module Make
    (V : GEN with type t = ext datetime_primary)
    (TZ : GEN with type t = ext time_zone_specifier) : S = struct
  type t = ext datetime_factor

  let print f t ~option =
    match t with
    | Datetime_factor (e, tz, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;

      Option.iter
        (fun tz ->
          Fmt.string f " ";
          let module TZ = (val TZ.generate ()) in
          TZ.print ~option f tz)
        tz
end
