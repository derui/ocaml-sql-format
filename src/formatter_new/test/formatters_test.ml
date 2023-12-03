(** test for sql formatting *)

let%expect_test "only semicolon" =
  Util.run ";";
  [%expect ";"];

  Util.run ";;";
  [%expect {|
    ;
    ; |}]
