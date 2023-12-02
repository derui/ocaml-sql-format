open Runner_intf

include (
  struct
    module L = Sql_syntax.Language

    let rewrite r language =
      let new_language = ref @@ L.empty () in

      L.walk
        ~f:(fun raw ->
          match r raw with
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
