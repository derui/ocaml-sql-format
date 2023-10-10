open Types.Token
open Intf
module M = Monad

module Make () : PRINTER_M = struct
  let print () =
    let open M.Let_syntax in
    let* () = M.skip_comments () in
    let* c = M.current () in
    match c with
    | Tok_ident _ -> Token.print ()
    | _ ->
      let* _ = M.bump () in
      M.return ()
end
