open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext having_clause

module Make (Con : GEN with type t = ext condition) : S = struct
  type t = ext having_clause

  let print f t ~option =
    match t with
    | Having_clause (t, _f) ->
      let module Con = (val Con.generate ()) in
      Printer_token.print f ~option Kw_having;
      Sfmt.force_vbox option.indent_size (fun f _ -> Con.print f ~option t) f ()
end
