open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext foreign_key_clause

module Make
    (Q : GEN with type t = ext qualified_table_name)
    (C : GEN with type t = ext column_name)
    (I : GEN with type t = ext identifier) : S = struct
  type t = ext foreign_key_clause

  let print_cs ~option f = function
    | None -> ()
    | Some cs ->
      let c = List.hd cs
      and cs = List.tl cs in

      let module C = (val C.generate ()) in
      Sfmt.parens ~option
        (fun f _ ->
          C.print ~option f c;

          List.iter
            (fun c ->
              Sfmt.comma ~option f ();
              C.print ~option f c)
            cs)
        f ()

  let print f t ~option =
    match t with
    | Foreign_key_clause (n, cs, `trigger (typ, opt), _) ->
      let module Q = (val Q.generate ()) in
      Q.print ~option f n;

      print_cs ~option f cs;
      Fmt.string f " ";

      let kw =
        match typ with
        | `delete -> [ Kw_on; Kw_delete ]
        | `update -> [ Kw_on; Kw_update ]
      in
      let kw =
        match opt with
        | `set_null -> List.append kw [ Kw_set; Kw_null ]
        | `set_default -> List.append kw [ Kw_set; Kw_default ]
        | `cascade -> List.append kw [ Kw_cascade ]
        | `restrict -> List.append kw [ Kw_restrict ]
        | `no_action -> List.append kw [ Kw_no; Kw_action ]
      in
      Fmt.string f " ";
      Sfmt.keyword ~option f kw
    | Foreign_key_clause (n, cs, `match' name, _) ->
      let module Q = (val Q.generate ()) in
      Q.print ~option f n;

      print_cs ~option f cs;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_match ];
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print ~option f name
    | Foreign_key_clause (n, cs, `deferrable (not', opt), _) ->
      let module Q = (val Q.generate ()) in
      Q.print ~option f n;

      print_cs ~option f cs;
      Fmt.string f " ";
      let kw =
        match not' with
        | None -> [ Kw_deferrable ]
        | Some _ -> [ Kw_not; Kw_deferrable ]
      in
      let kw =
        match opt with
        | None -> kw
        | Some `deferred -> List.append kw [ Kw_initially; Kw_deferred ]
        | Some `immediate -> List.append kw [ Kw_initially; Kw_immediate ]
      in

      Sfmt.keyword ~option f kw
end
