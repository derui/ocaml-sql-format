open Parser.Ast
open Parser.Token
open Intf

module type S = PRINTER with type t = ext joined_table

module Make
    (TP : GEN with type t = ext table_primary)
    (TR : GEN with type t = ext table_reference)
    (C : GEN with type t = ext condition) : S = struct
  type t = ext joined_table

  let print f t ~option =
    match t with
    | `Joined_table (p, list, _) ->
      let module TP = (val TP.generate ()) in
      TP.print f p ~option;
      List.iter
        (fun v ->
          Fmt.string f " ";
          match v with
          | `cross (kw, primary) ->
            let kw =
              match kw with
              | `cross -> Kw_cross
              | `union -> Kw_union
            in
            Printer_token.print f kw ~option;
            Fmt.string f " ";
            Printer_token.print f Kw_join ~option;
            Fmt.string f " ";
            TP.print f primary ~option
          | `qualified (kw, e, c) ->
            Option.iter
              (fun kw ->
                let kw =
                  match kw with
                  | `left -> Kw_left
                  | `right -> Kw_right
                  | `full -> Kw_full
                  | `inner -> Kw_inner
                in
                Printer_token.print f kw ~option;
                Fmt.string f " ")
              kw;

            Printer_token.print f Kw_join ~option;
            Fmt.string f " ";
            let module TR = (val TR.generate ()) in
            TR.print f e ~option;
            Fmt.string f " ";
            Printer_token.print f Kw_on ~option;
            Fmt.string f " ";
            let module C = (val C.generate ()) in
            C.print f c ~option)
        list
end
