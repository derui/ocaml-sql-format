open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext from_clause

module Make (V : GEN with type t = ext table_or_subquery) : S = struct
  type t = ext from_clause

  let print f t ~option =
    match t with
    | From_clause (`table_or_subquery ts, _) -> (
      match ts with
      | [] -> failwith "Invalid path"
      | d :: ds ->
        Sfmt.keyword ~option f [ Kw_from ];

        Sfmt.force_vbox option.indent_size
          (fun f _ ->
            let module V = (val V.generate ()) in
            V.print ~option f d;

            List.iter (fun v -> V.print ~option f v) ds)
          f ())
end
