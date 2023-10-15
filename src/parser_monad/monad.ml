module Token = Types.Token

module Parse_error = struct
  type t =
    { start_pos : Lexing.position
    ; end_pos : Lexing.position
    ; message : string
    }
end

type raw_data =
  { start_pos : Lexing.position
  ; end_pos : Lexing.position
  ; token : Token.t
  }

(** Type of monad. *)
type data =
  { pointer : int
  ; token_stream : raw_data array
  }

type 'a t = data -> ('a * data, Parse_error.t) result

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

module Let_syntax = struct
  let ( let* ) = bind
end

let data () data = Ok (data, data)

let fail v =
  let open Let_syntax in
  let* data' = data () in
  let { start_pos; end_pos; token = _ } = data'.token_stream.(data'.pointer) in
  fun _ -> Error { Parse_error.start_pos; end_pos; message = v }

let protect : pre:(unit -> unit) -> finally:(unit -> unit) -> 'a t -> 'a t =
 fun ~pre ~finally m data ->
  pre ();
  let ret = m data in
  finally ();
  ret

module Syntax = struct
  let ( >>= ) = bind

  let ( <$> ) = map

  let ( <*> ) = apply

  (** evaluate [x] and [y], then return only result of [y] *)
  let ( *> ) x y = (fun _ y -> y) <$> x <*> y

  let ( <|> ) x y data =
    let x' = x data in
    match x' with
    | Ok v -> Ok (v, data)
    | Error _ -> (
      let y' = y data in
      match y' with
      | Ok v -> Ok (v, data)
      | Error _ -> fail "Can not get any result" data)
end
