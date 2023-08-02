open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext common_table_expression

module Make
    (Table_name : GEN with type t = ext table_name)
    (Column_name : GEN with type t = ext column_name)
    (Select : GEN with type t = ext select_statement) : S = struct
  type t = ext common_table_expression

  let print f t ~option =
    match t with
    | Common_table_expression (tname, columns, mat, stmt, _) ->
      let module Table_name = (val Table_name.generate ()) in
      Table_name.print ~option f tname;

      Option.iter
        (fun cols ->
          Fmt.string f " ";
          Sfmt.parens ~option
            (fun f _ ->
              let c = List.hd cols
              and cs = List.tl cols in

              let module Column_name = (val Column_name.generate ()) in
              Column_name.print ~option f c;

              List.iter
                (fun c ->
                  Sfmt.comma ~option f ();
                  Column_name.print ~option f c)
                cs)
            f ())
        columns;
      let kw =
        match mat with
        | None -> [ Kw_as ]
        | Some `not_materialized -> [ Kw_as; Kw_not; Kw_materialized ]
        | Some `materialized -> [ Kw_as; Kw_materialized ]
      in
      Sfmt.keyword ~option f kw;
      Fmt.string f " ";

      Sfmt.parens ~indent:() ~option
        (fun f _ ->
          let module Select = (val Select.generate ()) in
          Select.print ~option f stmt)
        f ()
end
