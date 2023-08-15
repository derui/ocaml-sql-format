open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext alter_table_statement

module Make
    (V : GEN with type t = ext qualified_table_name)
    (T : GEN with type t = ext table_name)
    (C : GEN with type t = ext column_name)
    (D : GEN with type t = ext column_def) : S = struct
  type t = ext alter_table_statement

  let print f t ~option =
    match t with
    | Alter_table_statement (qname, `rename_table tname, _) ->
      Sfmt.keyword ~option f [ Kw_alter; Kw_table ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f qname;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_rename; Kw_to ];
      let module T = (val T.generate ()) in
      T.print ~option f tname
    | Alter_table_statement (qname, `rename_col (oldname, newname), _) ->
      Sfmt.keyword ~option f [ Kw_alter; Kw_table ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f qname;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_rename; Kw_column ];
      Fmt.string f " ";
      let module C = (val C.generate ()) in
      C.print ~option f oldname;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_to ];
      Fmt.string f " ";
      C.print ~option f newname
    | Alter_table_statement (qname, `add def, _) ->
      Sfmt.keyword ~option f [ Kw_alter; Kw_table ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f qname;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_add; Kw_column ];
      Fmt.string f " ";
      let module D = (val D.generate ()) in
      D.print ~option f def
    | Alter_table_statement (qname, `drop cname, _) ->
      Sfmt.keyword ~option f [ Kw_alter; Kw_table ];
      Fmt.string f " ";
      let module V = (val V.generate ()) in
      V.print ~option f qname;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_drop; Kw_column ];
      Fmt.string f " ";
      let module C = (val C.generate ()) in
      C.print ~option f cname
end
