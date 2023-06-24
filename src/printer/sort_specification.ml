open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext sort_specification

module Make (Sort_key : GEN with type t = ext sort_key) : S = struct
  type t = ext sort_specification

  let print f t ~option =
    match t with
    | `Sort_specification (key, order, null_order, _) ->
      let module Sort_key = (val Sort_key.generate ()) in
      Sort_key.print f key ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print f
            (match v with
            | `asc -> Kw_asc
            | `desc -> Kw_desc)
            ~option)
        order;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          Printer_token.print f Kw_null ~option;
          Fmt.string f " ";
          Printer_token.print f
            (match v with
            | `null_first -> Kw_first
            | `null_last -> Kw_last)
            ~option)
        null_order
end
