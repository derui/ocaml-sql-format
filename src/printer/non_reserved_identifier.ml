open Types.Literal
open Types.Ext
open Types.Token
open Intf

module type S = PRINTER with type t = ext non_reserved_identifier

module Make (Basic : GEN with type t = ext basic_non_reserved) : S = struct
  type t = ext non_reserved_identifier

  let print f t ~option =
    match t with
    | Non_reserved_identifier (`basic b, _) ->
      let module Basic = (val Basic.generate ()) in
      Basic.print f b ~option
    | Non_reserved_identifier (`exception', ()) ->
      Printer_token.print f ~option Kw_exception
    | Non_reserved_identifier (`serial, ()) ->
      Printer_token.print f ~option Kw_serial
    | Non_reserved_identifier (`object', ()) ->
      Printer_token.print f ~option Kw_object
    | Non_reserved_identifier (`index, ()) ->
      Printer_token.print f ~option Kw_index
    | Non_reserved_identifier (`json, ()) ->
      Printer_token.print f ~option Kw_json
    | Non_reserved_identifier (`geometry, ()) ->
      Printer_token.print f ~option Kw_geometry
    | Non_reserved_identifier (`geography, ()) ->
      Printer_token.print f ~option Kw_geography
end
