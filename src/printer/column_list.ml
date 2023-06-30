open Types.Ast
open Intf

module type S = PRINTER with type t = ext column_list

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext column_list

  let print f t ~option =
    match t with
    | Column_list (list, _) ->
      let module I = (val I.generate ()) in
      let pf fmt () =
        match list with
        | [] -> failwith "Invalid parsing"
        | fst :: rest ->
          I.print fmt fst ~option;
          List.iter
            (fun v ->
              Sfmt.comma ~option fmt ();
              I.print fmt v ~option)
            rest
      in
      Sfmt.parens ~option pf f ()
end
