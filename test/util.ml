let parse str =
  let lexbuf = Sedlexing.Utf8.from_string str in
  let lexer = Sedlexing.with_tokenizer Lexer.token lexbuf in
  let parser =
    MenhirLib.Convert.Simplified.traditional2revised Parser.Parser.entries
  in
  parser lexer
