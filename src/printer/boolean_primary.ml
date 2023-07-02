open Types.Ast
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
    (In : GEN with type t = ext in_predicate)
    (Is_distinct : GEN with type t = ext is_distinct)
    (Exists : GEN with type t = ext exists_predicate) : S = struct
  type t = ext boolean_primary

  let print f t ~option =
    match t with
    | Boolean_primary (value, predicate, _) ->
      let module Cve = (val Cve.generate ()) in
      Cve.print f value ~option;

      Option.iter
        (function
          | `comparison (_ as v) ->
            let module Comp = (val Comp.generate ()) in
            Fmt.sp f ();
            Comp.print f v ~option
          | `is_null (_ as v) ->
            let module Is_null = (val Is_null.generate ()) in
            Fmt.sp f ();
            Is_null.print f v ~option
          | `between (_ as v) ->
            let module Between = (val Between.generate ()) in
            Fmt.sp f ();
            Between.print f v ~option
          | `like_regex (_ as v) ->
            let module Like_regex = (val Like_regex.generate ()) in
            Fmt.sp f ();
            Like_regex.print f v ~option
          | `match' (_ as v) ->
            let module Match = (val Match.generate ()) in
            Fmt.sp f ();
            Match.print f v ~option
          | `quantified (_ as v) ->
            let module Quantified = (val Quantified.generate ()) in
            Fmt.sp f ();
            Quantified.print f v ~option
          | `in' (_ as v) ->
            let module In = (val In.generate ()) in
            Fmt.sp f ();
            In.print f v ~option
          | `is_distinct (_ as v) ->
            let module Is_distinct = (val Is_distinct.generate ()) in
            Fmt.sp f ();
            Is_distinct.print f v ~option
          | `exists (_ as v) ->
            let module Exists = (val Exists.generate ()) in
            Fmt.sp f ();
            Exists.print f v ~option)
        predicate
end
