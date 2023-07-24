open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext direct_sql_statement

module Make (V : GEN with type t = ext directly_executable_statement) : S =
struct
  type t = ext direct_sql_statement

  let print f t ~option =
    match t with
    | Direct_sql_statement (v, _) ->
      List.iter
        (fun v ->
          let module V = (val V.generate ()) in
          V.print ~option f v;
          Printer_token.print ~option f Tok_semicolon)
        v
end
