module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
   left()
  ,left('a', '2')
  ,right()
  ,right('a', '2')
  ,char()
  ,char('a', '2')
  ,user()
  ,user('a', '2')
  ,year()
  ,year('a', '2')
  ,month()
  ,month('a', '2')
  ,hour()
  ,hour('a', '2')
  ,minute()
  ,minute('a', '2')
  ,second()
  ,second('a', '2')
  ,xmlconcat()
  ,xmlconcat('a', '2')
  ,xmlcomment()
  ,xmlcomment('a', '2')
  ,xmltext()
  ,xmltext('a', '2')
from a
|}

let option = F.Options.default

let%test_unit "function_8 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_8 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          LEFT(),LEFT('a','2'),RIGHT(),RIGHT('a','2'),CHAR(),CHAR('a','2'),USER(),USER('a','2'),YEAR(),YEAR('a','2'),MONTH(),MONTH('a','2'),HOUR(),HOUR('a','2'),MINUTE(),MINUTE('a','2'),SECOND(),SECOND('a','2'),XMLCONCAT(),XMLCONCAT('a','2'),XMLCOMMENT(),XMLCOMMENT('a','2'),XMLTEXT(),XMLTEXT('a','2')
       FROM a |}]
