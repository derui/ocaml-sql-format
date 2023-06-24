open Types.Ast
open Intf

module type S = PRINTER with type t = ext query

module Make
    (Select : GEN with type t = ext select_clause)
    (Into : GEN with type t = ext into_clause)
    (From : GEN with type t = ext from_clause) : S = struct
  type t = ext query

  let print f t ~option =
    match t with
    | Query (clause, into, from, _) ->
      let module Select = (val Select.generate ()) in
      Select.print f clause ~option;
      Option.iter
        (fun v ->
          let module Into = (val Into.generate ()) in
          Fmt.string f " ";
          Into.print f ~option v)
        into;
      Option.iter
        (fun v ->
          let module From = (val From.generate ()) in
          Fmt.string f " ";
          From.print f ~option v)
        from
end
