open Intf
module M = Monad

module Make () : PRINTER_M = struct
  let print () =
    let open M.Let_syntax in
    let* () = M.skip_comments () in
    let* c = M.current () in
    match c with
    | Tok_numeric _ -> Token.print ()
    | _ -> M.fail "Does not numeric literal"
end
