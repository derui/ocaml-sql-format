include (
  struct
    module M = Parser_monad.Monad
    (* open M.Syntax *)
    (* open M.Let_syntax *)

    let parse () = M.return ()

    let generate _ = parse ()
  end :
    Intf.GEN)
