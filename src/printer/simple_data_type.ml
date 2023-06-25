open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext simple_data_type

module Make (UI : GEN with type t = ext unsigned_integer) : S = struct
  type t = ext simple_data_type

  let print_arg f vf ~option =
    Printer_token.print f Tok_lparen ~option;
    vf ();
    Printer_token.print f Tok_rparen ~option

  let print f t ~option =
    match t with
    | Simple_data_type (`string ui, _) ->
      Printer_token.print f Kw_string ~option;

      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`varchar ui, _) ->
      Printer_token.print f Kw_varchar ~option;

      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`boolean, _) -> Printer_token.print f Kw_boolean ~option
    | Simple_data_type (`byte, _) -> Printer_token.print f Kw_byte ~option
    | Simple_data_type (`tinyint, _) -> Printer_token.print f Kw_tinyint ~option
    | Simple_data_type (`short, _) -> Printer_token.print f Kw_short ~option
    | Simple_data_type (`smallint, _) ->
      Printer_token.print f Kw_smallint ~option
    | Simple_data_type (`char ui, _) ->
      Printer_token.print f Kw_char ~option;

      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`integer, _) -> Printer_token.print f Kw_integer ~option
    | Simple_data_type (`long, _) -> Printer_token.print f Kw_long ~option
    | Simple_data_type (`bigint, _) -> Printer_token.print f Kw_bigint ~option
    | Simple_data_type (`biginteger ui, _) ->
      Printer_token.print f Kw_biginteger ~option;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`float, _) -> Printer_token.print f Kw_float ~option
    | Simple_data_type (`real, _) -> Printer_token.print f Kw_real ~option
    | Simple_data_type (`double, _) -> Printer_token.print f Kw_double ~option
    | Simple_data_type (`bigdecimal (ui, precision), _) ->
      Printer_token.print f Kw_bigdecimal ~option;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          Printer_token.print f Tok_comma ~option;
          print_arg f (fun () -> UI.print f v ~option) ~option)
        precision
    | Simple_data_type (`decimal (ui, precision), _) ->
      Printer_token.print f Kw_decimal ~option;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          Printer_token.print f Tok_comma ~option;
          print_arg f (fun () -> UI.print f v ~option) ~option)
        precision
    | Simple_data_type (`date, _) -> Printer_token.print f Kw_date ~option
    | Simple_data_type (`time, _) -> Printer_token.print f Kw_time ~option
    | Simple_data_type (`timestamp ui, _) ->
      Printer_token.print f Kw_timestamp ~option;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`object' ui, _) ->
      Printer_token.print f Kw_object ~option;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`blob ui, _) ->
      Printer_token.print f Kw_blob ~option;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`clob ui, _) ->
      Printer_token.print f Kw_clob ~option;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`json, _) -> Printer_token.print f Kw_json ~option
    | Simple_data_type (`varbinary ui, _) ->
      Printer_token.print f Kw_varbinary ~option;
      Option.iter
        (fun v ->
          let module UI = (val UI.generate ()) in
          print_arg f (fun () -> UI.print f v ~option) ~option)
        ui
    | Simple_data_type (`geometry, _) ->
      Printer_token.print f Kw_geometry ~option
    | Simple_data_type (`geography, _) ->
      Printer_token.print f Kw_geography ~option
    | Simple_data_type (`xml, _) -> Printer_token.print f Kw_xml ~option
end
