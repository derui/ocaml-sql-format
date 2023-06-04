module Options = Options

let format option lexbuf =
  let lexer = Sedlexing.with_tokenizer Lexer.token lexbuf in
  let parser =
    MenhirLib.Convert.Simplified.traditional2revised Parser.Parser.statements
  in
  let result = parser lexer in
  let buffer = Buffer.create 16 in
  let formatter = Format.formatter_of_buffer buffer in
  List.iter (Statement_printer.print formatter ~option) result;
  Format.pp_print_flush formatter ();
  Buffer.to_bytes buffer |> String.of_bytes

let from_channel chan ~option =
  let lexbuf = Sedlexing.Utf8.from_channel chan in
  format option lexbuf

let from_string buf ~option =
  let lexbuf = Sedlexing.Utf8.from_string buf in
  format option lexbuf
