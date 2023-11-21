module Tr = Sql_syntax.Trivia
module R = Rewriter
module P = Parser_new

let%expect_test "spacing" =
  let parser = Util.of_parser (module P.Parser_expr) in

  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "?" |> Printf.printf "|%s|";

  [%expect "| ?|"]
