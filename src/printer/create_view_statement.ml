open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext create_view_statement

module Make
    (V : GEN with type t = ext qualified_table_name)
    (C : GEN with type t = ext column_name)
    (Select : GEN with type t = ext select_statement) : S = struct
  type t = ext create_view_statement

  let print f t ~option =
    match t with
    | Create_view_statement (temp, exists, name, cols, stmt, _) ->
      let kw =
        match temp with
        | Some _ -> [ Kw_create; Kw_temporary; Kw_view ]
        | None -> [ Kw_create; Kw_view ]
      in
      let kw =
        match exists with
        | Some _ -> kw @ [ Kw_if; Kw_not; Kw_exists ]
        | None -> kw
      in
      Sfmt.keyword ~option f kw;
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f name;

      Option.iter
        (fun cols ->
          Fmt.string f " ";
          Sfmt.parens_box ~option
            (fun f _ ->
              let c = List.hd cols
              and cs = List.tl cols in

              let module C = (val C.generate ()) in
              C.print ~option f c;

              List.iter
                (fun c ->
                  Sfmt.comma ~option f ();
                  C.print ~option f c)
                cs)
            f ())
        cols;

      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_as ];
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let module Select = (val Select.generate ()) in
          Select.print ~option f stmt)
        f ()
end
