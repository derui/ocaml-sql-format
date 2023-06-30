type t =
  { (* keyword styling.
       - Upper is always upper case for keyword
       - Lower is alway lower case for keyword

       default is [`Upper]
    *)
    keyword : [ `Upper | `Lower ]
        (* indent size per nest / newline. Default value is [4]. indent value must be greater than 0  *)
  ; indent_size : int
  ; reserved : unit
  }
[@@deriving show, eq]

let default = { keyword = `Upper; indent_size = 4; reserved = () }
