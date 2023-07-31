open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext select_clause

module Make (V : GEN with type t = ext result_column) : S = struct
  type t = ext select_clause

  let print f t ~option =
    match t with
    | Select_clause (q, l, _) ->
      let kw =
        match q with
        | Some `distinct -> [ Kw_select; Kw_distinct ]
        | Some `all -> [ Kw_select; Kw_all ]
        | None -> [ Kw_select ]
      in
      Sfmt.keyword ~option f kw;

      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          match l with
          | [] -> failwith "invalid path"
          | d :: ds ->
            let module V = (val V.generate ()) in
            V.print ~option f d;

            List.iter
              (fun v ->
                Token.print ~option f Tok_comma;
                Fmt.cut f ();
                V.print ~option f v)
              ds)
        f ();
      Sfmt.newline f ()
end
