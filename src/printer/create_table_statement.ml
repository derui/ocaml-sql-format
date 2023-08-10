open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext create_table_statement

module Make
    (Q : GEN with type t = ext qualified_table_name)
    (S : GEN with type t = ext select_statement)
    (Def : GEN with type t = ext column_def)
    (TC : GEN with type t = ext table_constraint) : S = struct
  type t = ext create_table_statement

  let print_header ~option f = function
    | Some _ -> Sfmt.keyword ~option f [ Kw_create; Kw_temporary; Kw_table ]
    | None -> Sfmt.keyword ~option f [ Kw_create; Kw_table ]

  let print_exists ~option f = function
    | Some _ ->
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_if; Kw_not; Kw_exists ];
      Fmt.string f " "
    | None -> ()

  let print f t ~option =
    match t with
    | Create_table_statement (temp, exists, qname, `select stmt, _) ->
      print_header ~option f temp;
      print_exists ~option f exists;
      let module Q = (val Q.generate ()) in
      Q.print ~option f qname;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_as ];
      Fmt.string f " ";
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let module S = (val S.generate ()) in
          S.print ~option f stmt)
        f ()
    | Create_table_statement
        (temp, exists, qname, `def (coldefs, constraints), _) ->
      print_header ~option f temp;
      print_exists ~option f exists;
      let module Q = (val Q.generate ()) in
      Q.print ~option f qname;
      Fmt.string f " ";
      Sfmt.parens_box ~option
        (fun f _ ->
          let coldef = List.hd coldefs
          and coldefs = List.tl coldefs in

          let module Def = (val Def.generate ()) in
          Def.print ~option f coldef;

          List.iter
            (fun coldef ->
              Sfmt.comma ~option f ();
              Fmt.cut f ();
              Def.print ~option f coldef)
            coldefs;

          let module TC = (val TC.generate ()) in
          List.iter
            (fun cs ->
              Sfmt.comma ~option f ();
              Fmt.cut f ();
              TC.print ~option f cs)
            constraints)
        f ()
end
