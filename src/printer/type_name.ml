open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext type_name

module Make
    (V : GEN with type t = ext identifier)
    (N : GEN with type t = ext signed_number) : S = struct
  type t = ext type_name

  let print_names f t ~option =
    let module V = (val V.generate ()) in
    match t with
    | [] -> failwith "invalid path"
    | name :: rest ->
      V.print ~option f name;
      List.iter
        (fun v ->
          Fmt.string f " ";
          V.print ~option f v)
        rest

  let print f t ~option =
    match t with
    | Type_name (names, `name_only, _) -> print_names ~option f names
    | Type_name (names, `array, _) ->
      print_names ~option f names;
      Token.print ~option f Tok_lsbrace;
      Token.print ~option f Tok_rsbrace
    | Type_name (names, `size size, _) ->
      print_names ~option f names;
      Sfmt.parens ~option
        (fun f _ ->
          let module N = (val N.generate ()) in
          N.print ~option f size)
        f ()
    | Type_name (names, `with_max (size, max_size), _) ->
      print_names ~option f names;
      Sfmt.parens ~option
        (fun f _ ->
          let module N = (val N.generate ()) in
          N.print ~option f size;
          Sfmt.comma ~option f ();
          N.print ~option f max_size)
        f ()
end
