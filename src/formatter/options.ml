type t =
  { (* keyword styling.
       - Upper is always upper case for keyword
       - Lower is alway lower case for keyword
       - Keep is keep input case
    *)
    keyword : [ `Upper | `Lower | `Keep ]
  }
[@@deriving show, eq]

let default = { keyword = `Upper }
