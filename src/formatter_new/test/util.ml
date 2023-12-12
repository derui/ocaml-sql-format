let run ?(options = Formatter_new.Options.default) ?(debug = false) source =
  let module S = Sql_syntax in
  let module PE = Parser_monad.Parse_error in
  let module M = Parser_monad.Monad in
  let token = Sedlexing.Utf8.from_string source |> Parser_monad.Tokenizer.tokenize in
  let parser = Parser_new.(Parser_sql_stmt_list.generate @@ Slot.get_taker ()) in
  M.parse token (parser ())
  |> Result.fold
       ~ok:(fun l ->
         if debug then
           S.Language.walk
             ~f:(fun r ->
               print_endline @@ S.Raw.show r;
               Option.none)
             l
         else ();
         Formatter_new.Formatters.format Fmt.stdout options l)
       ~error:(fun e -> PE.to_string e |> print_endline)
