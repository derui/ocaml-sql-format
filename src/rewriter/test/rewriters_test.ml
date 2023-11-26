module Tr = Sql_syntax.Trivia
module R = Rewriter
module P = Parser_new

let%expect_test "simple expressions" =
  let parser = Util.of_parser (module P.Parser_expr) in

  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "?" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "123" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "'test'" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "ident" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "foo.ident" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "bar.foo.ident" |> Printf.printf "|%s|\n";

  [%expect "\n    | ?|\n    | 123|\n    | 'test'|\n    | ident|\n    | foo.ident|\n    | bar.foo.ident|"]

let%expect_test "unary" =
  let parser = Util.of_parser (module P.Parser_expr) in
  let lowercase_option = { R.Options.default with keyword_case = `lower } in
  let uppercase_option = { R.Options.default with keyword_case = `upper } in

  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "~1" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "+35" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "-test" |> Printf.printf "|%s|\n";
  Util.run ~options:lowercase_option parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "NOT v"
  |> Printf.printf "|%s|\n";
  Util.run ~options:uppercase_option parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "not v"
  |> Printf.printf "|%s|\n";

  [%expect {|
    | ~1|
    | +35|
    | -test|
    | not v|
    | NOT v| |}]

let%expect_test "cast" =
  let parser = Util.of_parser (module P.Parser_expr) in

  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "caST('ref' as integer(3,2))"
  |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "caST(\"ref\" as unsigned integer(3))"
  |> Printf.printf "|%s|\n";

  [%expect {|
    | cast('ref' as integer (3, 2))|
    | cast("ref" as unsigned integer (3))| |}]

let%expect_test "collate" =
  let parser = Util.of_parser (module P.Parser_expr) in
  let options = { R.Options.default with keyword_case = `upper } in

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "2315 collate \"foobar\" "
  |> Printf.printf "|%s|\n";

  [%expect {|
    |  2315 COLLATE "foobar"| |}]
