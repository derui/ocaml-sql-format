(** test for sql formatting *)
module O = Formatter_new.Options

let%expect_test "only semicolon" =
  Util.run ";";
  [%expect ";"];

  Util.run ";;";
  [%expect {|
    ;
    ; |}]

let%expect_test "begin statement" =
  Util.run "begin;";
  [%expect "\n    begin\n    ;"];

  Util.run "begin    transaction";
  [%expect {| begin transaction |}];

  Util.run "explain begin";
  [%expect {| explain begin |}];

  Util.run "explain analyze begin";
  [%expect {| explain analyze begin |}];

  Util.run ~options:{ O.default with keyword_case = `upper } "begin    transaction";
  [%expect {| BEGIN TRANSACTION |}]

let%expect_test "rollback statement" =
  Util.run "rollback;";
  [%expect {|
    rollback
    ; |}];

  Util.run "rollback    transaction";
  [%expect {| rollback transaction |}];

  Util.run ~options:{ O.default with keyword_case = `upper } "rollback    transaction";
  [%expect {| ROLLBACK TRANSACTION |}]

let%expect_test "rollback statement" =
  Util.run "rollback;";
  [%expect {|
    rollback
    ; |}];

  Util.run "rollback    transaction";
  [%expect {| rollback transaction |}];

  Util.run ~options:{ O.default with keyword_case = `upper } "rollback    transaction";
  [%expect {| ROLLBACK TRANSACTION |}]
