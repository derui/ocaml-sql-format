let read_content file =
  let chan = open_in file in
  let rec loop buf =
    try
      let ret = input_line chan in
      loop (ret :: buf)
    with End_of_file ->
      close_in chan;
      List.rev buf |> String.concat "\n"
  in
  loop []

let () =
  let file = Sys.argv.(1)
  and test_name = Sys.argv.(2) in
  let content = read_content file in
  let template =
    read_content @@ Filename.concat "tool/test_gen" "test.ml.template"
  in
  let re_test_name = Re.str "%%TEST_NAME%%" |> Re.compile in
  let re_actual = Re.str "%%ACTUAL%%" |> Re.compile in
  let replaced = Re.replace_string re_test_name ~by:test_name template in
  let replaced = Re.replace_string re_actual ~by:content replaced in
  print_endline replaced
