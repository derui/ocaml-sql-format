open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext column_name_list

module Make (I : GEN with type t = ext identifier) : S = struct
  type t = ext column_name_list

  let print f t ~option =
    match t with
    | Column_name_list (fc, cl, _) ->
      let module I = (val I.generate ()) in
      I.print ~option f fc;

      List.iter
        (fun c ->
          Sfmt.comma ~option f ();
          I.print ~option f c)
        cl
end
