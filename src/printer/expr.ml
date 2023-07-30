open Types.Ast
open Types.Literal
open Intf

module type S = PRINTER with type t = ext expr

module Make
    (V : GEN with type t = ext literal_value)
    (Parameter : GEN with type t = ext bind_parameter)
    (Name : GEN with type t = ext qualified_name)
    (Unary : GEN with type t = ext unary_operator)
    (Binary : GEN with type t = ext binary_operator)
    (Fname : GEN with type t = ext function_name)
    (Type_name : GEN with type t = ext type_name) : S = struct
  type t = ext expr

  let rec print f t ~option =
    match t with
    | Expr (`literal v, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f v
    | Expr (`parameter v, _) ->
      let module Parameter = (val Parameter.generate ()) in
      Parameter.print ~option f v
    | Expr (`name v, _) ->
      let module Name = (val Name.generate ()) in
      Name.print ~option f v
    | Expr (`unary (op, v), _) ->
      let module Unary = (val Unary.generate ()) in
      Unary.print ~option f op;
      print ~option f v
    | Expr (`binary (e, op, e2), _) ->
      print ~option f e;
      let module Binary = (val Binary.generate ()) in
      Binary.print ~option f op;
      print ~option f e2
    | Expr (`function' (fname, typ), _) ->
      let module Fname = (val Fname.generate ()) in
      Fname.print ~option f fname;
      Sfmt.parens ~option
        (fun f _ ->
          match typ with
          | `no_arg -> ()
          | `asterisk -> Token.print ~option f Op_star
          | `exprs (distinct, es) ->
            Option.iter
              (fun _ ->
                Token.print ~option f Kw_distinct;
                Fmt.string f " ")
              distinct;

            let e = List.hd es
            and es = List.tl es in
            print ~option f e;

            List.iter
              (fun e ->
                Sfmt.comma ~option f ();
                print ~option f e)
              es)
        f ()
    | Expr (`nested es, _) ->
      let e = List.hd es in
      let es = List.tl es in
      print ~option f e;

      List.iter
        (fun e ->
          Sfmt.comma ~option f ();
          print ~option f e)
        es
    | Expr (`cast (e, tname), _) ->
      Token.print ~option f Kw_cast;
      Sfmt.parens ~option
        (fun f _ ->
          print ~option f e;
          Fmt.string f " ";
          Token.print ~option f Kw_as;
          Fmt.string f " ";
          let module Type_name = (val Type_name.generate ()) in
          Type_name.print ~option f tname)
        f ()
end
