type t =
  { (* keyword styling.
       - Upper is always upper case for keyword
       - Lower is alway lower case for keyword

       default is [`Upper]
    *)
    keyword : [ `Upper | `Lower ]
        (* indent size per nest / newline. Default value is [4]. indent value must be greater than 0  *)
  ; indent_size : int
        (* insert newline between with element list. Default is true  *)
  ; need_newline_between_elements : bool
        (* maximum line length. Default is 100 *)
  ; max_line_length : int
  ; reserved : unit
  }
[@@deriving show, eq]

let default =
  { keyword = `Upper
  ; indent_size = 4
  ; need_newline_between_elements = true
  ; max_line_length = 100
  ; reserved = ()
  }
