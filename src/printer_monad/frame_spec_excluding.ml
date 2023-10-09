open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext frame_spec_excluding

module Make () : S = struct
  type t = ext frame_spec_excluding

  let print f t ~option =
    match t with
    | Frame_spec_excluding (`no_others, _) ->
      Sfmt.keyword ~option f [ Kw_exclude; Kw_no; Kw_others ]
    | Frame_spec_excluding (`current_row, _) ->
      Sfmt.keyword ~option f [ Kw_exclude; Kw_current; Kw_row ]
    | Frame_spec_excluding (`group, _) ->
      Sfmt.keyword ~option f [ Kw_exclude; Kw_group ]
    | Frame_spec_excluding (`ties, _) ->
      Sfmt.keyword ~option f [ Kw_exclude; Kw_ties ]
end
