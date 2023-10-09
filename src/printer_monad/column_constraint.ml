open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext column_constraint

module Make
    (Expr : GEN with type t = ext expr)
    (Collation_name : GEN with type t = ext collation_name)
    (Literal : GEN with type t = ext literal_value)
    (Signed : GEN with type t = ext signed_number)
    (FK : GEN with type t = ext foreign_key_constraint)
    (I : GEN with type t = ext identifier) : S = struct
  type t = ext column_constraint

  let print_name ~option f = function
    | Some v ->
      Sfmt.keyword ~option f [ Kw_constraint ];
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print ~option f v;
      Fmt.string f " "
    | None -> ()

  let print f t ~option =
    match t with
    | Column_constraint (n, `primary_key (odr, ai), _) ->
      print_name ~option f n;

      let kw = List.rev [ Kw_primary; Kw_key ] in
      let kw =
        match odr with
        | Some `asc -> Kw_asc :: kw
        | Some `desc -> Kw_desc :: kw
        | None -> kw
      in
      let kw =
        match ai with
        | Some _ -> Kw_auto_increment :: kw
        | None -> kw
      in
      Sfmt.keyword ~option f (List.rev kw)
    | Column_constraint (n, `not_null, _) ->
      print_name ~option f n;

      Sfmt.keyword ~option f [ Kw_not; Kw_null ]
    | Column_constraint (n, `unique, _) ->
      print_name ~option f n;

      Sfmt.keyword ~option f [ Kw_unique ]
    | Column_constraint (n, `check e, _) ->
      print_name ~option f n;

      Sfmt.keyword ~option f [ Kw_check ];
      Sfmt.parens ~option
        (fun f _ ->
          let module Expr = (val Expr.generate ()) in
          Expr.print ~option f e)
        f ()
    | Column_constraint (n, `default v, _) -> (
      print_name ~option f n;

      match v with
      | `expr e ->
        Sfmt.parens ~option
          (fun f _ ->
            let module Expr = (val Expr.generate ()) in
            Expr.print ~option f e)
          f ()
      | `literal l ->
        let module Literal = (val Literal.generate ()) in
        Literal.print ~option f l
      | `signed l ->
        let module Signed = (val Signed.generate ()) in
        Signed.print ~option f l)
    | Column_constraint (n, `collate name, _) ->
      print_name ~option f n;

      let module Collation_name = (val Collation_name.generate ()) in
      Collation_name.print ~option f name
    | Column_constraint (n, `foreign_key fk, _) ->
      print_name ~option f n;

      let module FK = (val FK.generate ()) in
      FK.print ~option f fk
    | Column_constraint (n, `generated e, _) ->
      print_name ~option f n;

      Sfmt.keyword ~option f [ Kw_generated; Kw_always; Kw_as ];
      Fmt.string f " ";
      Sfmt.parens ~option
        (fun f _ ->
          let module Expr = (val Expr.generate ()) in
          Expr.print ~option f e)
        f ()
end
