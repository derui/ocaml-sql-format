open Parser.Ast
include Printer_intf

include (
  struct
    type t = select_list

    let print f t ~option:_ =
      match t with
      | Sl_asterisk -> Fmt.string f "*"
  end :
    S with type t = select_list)
