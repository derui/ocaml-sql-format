open Types.Ast
open Types.Token
open Types.Literal
open Intf

module type S = PRINTER with type t = ext table_primary

module Make
    (I : GEN with type t = ext identifier)
    (TOQN : GEN with type t = ext table_or_query_name)
    (D : GEN with type t = ext derived_table)
    (LD : GEN with type t = ext lateral_derived_table)
    (CD : GEN with type t = ext collection_derived_table)
    (TFD : GEN with type t = ext table_function_derived_table)
    (O : GEN with type t = ext only_spec)
    (JT : GEN with type t = ext joined_table)
    (DCL : GEN with type t = ext derived_column_list) : S = struct
  type t = ext table_primary

  let print f t ~option =
    match t with
    | Table_primary (`table_or_query (v, back), _) ->
      let module TOQN = (val TOQN.generate ()) in
      TOQN.print f v ~option;
      Option.iter
        (fun (alias, list) ->
          Fmt.string f " ";
          Printer_token.print f ~option Kw_as;
          Fmt.string f " ";
          let module I = (val I.generate ()) in
          I.print f alias ~option;

          Option.iter
            (fun l ->
              Sfmt.parens ~option
                (fun f _ ->
                  let module DCL = (val DCL.generate ()) in
                  DCL.print f l ~option)
                f ())
            list)
        back
    | Table_primary (`derived (d, alias, list), _) ->
      let module D = (val D.generate ()) in
      D.print f d ~option;
      Fmt.string f " ";
      Printer_token.print f ~option Kw_as;
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print f alias ~option;

      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module DCL = (val DCL.generate ()) in
              DCL.print f l ~option)
            f ())
        list
    | Table_primary (`lateral (d, alias, list), _) ->
      let module LD = (val LD.generate ()) in
      LD.print f d ~option;
      Fmt.string f " ";
      Printer_token.print f ~option Kw_as;
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print f alias ~option;

      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module DCL = (val DCL.generate ()) in
              DCL.print f l ~option)
            f ())
        list
    | Table_primary (`collection (d, alias, list), _) ->
      let module CD = (val CD.generate ()) in
      CD.print f d ~option;
      Fmt.string f " ";
      Printer_token.print f ~option Kw_as;
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print f alias ~option;

      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module DCL = (val DCL.generate ()) in
              DCL.print f l ~option)
            f ())
        list
    | Table_primary (`table_function (d, alias, list), _) ->
      let module TFD = (val TFD.generate ()) in
      TFD.print f d ~option;
      Fmt.string f " ";
      Printer_token.print f ~option Kw_as;
      Fmt.string f " ";
      let module I = (val I.generate ()) in
      I.print f alias ~option;

      Option.iter
        (fun l ->
          Sfmt.parens ~option
            (fun f _ ->
              let module DCL = (val DCL.generate ()) in
              DCL.print f l ~option)
            f ())
        list
    | Table_primary (`only (v, back), _) ->
      let module O = (val O.generate ()) in
      O.print f v ~option;
      Option.iter
        (fun (alias, list) ->
          Fmt.string f " ";
          Printer_token.print f ~option Kw_as;
          Fmt.string f " ";
          let module I = (val I.generate ()) in
          I.print f alias ~option;

          Option.iter
            (fun l ->
              Sfmt.parens ~option
                (fun f _ ->
                  let module DCL = (val DCL.generate ()) in
                  DCL.print f l ~option)
                f ())
            list)
        back
    | Table_primary (`joined joined, _) ->
      let pf f _ =
        let module JT = (val JT.generate ()) in
        JT.print f joined ~option
      in
      Sfmt.parens ~indent:() ~option pf f ()
end
