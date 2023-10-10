open Types.Token
open Intf
module M = Monad

module Make () : PRINTER_M = struct
  let print () =
    let open M.Let_syntax in
    let* () = M.skip_comments () in
    let* c = M.current () in
    match c with
    | Op_plus
    | Op_minus
    | Op_star
    | Op_slash
    | Op_concat
    | Op_amp
    | Op_pipe
    | Op_eq
    | Op_eq2
    | Op_ge
    | Op_gt
    | Op_le
    | Op_lt
    | Op_ne
    | Op_ne2
    | Op_extract
    | Op_extract_2
    | Op_lshift
    | Op_rshift
    | Kw_and
    | Kw_or -> Token.print ()
    | _ -> M.fail "Invalid binary operator"
end
