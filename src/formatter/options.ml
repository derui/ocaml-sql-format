type t =
  { (* keyword styling.
       - Upper is always upper case for keyword
       - Lower is alway lower case for keyword

       default is [`Upper]
    *)
    keyword : [ `Upper | `Lower ]
  ; reserved : unit
  }
[@@deriving show, eq]

let default = { keyword = `Upper; reserved = () }
