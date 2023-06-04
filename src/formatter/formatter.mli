module Options : sig
  include module type of Options
end

(** [from_channel chan ~option] format file from channel *)
val from_channel : in_channel -> option:Options.t -> string

(** [from_string str ~option] format statements from string *)
val from_string : string -> option:Options.t -> string
