module A = Types.Ast
module L = Types.Literal
module B = Types.Basic
module Options = Options

let rec literal_value () =
  Literal_value.(
    (module Make
              (struct
                type t = A.ext L.string_literal

                let generate = string_literal
              end)
              (struct
                type t = A.ext L.numeric_literal

                let generate = numeric_literal
              end)
              (struct
                type t = A.ext L.blob_literal

                let generate = blob_literal
              end) : S))

and numeric_literal () = Numeric_literal.((module Make () : S))

and string_literal () = String_literal.((module Make () : S))

and blob_literal () = Blob_literal.((module Make () : S))

and bind_parameter () = Bind_parameter.((module Make () : S))
