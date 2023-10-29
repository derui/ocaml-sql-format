include (
  struct
    module M = Parser_monad.Monad
    open M.Let_syntax
    module K = Parser_monad.Kind
    module T = Types.Token
    module Kw = Types.Keyword

    let parse table_or_subquery () =
      let* () = M.bump_kw Kw.Kw_from in
      table_or_subquery ()

    let generate taker () =
      let table_or_subquery = taker Parser_monad.Kind.N_table_or_subquery in
      parse table_or_subquery ()
  end :
    Intf.GEN)
