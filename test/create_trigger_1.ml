module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create trigger if not exists a.some_trigger before delete on foo_bar
begin
insert into abc (a,b,c) values (1,2,3);
end;
|}

let option = F.Options.default

let%test_unit "create_trigger_1 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_trigger_1 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TRIGGER IF NOT EXISTS a.some_trigger
    BEFORE DELETE ON foo_bar
    BEGIN
        INSERT INTO abc (
            a,
            b,
            c
        )
        VALUES
            (1, 2, 3);
    END; |}]
