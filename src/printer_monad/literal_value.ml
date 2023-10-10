open Types.Token
open Intf
module M = Monad

module Make : PRINTER_M = struct
  let print () =
    let open M.Let_syntax in
    let* () = M.skip_comments () in
    let* c = M.current () in
    match c with
    | Tok_string _
    | Tok_numeric _
    | Tok_blob _
    | Kw_null
    | Kw_true
    | Kw_false
    | Kw_current_date
    | Kw_current_time
    | Kw_current_timestamp -> Token.print ()
    | _ -> M.fail "Does not literal"
end
