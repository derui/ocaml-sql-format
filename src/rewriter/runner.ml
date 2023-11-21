open Runner_intf

include (
  struct
    module L = Sql_syntax.Language

    let rewrite r option language =
      let new_language = ref @@ L.empty () in
      let env = Env.make option in

      L.walk
        ~f:(fun raw ->
          match r env raw with
          | None ->
            new_language := L.append raw !new_language;
            Some ()
          | Some raw ->
            new_language := L.append raw !new_language;
            None)
        language;

      !new_language
  end :
    S)
