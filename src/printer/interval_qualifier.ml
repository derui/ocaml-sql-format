open Types.Basic
open Types.Token
open Types.Literal
open Types.Ext
open Intf

module type S = PRINTER with type t = ext interval_qualifier

module Make
    (N : GEN with type t = non_second_primary_datetime_field)
    (UI : GEN with type t = ext unsigned_integer) : S = struct
  type t = ext interval_qualifier

  let print f t ~option =
    match t with
    | Interval_qualifier (`single (`primary (d, ui)), _) ->
      let module N = (val N.generate ()) in
      N.print ~option f d;

      Option.iter
        (fun ui ->
          Sfmt.parens ~option
            (fun f _ ->
              let module UI = (val UI.generate ()) in
              UI.print ~option f ui)
            f ())
        ui
    | Interval_qualifier (`single (`second (i, p)), _) ->
      Printer_token.print ~option f Kw_second;
      Option.iter
        (fun i ->
          let module UI = (val UI.generate ()) in
          let fp f _ =
            UI.print ~option f i;

            Option.iter
              (fun p ->
                Sfmt.comma ~option f ();
                UI.print ~option f p)
              p
          in
          Sfmt.parens ~option fp f ())
        i
    | Interval_qualifier (`start_end ((sf, sui), e), _) -> (
      let module N = (val N.generate ()) in
      N.print ~option f sf;

      Option.iter
        (fun ui ->
          Sfmt.parens ~option
            (fun f _ ->
              let module UI = (val UI.generate ()) in
              UI.print ~option f ui)
            f ())
        sui;

      Fmt.string f " ";
      Printer_token.print ~option f Kw_to;
      Fmt.string f " ";

      match e with
      | `primary field -> N.print ~option f field
      | `second ui ->
        Printer_token.print ~option f Kw_second;
        Option.iter
          (fun i ->
            let module UI = (val UI.generate ()) in
            let fp f _ = UI.print ~option f i in
            Sfmt.parens ~option fp f ())
          ui)
end
