module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create temporary trigger a.some_trigger instead of update of (c,d) on foo_bar
for each row when v > 5
begin
update test set a = 5 where id = 3;
insert into foo select * from foo_bar;
end;
|}

let option = F.Options.default

let%test_unit "create_trigger_3 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_trigger_3 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TEMPORARY TRIGGER a.some_trigger
    INSTEAD OF UPDATE OF (c, d) ON foo_bar FOR EACH ROW WHEN v > 5
    BEGIN
        UPDATE test
        SET
            a = 5
        WHERE
            id = 3;

        INSERT INTO foo
        SELECT
            *
        FROM
            foo_bar;
    END; |}]
