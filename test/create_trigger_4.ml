module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create trigger a.some_trigger after insert on foo_bar
for each row
begin
insert into foo select * from foo_bar;
end;
|}

let option = F.Options.default

let%test_unit "create_trigger_4 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_trigger_4 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TRIGGER a.some_trigger
    AFTER INSERT ON foo_bar FOR EACH ROW
    BEGIN
        INSERT INTO foo
        SELECT
            *
        FROM
            foo_bar;
    END; |}]
