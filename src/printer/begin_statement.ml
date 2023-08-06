open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext begin_statement

module Make () : S = struct
  type t = ext begin_statement

  let print f t ~option =
    match t with
    | Begin_statement (v, _) ->
      let kw =
        match v with
        | None -> [ Kw_begin ]
        | Some _ -> [ Kw_begin; Kw_transaction ]
      in
      Sfmt.keyword ~option f kw
end
