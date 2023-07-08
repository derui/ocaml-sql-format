open Types.Ast
open Intf

module type S = PRINTER with type t = ext table_expression

module Make
    (F : GEN with type t = ext from_clause)
    (Where : GEN with type t = ext where_clause)
    (Group : GEN with type t = ext group_by_clause)
    (Having : GEN with type t = ext having_clause)
    (Window : GEN with type t = ext window_clause) : S = struct
  type t = ext table_expression

  let print f t ~option =
    match t with
    | Table_expression (from, where, group, having, window, _) ->
      let module F = (val F.generate ()) in
      F.print ~option f from;

      Option.iter
        (fun i ->
          Fmt.cut f ();
          let module Where = (val Where.generate ()) in
          Where.print ~option f i)
        where;
      Option.iter
        (fun i ->
          Fmt.cut f ();
          let module Group = (val Group.generate ()) in
          Group.print ~option f i)
        group;
      Option.iter
        (fun i ->
          Fmt.cut f ();
          let module Having = (val Having.generate ()) in
          Having.print ~option f i)
        having;
      Option.iter
        (fun i ->
          Fmt.cut f ();
          let module Window = (val Window.generate ()) in
          Window.print ~option f i)
        window
end
