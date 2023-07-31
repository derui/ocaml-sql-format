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
    (Type_name : GEN with type t = ext type_name)
    (Collation_name : GEN with type t = ext collation_name)
    (Select_statement : GEN with type t = ext select_statement)
    (Schema_name : GEN with type t = ext schema_name)
    (Table_name : GEN with type t = ext table_name)
    (Function : GEN with type t = ext function') : S = struct
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
    | Expr (`function' v, _) ->
      let module Function = (val Function.generate ()) in
      Function.print ~option f v
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
    | Expr (`collate (e, cname), _) ->
      print ~option f e;
      Fmt.string f " ";
      Token.print ~option f Kw_collate;
      Fmt.string f " ";
      let module Collation_name = (val Collation_name.generate ()) in
      Collation_name.print ~option f cname
    | Expr (`like (e, not', e2, escape), _) ->
      print ~option f e;
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';

      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_like ];
      Fmt.string f " ";
      print ~option f e2;

      Option.iter
        (fun e ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_escape ];
          Fmt.string f " ";
          print ~option f e)
        escape
    | Expr (`glob (e, not', e2), _) ->
      print ~option f e;
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_glob ];
      Fmt.string f " ";
      print ~option f e2
    | Expr (`regexp (e, not', e2), _) ->
      print ~option f e;
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_regexp ];
      Fmt.string f " ";
      print ~option f e2
    | Expr (`match' (e, not', e2), _) ->
      print ~option f e;
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_match ];
      Fmt.string f " ";
      print ~option f e2
    | Expr (`is (e, not', e2), _) ->
      print ~option f e;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_is ];
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';
      Fmt.string f " ";
      print ~option f e2
    | Expr (`is_distinct (e, not', e2), _) ->
      print ~option f e;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_is ];
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_distinct; Kw_from ];
      Fmt.string f " ";
      print ~option f e2
    | Expr (`between (e, not', ef, el), _) ->
      print ~option f e;
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_between ];
      Fmt.string f " ";
      print ~option f ef;
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_and ];
      Fmt.string f " ";
      print ~option f el
    | Expr (`in' (e, not', v), _) -> (
      print ~option f e;
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_in ];
      Fmt.string f " ";

      match v with
      | `stmt v ->
        Sfmt.parens ~indent:() ~option
          (fun f _ ->
            let module Select_statement = (val Select_statement.generate ()) in
            Select_statement.print ~option f v)
          f ()
      | `expr v ->
        Sfmt.parens ~indent:() ~option
          (fun f _ ->
            let e = List.hd v
            and es = List.tl v in
            print ~option f e;

            List.iter
              (fun e ->
                Sfmt.comma ~option f ();
                print ~option f e)
              es)
          f ()
      | `table (sname, tname) ->
        Option.iter
          (fun v ->
            let module Schema_name = (val Schema_name.generate ()) in
            Schema_name.print ~option f v;
            Token.print ~option f Tok_period)
          sname;

        let module Table_name = (val Table_name.generate ()) in
        Table_name.print ~option f tname
      | `function' (sname, name, es) ->
        Option.iter
          (fun v ->
            let module Schema_name = (val Schema_name.generate ()) in
            Schema_name.print ~option f v;
            Token.print ~option f Tok_period)
          sname;

        let module Fname = (val Fname.generate ()) in
        Fname.print ~option f name;
        Sfmt.parens ~option
          (fun f _ ->
            let e = List.hd es
            and es = List.tl es in

            print ~option f e;
            List.iter
              (fun e ->
                Sfmt.comma ~option f ();
                print ~option f e)
              es)
          f ())
    | Expr (`exists (e, not', stmt), _) ->
      print ~option f e;
      Option.iter
        (fun _ ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_not ])
        not';
      Fmt.string f " ";
      Sfmt.keyword ~option f [ Kw_exists ];
      Fmt.string f " ";
      Sfmt.parens ~indent:() ~option
        (fun f _ ->
          let module Select_statement = (val Select_statement.generate ()) in
          Select_statement.print ~option f stmt)
        f ()
    | Expr (`case (e, l, els), _) ->
      Sfmt.keyword ~option f [ Kw_case ];
      Option.iter
        (fun e ->
          Fmt.string f " ";
          print ~option f e)
        e;

      List.iter
        (fun (e1, e2) ->
          Fmt.cut f ();
          Sfmt.keyword ~option f [ Kw_when ];
          Fmt.string f " ";
          print ~option f e1;
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_then ];
          Fmt.string f " ";
          print ~option f e2)
        l;

      Option.iter
        (fun e ->
          Fmt.cut f ();
          Sfmt.keyword ~option f [ Kw_else ];
          Fmt.string f " ";
          print ~option f e)
        els;

      Fmt.cut f ();
      Sfmt.keyword ~option f [ Kw_end ]
end
