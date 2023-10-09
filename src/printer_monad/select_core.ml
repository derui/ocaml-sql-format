open Types.Ast
open Intf

module type S = PRINTER with type t = ext select_core

module Make
    (V : GEN with type t = ext select_clause)
    (From : GEN with type t = ext from_clause)
    (Where : GEN with type t = ext where_clause)
    (Group : GEN with type t = ext group_by_clause)
    (Having : GEN with type t = ext having_clause)
    (Window : GEN with type t = ext window_clause) : S = struct
  type t = ext select_core

  let print f t ~option =
    match t with
    | Select_core (`select (s, from, wh, g, h, wi), _) ->
      let module V = (val V.generate ()) in
      V.print ~option f s;

      Option.iter
        (fun from ->
          Fmt.cut f ();
          let module From = (val From.generate ()) in
          From.print ~option f from)
        from;

      Option.iter
        (fun wh ->
          Fmt.cut f ();
          let module Where = (val Where.generate ()) in
          Where.print ~option f wh)
        wh;

      Option.iter
        (fun g ->
          Fmt.cut f ();
          let module Group = (val Group.generate ()) in
          Group.print ~option f g)
        g;

      Option.iter
        (fun h ->
          Fmt.cut f ();
          let module Having = (val Having.generate ()) in
          Having.print ~option f h)
        h;

      Option.iter
        (fun wi ->
          Fmt.cut f ();
          let module Window = (val Window.generate ()) in
          Window.print ~option f wi)
        wi
end
