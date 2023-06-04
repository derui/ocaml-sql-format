let format lexbuf =
  let lexer = Sedlexing.with_tokenizer Lexer.token lexbuf in
  let parser =
    MenhirLib.Convert.Simplified.traditional2revised Parser.Parser.statements
  in
  let result = parser lexer in
  let results = List.map (Statement_printer.to_string ~option:()) result in
  String.concat "\n" results

let from_channel chan ~option:() =
  let lexbuf = Sedlexing.Utf8.from_channel chan in
  format lexbuf

let from_string buf ~option:() =
  let lexbuf = Sedlexing.Utf8.from_string buf in
  format lexbuf
