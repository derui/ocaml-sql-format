module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select * from a, (select c,d,f from e) as v_v
,(select abc from f) as e
|}

let option = F.Options.default

let%test_unit "from_3 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "from_3 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    SELECT
        *

    FROM
        a,
        (
            SELECT
                c,
                d,
                f

            FROM
                e

        ) v_v,
        (
            SELECT
                abc

            FROM
                f

        ) e |}]
