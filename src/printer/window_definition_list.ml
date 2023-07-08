open Types.Ast
open Intf

module type S = PRINTER with type t = ext window_definition_list

module Make (Def : GEN with type t = ext window_definition) : S = struct
  type t = ext window_definition_list

  let print f t ~option =
    match t with
    | Window_definition_list (fl, list, _) ->
      let module Def = (val Def.generate ()) in
      Def.print ~option f fl;

      List.iter
        (fun v ->
          Sfmt.comma ~option f ();
          Def.print ~option f v)
        list
end
