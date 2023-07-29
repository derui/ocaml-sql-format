module Options = Printer.Options
module I = Parser.Parser.MenhirInterpreter

let get_parse_error env =
  match I.stack env with
  | (lazy Nil) -> "Invalid syntax"
  | (lazy (Cons (I.Element (state, _, _, _), _))) -> (
    (* debug output. *)
    Printf.printf "error in state: %d\n" (I.number state);
    try Parser.Mesasges.message (I.number state)
    with Not_found -> "invalid syntax (no specific message for this error)")

let rec parse lexbuf (checkpoint : Types.Statement.t list I.checkpoint) =
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
    (* debug output *)
    Printf.printf "error at (%d, %d) %s\n" line pos
      (Sedlexing.Utf8.lexeme lexbuf);
    raise (Exception.Syntax_error (Some (line, pos), msg))
  | I.Accepted v -> v
  | I.Rejected ->
    raise
      (Exception.Syntax_error
         (None, "invalid syntax (parser rejected the input)"))

let format (option : Options.t) lexbuf =
  let checkpoint =
    Parser.Parser.Incremental.statements @@ fst
    @@ Sedlexing.lexing_positions lexbuf
  in
  let result = parse lexbuf checkpoint in
  let buffer = Buffer.create 16 in
  let formatter = Format.formatter_of_buffer buffer in
  Format.pp_set_margin formatter option.max_line_length;
  List.iter (Entry_printer.print formatter ~option) result;
  Format.pp_print_flush formatter ();
  Buffer.to_bytes buffer |> String.of_bytes

let from_channel chan ~option =
  let lexbuf = Sedlexing.Utf8.from_channel chan in
  format option lexbuf

let from_string buf ~option =
  let lexbuf = Sedlexing.Utf8.from_string buf in
  format option lexbuf
