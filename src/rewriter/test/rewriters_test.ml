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

let%expect_test "wrap" =
  let parser = Util.of_parser (module P.Parser_expr) in

  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "('ref')" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "(3,5,     53)" |> Printf.printf "|%s|\n";

  [%expect {|
    |('ref')|
    |(3, 5, 53)| |}]

let%expect_test "function" =
  let parser = Util.of_parser (module P.Parser_expr) in

  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "fun()" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "fun(   *   )" |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "bcd   ('a',  'ef' , 121)"
  |> Printf.printf "|%s|\n";
  Util.run parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "bcd   (DISTINCT 'a',  'ef' , 121)"
  |> Printf.printf "|%s|\n";

  [%expect {|
    |fun()|
    |fun(*)|
    |bcd('a', 'ef', 121)|
    |bcd(distinct 'a', 'ef', 121)| |}]

let%expect_test "collate" =
  let parser = Util.of_parser (module P.Parser_expr) in
  let options = { R.Options.default with keyword_case = `upper } in

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "2315 collate \"foobar\" "
  |> Printf.printf "|%s|\n";

  [%expect {|
    |  2315 COLLATE "foobar"| |}]

let%expect_test "like" =
  let parser = Util.of_parser (module P.Parser_expr) in
  let options = { R.Options.default with keyword_case = `upper } in

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu like '%ab'"
  |> Printf.printf "|%s|\n";

  Util.run ~options parser
    (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some)
    "a.colu not like '%ab' escape 'ff'"
  |> Printf.printf "|%s|\n";

  [%expect {|
    | a.colu LIKE '%ab'|
    | a.colu NOT LIKE '%ab' ESCAPE 'ff'| |}]

let%expect_test "glob" =
  let parser = Util.of_parser (module P.Parser_expr) in
  let options = { R.Options.default with keyword_case = `upper } in

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu glob '%ab'"
  |> Printf.printf "|%s|\n";

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu not glob '%ab'"
  |> Printf.printf "|%s|\n";

  [%expect {|
    | a.colu GLOB '%ab'|
    | a.colu NOT GLOB '%ab'| |}]

let%expect_test "regexp" =
  let parser = Util.of_parser (module P.Parser_expr) in
  let options = { R.Options.default with keyword_case = `as_is } in

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu RegExp '%ab'"
  |> Printf.printf "|%s|\n";

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu noT regEXP '%ab'"
  |> Printf.printf "|%s|\n";

  [%expect {|
    | a.colu RegExp '%ab'|
    | a.colu noT regEXP '%ab'| |}]

let%expect_test "match" =
  let parser = Util.of_parser (module P.Parser_expr) in
  let options = { R.Options.default with keyword_case = `as_is } in

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu match '%ab'"
  |> Printf.printf "|%s|\n";

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu noT MATCH '%ab'"
  |> Printf.printf "|%s|\n";

  [%expect {|
    | a.colu match '%ab'|
    | a.colu noT MATCH '%ab'| |}]

let%expect_test "between" =
  let parser = Util.of_parser (module P.Parser_expr) in
  let options = { R.Options.default with keyword_case = `as_is } in

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu between   1\nand 3"
  |> Printf.printf "|%s|\n";

  Util.run ~options parser (fun env v -> R.Rewriters.rewrite_expr env v |> Option.some) "a.colu not   between 3 and 5"
  |> Printf.printf "|%s|\n";

  [%expect {|
    | a.colu between 1 and 3|
    | a.colu not between 3 and 5| |}]
