open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext query_term

module Make (P : GEN with type t = ext query_primary) : S = struct
  type t = ext query_term

  let print f t ~option =
    match t with
    | Query_term (primary, list, _) ->
      let module P = (val P.generate ()) in
      P.print f primary ~option;

      List.iter
        (fun (qualifiler, v) ->
          Fmt.string f " ";
          Printer_token.print f Kw_union ~option;

          Option.iter
            (fun v ->
              Fmt.string f " ";

              let kw =
                match v with
                | `All -> Kw_all
                | `Distinct -> Kw_distinct
              in
              Printer_token.print f kw ~option;

              Fmt.string f " ")
            qualifiler;

          P.print f v ~option)
        list
end
