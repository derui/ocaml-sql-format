module Options = Options
module I = Parser.Parser.MenhirInterpreter

let get_parse_error env =
  match I.stack env with
  | (lazy Nil) -> "Invalid syntax"
  | (lazy (Cons (I.Element (state, _, _, _), _))) -> (
    try Parser.Mesasges.message (I.number state)
    with Not_found -> "invalid syntax (no specific message for this eror)")

let rec parse lexbuf (checkpoint : Parser.Ast.entry list I.checkpoint) =
  match checkpoint with
  | I.InputNeeded _env ->
    let token = Lexer.token lexbuf in
    let startp, endp = Sedlexing.lexing_positions lexbuf in
    let checkpoint = I.offer checkpoint (token, startp, endp) in
    parse lexbuf checkpoint
  | I.Shifting _ | I.AboutToReduce _ ->
    let checkpoint = I.resume checkpoint in
    parse lexbuf checkpoint
  | I.HandlingError _env ->
    let line, pos = Exception.get_lexing_position lexbuf in
    let msg = get_parse_error _env in
    raise (Exception.Syntax_error (Some (line, pos), msg))
  | I.Accepted v -> v
  | I.Rejected ->
    raise
      (Exception.Syntax_error
         (None, "invalid syntax (parser rejected the input)"))

let format option lexbuf =
  let checkpoint =
    Parser.Parser.Incremental.entries @@ fst
    @@ Sedlexing.lexing_positions lexbuf
  in
  let result = parse lexbuf checkpoint in
  let buffer = Buffer.create 16 in
  let formatter = Format.formatter_of_buffer buffer in
  List.iter (Entry_printer.print formatter ~option) result;
  Format.pp_print_flush formatter ();
  Buffer.to_bytes buffer |> String.of_bytes

let from_channel chan ~option =
  let lexbuf = Sedlexing.Utf8.from_channel chan in
  format option lexbuf

let from_string buf ~option =
  let lexbuf = Sedlexing.Utf8.from_string buf in
  format option lexbuf
