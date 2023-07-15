open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext national_character_string_type

module Make
    (V : GEN with type t = ext length)
    (L : GEN with type t = ext large_object_length) : S = struct
  type t = ext national_character_string_type

  let print f t ~option =
    match t with
    | National_character_string_type (`character l, _) ->
      Sfmt.keyword ~option f [ Kw_national; Kw_character ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f l)
            f ())
        l
    | National_character_string_type (`char l, _) ->
      Sfmt.keyword ~option f [ Kw_national; Kw_char ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f l)
            f ())
        l
    | National_character_string_type (`nchar l, _) ->
      Sfmt.keyword ~option f [ Kw_nchar ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f l)
            f ())
        l
    | National_character_string_type (`character_varying l, _) ->
      Sfmt.keyword ~option f [ Kw_national; Kw_character; Kw_varying ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f l)
            f ())
        l
    | National_character_string_type (`char_varying l, _) ->
      Sfmt.keyword ~option f [ Kw_national; Kw_char; Kw_varying ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f l)
            f ())
        l
    | National_character_string_type (`nchar_varying l, _) ->
      Sfmt.keyword ~option f [ Kw_nchar; Kw_varying ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module V = (val V.generate ()) in
              V.print ~option f l)
            f ())
        l
    | National_character_string_type (`character_large_object l, _) ->
      Sfmt.keyword ~option f [ Kw_national; Kw_character; Kw_large; Kw_object ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module L = (val L.generate ()) in
              L.print ~option f l)
            f ())
        l
    | National_character_string_type (`nchar_large_object l, _) ->
      Sfmt.keyword ~option f [ Kw_nchar; Kw_large; Kw_object ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module L = (val L.generate ()) in
              L.print ~option f l)
            f ())
        l
    | National_character_string_type (`nclob l, _) ->
      Sfmt.keyword ~option f [ Kw_nclob ];
      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module L = (val L.generate ()) in
              L.print ~option f l)
            f ())
        l
end
