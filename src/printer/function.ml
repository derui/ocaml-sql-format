open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext function'

module Make
    (Expr : GEN with type t = ext expression)
    (Data_type : GEN with type t = ext data_type)
    (Time_interval : GEN with type t = ext time_interval)
    (Cve : GEN with type t = ext common_value_expression)
    (Order_by : GEN with type t = ext order_by_clause)
    (Filter : GEN with type t = ext filter_clause)
    (I : GEN with type t = ext identifier)
    (UI : GEN with type t = ext unsigned_integer) : S = struct
  type t = ext function'

  let print_substring f t ~option =
    match t with
    | `substring (e, `from_for (from', for_)) ->
      Printer_token.print f Kw_substring ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_from ~option;
      Fmt.string f " ";
      Expr.print f from' ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print f Kw_for ~option;
          Fmt.string f " ";
          Expr.print f v ~option)
        for_;
      Printer_token.print f Tok_rparen ~option
    | `substring (e, `list l) ->
      Printer_token.print f Kw_substring ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      List.iter
        (fun v ->
          Printer_token.print f Tok_comma ~option;
          Fmt.string f " ";
          Expr.print f v ~option)
        l;
      Printer_token.print f Tok_rparen ~option

  let print_timestamp kw f (ti, e1, e2) ~option =
    let module TI = (val Time_interval.generate ()) in
    Printer_token.print f kw ~option;
    Printer_token.print f Tok_lparen ~option;
    TI.print f ti ~option;
    Printer_token.print f Tok_comma ~option;
    Fmt.string f " ";
    let module Expr = (val Expr.generate ()) in
    Expr.print f e1 ~option;
    Printer_token.print f Tok_comma ~option;
    Fmt.string f " ";
    Expr.print f e2 ~option;
    Printer_token.print f Tok_rparen ~option

  let print_normal_fun kw f t ~option =
    Printer_token.print f kw ~option;
    Printer_token.print f Tok_lparen ~option;
    let module Expr = (val Expr.generate ()) in
    (match t with
    | [] -> ()
    | fst :: rest ->
      Expr.print f fst ~option;
      List.iter
        (fun v ->
          Printer_token.print f Tok_comma ~option;
          Expr.print f v ~option)
        rest);
    Printer_token.print f Tok_rparen ~option

  let print f t ~option =
    match t with
    | Function (`convert (e, d), _) ->
      Printer_token.print f Kw_convert ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Printer_token.print f Tok_comma ~option;
      Fmt.string f " ";
      let module Data_type = (val Data_type.generate ()) in
      Data_type.print f d ~option;
      Printer_token.print f Tok_rparen ~option
    | Function (`cast (e, d), _) ->
      Printer_token.print f Kw_cast ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_as ~option;
      Fmt.string f " ";
      let module Data_type = (val Data_type.generate ()) in
      Data_type.print f d ~option;
      Printer_token.print f Tok_rparen ~option
    | Function ((`substring _ as t), _) -> print_substring f t ~option
    | Function (`extract (e, key), _) ->
      Printer_token.print f Kw_extract ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      let kw =
        match key with
        | `year -> Kw_year
        | `month -> Kw_month
        | `day -> Kw_day
        | `hour -> Kw_hour
        | `minute -> Kw_minute
        | `second -> Kw_second
        | `quarter -> Kw_quarter
        | `epoch -> Kw_epoch
        | `dow -> Kw_dow
        | `doy -> Kw_doy
      in
      Printer_token.print f kw ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_from ~option;
      Fmt.string f " ";
      Expr.print f e ~option;
      Printer_token.print f Tok_rparen ~option
    | Function (`trim (trimmer, e), _) ->
      Printer_token.print f Kw_trim ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Option.iter
        (fun v ->
          (match v with
          | `leading te ->
            Printer_token.print f Kw_leading ~option;
            Option.iter
              (fun v ->
                Fmt.string f " ";
                Expr.print f v ~option)
              te
          | `trailing te ->
            Printer_token.print f Kw_trailing ~option;
            Option.iter
              (fun v ->
                Fmt.string f " ";
                Expr.print f v ~option)
              te
          | `both te ->
            Printer_token.print f Kw_both ~option;
            Option.iter
              (fun v ->
                Fmt.string f " ";
                Expr.print f v ~option)
              te
          | `no_trimmer te -> Expr.print f te ~option);
          Fmt.string f " ";
          Printer_token.print f Kw_from ~option;
          Fmt.string f " ")
        trimmer;
      Expr.print f e ~option;
      Printer_token.print f Tok_rparen ~option
    | Function (`to_chars (e, str, opt), _) ->
      Printer_token.print f Kw_to_chars ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Printer_token.print f Tok_comma ~option;
      Fmt.string f str;

      Option.iter
        (fun v ->
          Printer_token.print f Tok_comma ~option;
          Fmt.string f " ";
          Expr.print f v ~option)
        opt;
      Printer_token.print f Tok_rparen ~option
    | Function (`to_bytes (e, str, opt), _) ->
      Printer_token.print f Kw_to_bytes ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Printer_token.print f Tok_comma ~option;
      Fmt.string f str;

      Option.iter
        (fun v ->
          Printer_token.print f Tok_comma ~option;
          Fmt.string f " ";
          Expr.print f v ~option)
        opt;
      Printer_token.print f Tok_rparen ~option
    | Function (`timestampadd v, _) ->
      print_timestamp Kw_timestampadd f v ~option
    | Function (`timestampdiff v, _) ->
      print_timestamp Kw_timestampdiff f v ~option
    | Function (`left v, _) -> print_normal_fun Kw_left f v ~option
    | Function (`right v, _) -> print_normal_fun Kw_right f v ~option
    | Function (`char v, _) -> print_normal_fun Kw_char f v ~option
    | Function (`user v, _) -> print_normal_fun Kw_user f v ~option
    | Function (`year v, _) -> print_normal_fun Kw_year f v ~option
    | Function (`month v, _) -> print_normal_fun Kw_month f v ~option
    | Function (`hour v, _) -> print_normal_fun Kw_hour f v ~option
    | Function (`minute v, _) -> print_normal_fun Kw_minute f v ~option
    | Function (`second v, _) -> print_normal_fun Kw_second f v ~option
    | Function (`xmlconcat v, _) -> print_normal_fun Kw_xmlconcat f v ~option
    | Function (`xmlcomment v, _) -> print_normal_fun Kw_xmlcomment f v ~option
    | Function (`xmltext v, _) -> print_normal_fun Kw_xmltext f v ~option
    | Function (`insert v, _) -> print_normal_fun Kw_insert f v ~option
    | Function (`translate v, _) -> print_normal_fun Kw_translate f v ~option
    | Function (`position (s, e), _) ->
      Printer_token.print f Kw_position ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Cve = (val Cve.generate ()) in
      Cve.print f s ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_in ~option;
      Fmt.string f " ";
      Cve.print f e ~option;
      Printer_token.print f Tok_rparen ~option
    | Function (`listagg (e, str, order_by), _) ->
      Printer_token.print f Kw_listagg ~option;
      Printer_token.print f Tok_lparen ~option;
      let module Expr = (val Expr.generate ()) in
      Expr.print f e ~option;
      Option.iter
        (fun v ->
          Printer_token.print f Tok_comma ~option;
          Fmt.string f v)
        str;
      Printer_token.print f Tok_rparen ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_within ~option;
      Fmt.string f " ";
      Printer_token.print f Kw_group ~option;
      Fmt.string f " ";
      Printer_token.print f Tok_lparen ~option;
      let module Order_by = (val Order_by.generate ()) in
      Order_by.print f order_by ~option;
      Printer_token.print f Tok_rparen ~option
    | Function (`current_date, _) ->
      Printer_token.print f Kw_current_date ~option;
      Printer_token.print f Tok_lparen ~option;
      Printer_token.print f Tok_rparen ~option
    | Function (`call (ident, qualifier, e, order_by, filter), _) ->
      let module I = (val I.generate ()) in
      I.print f ident ~option;
      Printer_token.print f Tok_lparen ~option;

      Option.iter
        (fun v ->
          let kw =
            match v with
            | `All -> Kw_all
            | `Distinct -> Kw_distinct
          in
          Printer_token.print f kw ~option)
        qualifier;

      (match e with
      | [] -> ()
      | fst :: rest ->
        let module Expr = (val Expr.generate ()) in
        Expr.print f fst ~option;
        List.iter
          (fun e ->
            Printer_token.print f Tok_comma ~option;
            Expr.print f e ~option)
          rest);

      Option.iter
        (fun v ->
          let module Order_by = (val Order_by.generate ()) in
          Fmt.string f " ";
          Order_by.print f v ~option)
        order_by;
      Printer_token.print f Tok_rparen ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module Filter = (val Filter.generate ()) in
          Filter.print f v ~option)
        filter
    | Function (`current_timestamp ui, _) ->
      Printer_token.print f Kw_current_timestamp ~option;
      Option.iter
        (fun v ->
          Printer_token.print f Tok_lparen ~option;
          let module UI = (val UI.generate ()) in
          UI.print f v ~option;
          Printer_token.print f Tok_rparen ~option)
        ui
    | Function (`current_time ui, _) ->
      Printer_token.print f Kw_current_time ~option;
      Option.iter
        (fun v ->
          Printer_token.print f Tok_lparen ~option;
          let module UI = (val UI.generate ()) in
          UI.print f v ~option;
          Printer_token.print f Tok_rparen ~option)
        ui
    | Function (`session_user, _) ->
      Printer_token.print f Kw_session_user ~option
end
