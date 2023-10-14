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
  ; token : Token.token
  }

(** Type of monad. *)
type data =
  { pointer : int64
  ; lexer : raw_data array
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
  let startp, endp = data'.position () in
  fun _ -> Error { Parse_error.start_pos = startp; end_pos = endp; message = v }

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

let pp ppf =
  let open Let_syntax in
  let* data' = data () in
  return @@ ppf data'.fmt

let options () =
  let open Let_syntax in
  let* data' = data () in
  return data'.options

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

(** ignore all fail. This is usefull with [<|>] operator. *)
let skip : unit t = return ()

let force_space ?(len = 1) () =
  pp (fun fmt -> Fmt.string fmt (Bytes.make len ' ' |> Bytes.to_string))

let leading_space ?(len = 1) m =
  let open Let_syntax in
  let* () = force_space ~len () in
  m

let trailing_space ?(len = 1) m =
  let open Let_syntax in
  let* () = m in
  force_space ~len ()

let wrap_space ?(len = 1) m =
  let open Let_syntax in
  let* () = force_space ~len () in
  let* () = m in
  force_space ~len ()

(** indent by size *)
let indent_by : int -> 'a t -> 'a t =
 fun size m ->
  let open Let_syntax in
  let* data' = data () in
  let fmt = data'.fmt in
  protect
    ~pre:(fun () ->
      Format.pp_print_break fmt 0 size;
      Format.pp_open_vbox fmt 0)
    ~finally:(fun () -> Format.pp_close_box fmt ())
    m

(** indent by size in option *)
let indent : 'a t -> 'a t =
 fun m ->
  let open Let_syntax in
  let* data' = data () in
  indent_by data'.options.indent_size m

let cut =
  let open Let_syntax in
  let* data' = data () in
  return @@ Fmt.cut data'.fmt ()

(** skip white spaces *)
let rec skip_ws () =
  let open Let_syntax in
  let* v = current () in
  match v with
  | Token.Tok_space _ ->
    let* _ = bump () in
    skip_ws ()
  | _ -> return ()

(** skip white space and comments. Print comments if remove_comment option is
    false *)
let skip_comments =
  let rec comments' () =
    let open Let_syntax in
    let* v = current () in
    let* options = options () in
    match v with
    | Token.Tok_space _ ->
      let* _ = bump () in
      comments' ()
    | Token.Tok_line_comment c ->
      let* _ = bump () in
      let* _ =
        if not options.remove_comment then
          pp (fun fmt ->
              Fmt.string fmt c;
              Format.pp_force_newline fmt ())
        else return ()
      in

      comments' ()
    | Token.Tok_block_comment c ->
      let* _ = bump () in
      let* _ =
        if not options.remove_comment then pp (fun fmt -> Fmt.string fmt c)
        else return ()
      in
      comments' ()
    | _ -> return ()
  in
  comments' ()

let match' f =
  let open Let_syntax in
  let* c = current () in
  if f c then return c else fail "Not satisfied"

let is_token tok = match' (fun v -> v = tok)
