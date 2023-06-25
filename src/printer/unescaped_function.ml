open Types.Ast
open Intf

module type S = PRINTER with type t = ext unescaped_function

module Make
    (TAF : GEN with type t = ext text_aggregate_function)
    (SAF : GEN with type t = ext standard_aggregate_function)
    (Filter_clause : GEN with type t = ext filter_clause)
    (Window_spec : GEN with type t = ext window_specification) : S = struct
  type t = ext unescaped_function

  let print f t ~option =
    match t with
    | Unescaped_function (`text_aggregate_function (taf, filter, window)) ->
      let module TAF = (val TAF.generate ()) in
      TAF.print f taf ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module Filter_clause = (val Filter_clause.generate ()) in
          Filter_clause.print f v ~option)
        filter;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module Window_spec = (val Window_spec.generate ()) in
          Window_spec.print f v ~option)
        window
    | Unescaped_function (`standard_aggregate_function (saf, filter, window)) ->
      let module SAF = (val SAF.generate ()) in
      SAF.print f saf ~option;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module Filter_clause = (val Filter_clause.generate ()) in
          Filter_clause.print f v ~option)
        filter;

      Option.iter
        (fun v ->
          Fmt.string f " ";
          let module Window_spec = (val Window_spec.generate ()) in
          Window_spec.print f v ~option)
        window
end
