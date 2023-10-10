module Token = Types.Token

module Parse_error = struct
  type t =
    { start_pos : Lexing.position
    ; end_pos : Lexing.position
    ; message : string
    }
end

(** Type of monad. *)
type data =
  { mutable current : Token.token option
  ; fmt : Format.formatter
  ; lexer : unit -> Token.token
  ; options : Options.t
  ; position : unit -> Lexing.position * Lexing.position
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

module Syntax = struct
  let ( >>= ) = bind

  let ( <$> ) = map

  let ( <*> ) = apply

  (** evaluate [x] and [y], then return only result of [y] *)
  let ( *> ) x y = (fun _ y -> y) <$> x <*> y
end

module Let_syntax = struct
  let ( let* ) = bind
end

let data () data = Ok (data, data)

let fail v =
  let open Let_syntax in
  let* data' = data () in
  let startp, endp = data'.position () in
  fun _ -> Error { Parse_error.start_pos = startp; end_pos = endp; message = v }

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

(** indent by size *)
let indent_by size =
  let open Let_syntax in
  let* data' = data () in
  let fmt = data'.fmt in
  Format.pp_print_break fmt 0 size;

  return (fun ppf -> (Fmt.vbox ~indent:0 ppf) fmt ())

(** indent by size in option *)
let indent () =
  let open Let_syntax in
  let* data' = data () in
  indent_by data'.options.indent_size

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
let skip_comments () =
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
