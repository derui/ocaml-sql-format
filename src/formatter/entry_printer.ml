let print f t ~option =
  match t with
  | `Directly_executable_statement _ as v ->
    let module D = (val Printer.directly_executable_statement ()) in
    D.print f v ~option
