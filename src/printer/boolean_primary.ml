open Parser.Ast
open Intf

module type S = PRINTER with type t = ext boolean_primary

module Make
    (Cve : GEN with type t = ext common_value_expression)
    (Comp : GEN with type t = ext comparison_predicate)
    (Is_null : GEN with type t = ext is_null_predicate)
    (Between : GEN with type t = ext between_predicate)
    (Like_regex : GEN with type t = ext like_regex_predicate)
    (Match : GEN with type t = ext match_predicate)
    (Quantified : GEN with type t = ext quantified_comparison_predicate)
    (In : GEN with type t = ext in_predicate) : S = struct
  type t = ext boolean_primary

  let print f t ~option =
    match t with
    | `Boolean_primary (value, predicate, _) ->
      let module Cve = (val Cve.generate ()) in
      Cve.print f value ~option;

      Option.iter
        (function
          | `comparison (_ as v) ->
            let module Comp = (val Comp.generate ()) in
            Fmt.string f " ";
            Comp.print f v ~option
          | `is_null (_ as v) ->
            let module Is_null = (val Is_null.generate ()) in
            Fmt.string f " ";
            Is_null.print f v ~option
          | `between (_ as v) ->
            let module Between = (val Between.generate ()) in
            Fmt.string f " ";
            Between.print f v ~option
          | `like_regex (_ as v) ->
            let module Like_regex = (val Like_regex.generate ()) in
            Fmt.string f " ";
            Like_regex.print f v ~option
          | `match' (_ as v) ->
            let module Match = (val Match.generate ()) in
            Fmt.string f " ";
            Match.print f v ~option
          | `quantified (_ as v) ->
            let module Quantified = (val Quantified.generate ()) in
            Fmt.string f " ";
            Quantified.print f v ~option
          | `in' (_ as v) ->
            let module In = (val In.generate ()) in
            Fmt.string f " ";
            In.print f v ~option)
        predicate
end
