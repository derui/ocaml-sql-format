module Token = Types.Token

(** Type of monad. *)
type data =
  { mutable current : Token.token option
  ; fmt : Format.formatter
  ; lexer : unit -> Token.token
  ; options : Options.t
  }

type 'a t = data -> ('a * data, string) result

(* basic monad/applicable operations *)
let map : ('a -> 'b) -> 'a t -> 'b t =
 fun f v data ->
  match v data with
  | Ok (v, data) -> Ok (f v, data)
  | Error _ as e -> e

let apply fp xp data =
  match fp data with
  | Ok (f, data) -> (map f xp) data
  | Error _ as e -> e

let bind : 'a t -> ('a -> 'b t) -> 'b t =
 fun v f data ->
  match v data with
  | Ok (v, data) -> f v data
  | Error _ as e -> e

let return v p = Ok (v, p)

module Syntax = struct
  let ( >>= ) = bind

  let ( <$> ) = map

  let ( <*> ) = apply
end

module Let_syntax = struct
  let ( let* ) = bind
end

let data () data = Ok (data, data)

(** get current token. If token did not read before, read an token. *)
let current () =
  let open Let_syntax in
  let* data' = data () in
  match data'.current with
  | Some v -> return v
  | None ->
    let token = data'.lexer () in
    data'.current <- Some token;
    return token

(** bump a token. If token did not read before, read an token and do not store *)
let bump () =
  let open Let_syntax in
  let* data' = data () in
  match data'.current with
  | Some v ->
    data'.current <- None;
    return v
  | None ->
    let token = data'.lexer () in
    return token

let indent_by size =
  let open Let_syntax in
  let* data' = data () in
  let fmt = data'.fmt in
  Format.pp_print_break fmt 0 size;

  return (fun ppf -> (Fmt.vbox ~indent:0 ppf) fmt ())

let indent () =
  let open Let_syntax in
  let* data' = data () in
  indent_by data'.options.indent_size
