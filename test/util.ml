let parse str =
  let lexbuf = Sedlexing.Utf8.from_string str in
  let lexer = Sedlexing.with_tokenizer Lexer.token lexbuf in
  let parser =
    MenhirLib.Convert.Simplified.traditional2revised Parser.Parser.entries
  in

  try parser lexer
  with Parser.Parser.Error as e ->
    let start, end' = Sedlexing.lexing_positions lexbuf in
    Printf.eprintf "Syntax error at %d:%d - %d:%d\n" (start.pos_lnum + 1)
      (start.pos_cnum - start.pos_bol + 1)
      (end'.pos_lnum + 1)
      (end'.pos_cnum - end'.pos_bol + 1);
    raise e
