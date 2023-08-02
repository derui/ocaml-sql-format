open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext with_clause

module Make (V : GEN with type t = ext common_table_expression) : S = struct
  type t = ext with_clause

  let print f t ~option =
    match t with
    | With_clause (o, cs, _) ->
      let kw =
        match o with
        | None -> [ Kw_with ]
        | Some _ -> [ Kw_with; Kw_recursive ]
      in
      Sfmt.keyword ~option f kw;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      let c = List.hd cs
      and cs = List.tl cs in
      V.print ~option f c;
      Sfmt.newline f ();
      List.iter
        (fun c ->
          Sfmt.comma ~option f ();
          V.print ~option f c;
          Sfmt.newline f ())
        cs
end
