let run source p =
  let module S = Sql_syntax in
  let module PE = Parser_monad.Parse_error in
  let module M = Parser_monad.Monad in
  let token =
    Sedlexing.Utf8.from_string source |> Parser_monad.Tokenizer.tokenize
  in
  M.parse token (p ())
  |> Result.fold ~ok:S.Language.to_string ~error:PE.to_string
