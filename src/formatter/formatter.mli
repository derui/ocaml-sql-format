(** [from_channel chan ~option] format file from channel *)
val from_channel : in_channel -> option:unit -> string

(** [from_string str ~option] format statements from string *)
val from_string : string -> option:unit -> string
