let run ?(options = Rewriter.Options.default) parser p source =
  let module S = Sql_syntax in
  let module PE = Parser_monad.Parse_error in
  let module M = Parser_monad.Monad in
  let token = Sedlexing.Utf8.from_string source |> Parser_monad.Tokenizer.tokenize in
  M.parse token (parser ())
  |> Result.map (Rewriter.Runner.rewrite p options)
  |> Result.fold ~ok:S.Language.to_string ~error:PE.to_string

let of_parser (module M : Parser_new.Intf.GEN) = M.generate (Parser_new.Slot.get_taker ())
