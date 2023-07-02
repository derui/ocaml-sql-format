module F = Formatter
module P = Parser.Parser

let actual =
  {|
  select
  timestampadd(sql_tsi_frac_second, 'express', 3)
  ,timestampadd(sql_tsi_second, 'express', 3)
  ,timestampadd(sql_tsi_minute, 'express', 3)
  ,timestampadd(sql_tsi_hour, 'express', 3)
  ,timestampadd(sql_tsi_day, 'express', 3)
  ,timestampadd(sql_tsi_week, 'express', 3)
  ,timestampadd(sql_tsi_month, 'express', 3)
  ,timestampadd(sql_tsi_quarter, 'express', 3)
  ,timestampadd(sql_tsi_year, 'express', 3)

  ,timestampdiff(sql_tsi_frac_second, 'express', 3)
  ,timestampdiff(sql_tsi_second, 'express', 3)
  ,timestampdiff(sql_tsi_minute, 'express', 3)
  ,timestampdiff(sql_tsi_hour, 'express', 3)
  ,timestampdiff(sql_tsi_day, 'express', 3)
  ,timestampdiff(sql_tsi_week, 'express', 3)
  ,timestampdiff(sql_tsi_month, 'express', 3)
  ,timestampdiff(sql_tsi_quarter, 'express', 3)
  ,timestampdiff(sql_tsi_year, 'express', 3)
from a
|}

let option = F.Options.default

let%test_unit "function_7 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "function_7 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
      SELECT
          TIMESTAMPADD(SQL_TSI_FRAC_SECOND, 'express', 3),
          TIMESTAMPADD(SQL_TSI_SECOND, 'express', 3),
          TIMESTAMPADD(SQL_TSI_MINUTE, 'express', 3),
          TIMESTAMPADD(SQL_TSI_HOUR, 'express', 3),
          TIMESTAMPADD(SQL_TSI_DAY, 'express', 3),
          TIMESTAMPADD(SQL_TSI_WEEK, 'express', 3),
          TIMESTAMPADD(SQL_TSI_MONTH, 'express', 3),
          TIMESTAMPADD(SQL_TSI_QUARTER, 'express', 3),
          TIMESTAMPADD(SQL_TSI_YEAR, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_FRAC_SECOND, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_SECOND, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_MINUTE, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_HOUR, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_DAY, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_WEEK, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_MONTH, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_QUARTER, 'express', 3),
          TIMESTAMPDIFF(SQL_TSI_YEAR, 'express', 3)
      FROM
          a |}]
