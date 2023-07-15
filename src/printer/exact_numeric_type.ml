open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext exact_numeric_type

module Make
    (V : GEN with type t = ext precision)
    (S : GEN with type t = ext scale) : S = struct
  type t = ext exact_numeric_type

  let print f t ~option =
    match t with
    | Exact_numeric_type (`numeric v, _) ->
      Printer_token.print ~option f Kw_numeric;

      Option.iter
        (fun (v, s) ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f v;

              Option.iter
                (fun s ->
                  Sfmt.comma ~option f ();
                  let module S = (val S.generate ()) in
                  S.print ~option f s)
                s)
            f ())
        v
    | Exact_numeric_type (`decimal v, _) ->
      Printer_token.print ~option f Kw_decimal;

      Option.iter
        (fun (v, s) ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f v;

              Option.iter
                (fun s ->
                  Sfmt.comma ~option f ();
                  let module S = (val S.generate ()) in
                  S.print ~option f s)
                s)
            f ())
        v
    | Exact_numeric_type (`dec v, _) ->
      Printer_token.print ~option f Kw_dec;

      Option.iter
        (fun (v, s) ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f v;

              Option.iter
                (fun s ->
                  Sfmt.comma ~option f ();
                  let module S = (val S.generate ()) in
                  S.print ~option f s)
                s)
            f ())
        v
    | Exact_numeric_type (`smallint, _) ->
      Printer_token.print ~option f Kw_smallint
    | Exact_numeric_type (`integer, _) ->
      Printer_token.print ~option f Kw_integer
    | Exact_numeric_type (`int, _) -> Printer_token.print ~option f Kw_int
    | Exact_numeric_type (`bigint, _) -> Printer_token.print ~option f Kw_bigint
end
