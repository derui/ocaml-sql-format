open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext filter_clause

module Make (BP : GEN with type t = ext boolean_primary) : S = struct
  type t = ext filter_clause

  let print f t ~option =
    match t with
    | Filter_clause (bp, _) ->
      Printer_token.print f Kw_filter ~option;
      Fmt.sp f ();

      let pf f _ =
        Printer_token.print f Kw_where ~option;

        let module BP = (val BP.generate ()) in
        Fmt.string f " ";
        BP.print f bp ~option
      in
      Sfmt.parens ~option pf f ()
end
