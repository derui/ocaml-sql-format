open Syntax
module Syntax = Syntax

let kw_select =
  [%sedlex.regexp?
    Chars "sS", Chars "eE", Chars "lL", Chars "eE", Chars "cC", Chars "tT"]

let kw_from = [%sedlex.regexp? Chars "fF", Chars "rR", Chars "oO", Chars "mM"]

let kw_as = [%sedlex.regexp? Chars "aA", Chars "sS"]

let space = [%sedlex.regexp? Plus (Chars " \t\r\n")]

let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z' | 0x0153 .. 0xfffd]

let digit = [%sedlex.regexp? '0' .. '9']

let id_part =
  [%sedlex.regexp? ('@' | '#' | letter), Star (letter | '_' | digit)]

let quoted_id =
  [%sedlex.regexp? id_part | '"', Star ("\"\"" | Sub (any, '"')), '"']

let rec token buf accum =
  match%sedlex buf with
  | kw_select ->
    token buf (Sy_keyword (Ky_select (Sedlexing.Utf8.lexeme buf)) :: accum)
  | kw_from ->
    token buf (Sy_keyword (Ky_from (Sedlexing.Utf8.lexeme buf)) :: accum)
  | kw_as -> token buf (Sy_keyword (Ky_as (Sedlexing.Utf8.lexeme buf)) :: accum)
  | '*' -> token buf (Sy_keyword Ky_asterisk :: accum)
  | eof -> List.rev accum
  | quoted_id -> token buf (Sy_ident (Sedlexing.Utf8.lexeme buf) :: accum)
  | space -> token buf accum
  | any -> token buf accum
  | _ -> failwith "Malformed source"
