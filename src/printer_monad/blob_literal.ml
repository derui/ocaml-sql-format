open Intf
module M = Monad

module Make () : PRINTER_M = struct
  let print () =
    let open M.Let_syntax in
    let open M.Syntax in
    let* () = M.skip_comments () in
    let* c = M.current () in
    match c with
    | Tok_blob v -> M.bump () *> M.pp (fun fmt -> Fmt.string fmt v)
    | _ -> M.return ()
end
