open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext with_clause

module Make (V : GEN with type t = ext with_list) : S = struct
  type t = ext with_clause

  let print f t ~option =
    match t with
    | With_clause (kw, list, _) ->
      Printer_token.print ~option f Kw_with;
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Printer_token.print ~option f Kw_recursive)
        kw;

      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f list
end
