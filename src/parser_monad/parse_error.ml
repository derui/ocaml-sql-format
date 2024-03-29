(** error type for parsing *)
type t =
  { start_pos : Lexing.position
  ; end_pos : Lexing.position
  ; message : string
  }

let to_string t = t.message
