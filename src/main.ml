open Cmdliner

(* utility functions *)

let unwind ~(protect : 'a -> unit) f x =
  try
    let y = f x in
    protect x;
    y
  with e ->
    protect x;
    raise e

let resolve_path fname =
  if Filename.is_relative fname then Filename.concat (Sys.getcwd ()) fname
  else fname

(** [move oldpath newpath] move [oldpath] to [newpath]. This function is *not*
    atomic. *)
let move oldpath newpath =
  if not @@ Sys.file_exists oldpath then raise Not_found;

  Sys.remove newpath;
  let oc = open_out newpath
  and ic = open_in oldpath in

  unwind
    ~protect:(fun (oc, ic) ->
      close_out_noerr oc;
      close_in_noerr ic)
    (fun (oc, ic) ->
      let rec loop () =
        try
          let v = input_byte ic in
          output_byte oc v;
          loop ()
        with End_of_file -> ()
      in
      loop ())
    (oc, ic)

(* arguments *)

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

let main overwrite config files =
  let option = ref Formatter.Options.default in

  if Sys.file_exists config then option := Config.parse config else ();

  let format file =
    let redirect str =
      if overwrite then (
        let tempfname = Filename.temp_file "osf" ".sql" in
        let oc = open_out tempfname in
        unwind ~protect:close_out (fun oc -> output_string oc str) oc;
        move tempfname @@ resolve_path file)
      else Printf.printf "\n%s\n" str
    in

    let ic = open_in file in
    unwind ~protect:close_in
      (fun ic -> Formatter.from_channel ~option:!option ic)
      ic
    |> redirect
  in

  let rec loop = function
    | [] -> `Ok ()
    | f :: rest ->
      if not @@ Sys.file_exists f then `Error (false, "not found file")
      else (
        format f;
        loop rest)
  in
  loop files

let main_t = Term.(ret (const main $ arg_overwrite $ arg_config $ arg_files))

let cmd =
  let doc = "print formatted SQL or write it directly" in
  let man =
    [ `S Manpage.s_bugs; `P "Email bug report to <derutakayu@gmail.com>" ]
  in
  let info = Cmd.info "ocaml-sql-format" ~version:"0.1.0" ~doc ~man in
  Cmd.v info main_t

let main () = exit (Cmd.eval cmd)

let () = main ()
