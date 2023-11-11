module P = Parser_new
module M = Parser_monad.Monad
module S = Sql_syntax
module PE = Parser_monad.Parse_error

let p = P.Parser_sql_stmt_list.generate (P.Slot.get_taker ())

let%expect_test "parse " =
  Util.run {| ;;; |} p |> print_endline;
  Util.run {| select 1 |} p |> print_endline;
  Util.run {| select 1; delete from b |} p |> print_endline;
  Util.run {| select 1;;
            ;; |} p |> print_endline;

  [%expect {|
      ;;;
      select 1
      select 1; delete from b
      select 1;;
      ;; |}]
