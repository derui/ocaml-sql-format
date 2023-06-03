open Syntax
module Syntax = Syntax

let select_regex =
  [%sedlex.regexp?
    Chars "sS", Chars "eE", Chars "lL", Chars "eE", Chars "cC", Chars "tT"]

let from_regex =
  [%sedlex.regexp? Chars "fF", Chars "rR", Chars "oO", Chars "mM"]

let space = [%sedlex.regexp? Plus (Chars " \t\r\n")]

let rec token buf accum =
  match%sedlex buf with
  | select_regex ->
    token buf (Sy_keyword (Ky_select (Sedlexing.Utf8.lexeme buf)) :: accum)
  | from_regex ->
    token buf (Sy_keyword (Ky_from (Sedlexing.Utf8.lexeme buf)) :: accum)
  | '*' -> token buf (Sy_keyword Ky_asterisk :: accum)
  | eof -> List.rev accum
  | id_start, Star id_continue ->
    token buf (Sy_ident (Sedlexing.Utf8.lexeme buf) :: accum)
  | space -> token buf accum
  | any -> token buf accum
  | _ -> failwith "Malformed source"
