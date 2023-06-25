let () =
  let kw = Sys.argv.(1) in
  let ary = Array.make (String.length kw) "" in
  String.iteri
    (fun i c ->
      let kw_c =
        Printf.sprintf "Chars \"%c%c\"" (Char.lowercase_ascii c)
          (Char.uppercase_ascii c)
      in
      ary.(i) <- kw_c)
    kw;
  let chars = Array.to_list ary |> String.concat "," in

  Printf.printf "let kw_%s = [%%sedlex.regexp? %s]\n"
    (String.lowercase_ascii kw)
    chars
