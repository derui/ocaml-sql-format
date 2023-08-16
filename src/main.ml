open Cmdliner

let arg_overwrite =
  let doc = "Overwrite file." in
  Arg.(value & flag & info [ "w"; "write" ] ~doc)

let arg_files =
  let doc = "Path of files" in
  Arg.(value & pos_all file [] & info [] ~docv:"FILE" ~doc)

let arg_config =
  let doc = "Specify configuration file" in
  let env =
    let doc = "Overrides the default configuration file to format" in
    Cmd.Env.info "OCAML_SQL_FORMAT_CONFIG" ~doc
  in
  Arg.(
    value
    & opt file "~/.ocaml-sql-format.toml"
    & info [ "c"; "config" ] ~env ~doc ~docv:"CONFIG")

let main _ _ _ = ()

let main_t = Term.(const main $ arg_overwrite $ arg_config $ arg_files)

let cmd =
  let doc = "print formatted SQL or write it directly" in
  let man =
    [ `S Manpage.s_bugs; `P "Email bug report to <derutakayu@gmail.com>" ]
  in
  let info = Cmd.info "ocaml-sql-format" ~version:"0.1.0" ~doc ~man in
  Cmd.v info main_t

let main () = exit (Cmd.eval cmd)

let () = main ()
