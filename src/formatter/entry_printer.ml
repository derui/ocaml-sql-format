open Types.Ast

let print f t ~option =
  match t with
  | Sql_statement _ as v ->
    let module D = (val Printer.sql_statement ()) in
    D.print f v ~option
