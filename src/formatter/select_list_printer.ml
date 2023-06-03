open Parser.Ast
include Printer_intf

include (
  struct
    type t = select_list

    let to_string t ~option:_ =
      match t with
      | Sl_asterisk -> "*"
  end :
    S with type t = select_list)
