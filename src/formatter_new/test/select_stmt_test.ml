module O = Formatter_new.Options

let options = { O.default with keyword_case = `upper }

let%expect_test "simple select" =
  Util.run ~options "select 1";
  [%expect {|
    SELECT
         1 |}];

  Util.run ~options "select *";
  [%expect {|
    SELECT
         * |}];

  Util.run ~options "select a from abc";
  [%expect {|
    SELECT
         a
     FROM
         abc |}];

  Util.run ~options {|select a from "long table name"|};
  [%expect {|
    SELECT
         a
     FROM
         "long table name" |}]

let%expect_test "union" =
  Util.run ~options {|
  SELECT  * from "some_table name" union select t.b from "table" t
|};
  [%expect
    {|
    SELECT
        *
    FROM
        "some_table name"
    UNION
    SELECT
        t.b
    FROM
        "table" t |}]
