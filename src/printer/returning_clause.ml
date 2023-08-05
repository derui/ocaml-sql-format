open Types.Ast
open Types.Literal
open Types.Token
open Intf

module type S = PRINTER with type t = ext returning_clause

module Make
    (V : GEN with type t = ext identifier)
    (E : GEN with type t = ext expr) : S = struct
  type t = ext returning_clause

  let print_expr ~option f = function
    | `asterisk -> Token.print ~option f Op_star
    | `expr (e, alias) ->
      let module E = (val E.generate ()) in
      E.print ~option f e;
      Option.iter
        (fun v ->
          Fmt.string f " ";
          Sfmt.keyword ~option f [ Kw_as ];
          Fmt.string f " ";
          let module V = (val V.generate ()) in
          V.print ~option f v)
        alias

  let print f t ~option =
    match t with
    | Returning_clause (es, _) ->
      Sfmt.keyword ~option f [ Kw_returning ];
      Fmt.string f " ";

      let e = List.hd es
      and es = List.tl es in

      print_expr ~option f e;
      List.iter
        (fun e ->
          Sfmt.comma ~option f ();
          print_expr ~option f e)
        es
end
