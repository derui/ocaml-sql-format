open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_function_type

module Make (V : GEN with type t = ext rank_function_type) : S = struct
  type t = ext window_function_type

  let print f t ~option =
    match t with
    | Window_function_type (`rank e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e;
      Fmt.string f " ";
      Printer_token.print ~option f Tok_lparen;
      Printer_token.print ~option f Tok_rparen
    | Window_function_type (`row_number, _) ->
      Printer_token.print ~option f Kw_row_number;
      Fmt.string f " ";
      Printer_token.print ~option f Tok_lparen;
      Printer_token.print ~option f Tok_rparen
end
