open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext window_clause

module Make
    (V : GEN with type t = ext window_name)
    (D : GEN with type t = ext window_defn) : S = struct
  type t = ext window_clause

  let print f t ~option =
    match t with
    | Window_clause (ds, _) ->
      let d = List.hd ds
      and ds = List.tl ds in

      Sfmt.keyword ~option f [ Kw_window ];
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let subprint (n, d) =
            let module V = (val V.generate ()) in
            V.print ~option f n;
            Fmt.string f " ";
            Sfmt.keyword ~option f [ Kw_as ];
            Fmt.string f " ";
            let module D = (val D.generate ()) in
            D.print ~option f d
          in
          subprint d;

          List.iter
            (fun d ->
              Token.print ~option f Tok_comma;
              Fmt.cut f ();
              subprint d)
            ds)
        f ()
end
