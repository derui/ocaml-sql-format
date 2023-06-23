open Parser.Ast
open Intf

module type S = PRINTER with type t = ext column_list

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext column_list

  let print f t ~option =
    match t with
    | `Column_list (list, _) ->
      let module I = (val I.generate ()) in
      Printer_token.print f Tok_lparen ~option;

      (match list with
      | [] -> failwith "Invalid parsing"
      | fst :: rest ->
        I.print f fst ~option;
        List.iter
          (fun v ->
            I.print f v ~option;
            Fmt.string f " ")
          rest);
      Printer_token.print f Tok_rparen ~option
end
