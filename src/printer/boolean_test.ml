open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext boolean_test

module Make
    (V : GEN with type t = ext boolean_primary)
    (T : GEN with type t = ext truth_value) : S = struct
  type t = ext boolean_test

  let print f t ~option =
    match t with
    | Boolean_test (e, v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;

      Option.iter
        (fun v ->
          Fmt.string f " ";

          match v with
          | `is v ->
            Printer_token.print ~option f Kw_is;
            Fmt.string f " ";
            let module T = (val T.generate ()) in
            T.print ~option f v
          | `is_not v ->
            Printer_token.print ~option f Kw_is;
            Fmt.string f " ";
            Printer_token.print ~option f Kw_not;
            Fmt.string f " ";
            let module T = (val T.generate ()) in
            T.print ~option f v)
        v
end
