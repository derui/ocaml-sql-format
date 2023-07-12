open Types.Ast
open Intf

module type S = PRINTER with type t = ext multiset_value_constructor

module Make
    (V : GEN with type t = ext multiset_value_constructor_by_enumeration)
    (MQ : GEN with type t = ext multiset_value_constructor_by_query)
    (TQ : GEN with type t = ext table_value_constructor_by_query) : S = struct
  type t = ext multiset_value_constructor

  let print f t ~option =
    match t with
    | Multiset_value_constructor (`enum e, _) ->
      let module V = (val V.generate ()) in
      V.print ~option f e
    | Multiset_value_constructor (`multi_query e, _) ->
      let module MQ = (val MQ.generate ()) in
      MQ.print ~option f e
    | Multiset_value_constructor (`table_query e, _) ->
      let module TQ = (val TQ.generate ()) in
      TQ.print ~option f e
end
