module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create trigger if not exists a.some_trigger instead of update of (c,d) on foo_bar
begin
update test set a = 5;
end;
|}

let option = F.Options.default

let%test_unit "create_trigger_2 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_trigger_2 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TRIGGER IF NOT EXISTS a.some_trigger
    INSTEAD OF UPDATE OF (c, d) ON foo_bar
    BEGIN
        UPDATE test
        SET
            a = 5;
    END; |}]
