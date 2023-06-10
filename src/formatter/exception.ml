exception Syntax_error of (int * int) option * string

let get_lexing_position lexbuf =
  let start', _ = Sedlexing.lexing_positions lexbuf in
  let line_number = start'.pos_lnum in
  let col = start'.pos_cnum - start'.pos_bol + 1 in
  (line_number, col)
