open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext partition_clause

module Make (V : GEN with type t = ext expr) : S = struct
  type t = ext partition_clause

  let print f t ~option =
    match t with
    | Partition_clause (es, _) ->
      Sfmt.keyword ~option f [ Kw_partition; Kw_by ];
      Fmt.string f " ";

      let e = List.hd es
      and es = List.tl es in

      let module V = (val V.generate ()) in
      V.print ~option f e;

      List.iter
        (fun e ->
          Sfmt.comma ~option f ();
          V.print ~option f e)
        es
end
