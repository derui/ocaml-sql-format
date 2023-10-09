open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_constraint

module Make
    (V : GEN with type t = ext expr)
    (C : GEN with type t = ext column_name) : S = struct
  type t = ext join_constraint

  let print f t ~option =
    match t with
    | Join_constraint (`expr e, _) ->
      Sfmt.keyword ~option f [ Kw_on ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Join_constraint (`using ds, _) ->
      Sfmt.keyword ~option f [ Kw_using ];
      Fmt.string f " ";

      Sfmt.parens ~option
        (fun f _ ->
          let c = List.hd ds in
          let cs = List.tl ds in
          let module C = (val C.generate ()) in
          C.print ~option f c;

          List.iter
            (fun c ->
              Sfmt.comma ~option f ();
              C.print ~option f c)
            cs)
        f ()
end
