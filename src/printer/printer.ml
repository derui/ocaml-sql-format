module A = Types.Ast
module L = Types.Literal
module B = Types.Basic
module Options = Options

let identifier () = Identifier.((module Make () : S))

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

and schema_name () =
  Schema_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and table_name () =
  Table_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and column_name () =
  Column_name.(
    (module Make (struct
      type t = A.ext L.identifier

      let generate = identifier
    end) : S))

and type_name () =
  Type_name.(
    (module Make
              (struct
                type t = A.ext L.identifier

                let generate = identifier
              end)
              (struct
                type t = A.ext A.signed_number

                let generate = signed_number
              end) : S))

and signed_number () =
  Signed_number.(
    (module Make (struct
      type t = A.ext L.numeric_literal

      let generate = numeric_literal
    end) : S))

and qualified_name () =
  Qualified_name.(
    (module Make
              (struct
                type t = A.ext A.schema_name

                let generate = schema_name
              end)
              (struct
                type t = A.ext A.table_name

                let generate = table_name
              end)
              (struct
                type t = A.ext A.column_name

                let generate = column_name
              end) : S))
