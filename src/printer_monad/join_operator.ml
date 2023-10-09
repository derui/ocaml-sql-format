open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext join_operator

module Make () : S = struct
  type t = ext join_operator

  let print f t ~option =
    match t with
    | Join_operator (`comma, _) -> Token.print ~option f Tok_comma
    | Join_operator (`cross, _) -> Sfmt.keyword ~option f [ Kw_cross; Kw_join ]
    | Join_operator (`simple, _) -> Sfmt.keyword ~option f [ Kw_join ]
    | Join_operator (`natural, _) ->
      Sfmt.keyword ~option f [ Kw_natural; Kw_join ]
    | Join_operator (`inner (Some _), _) ->
      Sfmt.keyword ~option f [ Kw_natural; Kw_inner; Kw_join ]
    | Join_operator (`inner None, _) ->
      Sfmt.keyword ~option f [ Kw_inner; Kw_join ]
    | Join_operator (`outer (Some _, kw), _) ->
      let kw =
        match kw with
        | `left -> Kw_left
        | `right -> Kw_right
        | `full -> Kw_full
      in
      Sfmt.keyword ~option f [ Kw_natural; kw; Kw_outer; Kw_join ]
    | Join_operator (`outer (None, kw), _) ->
      let kw =
        match kw with
        | `left -> Kw_left
        | `right -> Kw_right
        | `full -> Kw_full
      in
      Sfmt.keyword ~option f [ kw; Kw_outer; Kw_join ]
end
