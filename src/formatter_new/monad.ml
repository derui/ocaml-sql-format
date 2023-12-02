include (
  struct
    module Token = Types.Token

    type raw = Sql_syntax.Raw.t

    (** Type of monad. *)
    type data =
      { options : Options.t
      ; ppf : raw Fmt.t
      }

    type 'a t = data -> 'a * data

    (* basic monad/applicable operations *)
    let map : ('a -> 'b) -> 'a t -> 'b t =
     fun f v data ->
      let v, data = v data in
      (f v, data)

    let bind : 'a t -> ('a -> 'b t) -> 'b t =
     fun v f data ->
      let v, data = v data in
      f v data

    let return v p = (v, p)

    module Let_syntax = struct
      let ( let* ) = bind
    end

    let append fmt data =
      let data' = { data with ppf = Fmt.append data.ppf fmt } in
      ((), data')

    let options data = (data.options, data)

    module Run = struct
      let run m options pf raw =
        let data = { options; ppf = Fmt.nop } in
        let _, data = m data in
        data.ppf pf raw
    end
  end :
    Monad_intf.S)
