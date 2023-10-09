open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext having_clause

module Make (V : GEN with type t = ext expr) : S = struct
  type t = ext having_clause

  let print f t ~option =
    match t with
    | Having_clause (e, _) ->
      Sfmt.keyword ~option f [ Kw_having ];
      Sfmt.force_vbox option.indent_size
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ()
end
