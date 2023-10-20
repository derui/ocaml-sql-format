module M = Parser_monad.Monad

type parser = unit -> unit M.t
