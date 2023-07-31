open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext function'

module Make
    (V : GEN with type t = ext expr)
    (Fname : GEN with type t = ext function_name)
    (Filter_clause : GEN with type t = ext filter_clause) : S = struct
  type t = ext function'

  let print f t ~option =
    match t with
    | Function (`no_arg fname, _) ->
      let module Fname = (val Fname.generate ()) in
      Fname.print ~option f fname;
      Sfmt.parens ~option (fun _ _ -> ()) f ()
    | Function (`asterisk fname, _) ->
      let module Fname = (val Fname.generate ()) in
      Fname.print ~option f fname;
      Sfmt.parens ~option (fun f _ -> Token.print ~option f Op_star) f ()
    | Function (`generic (fname, distinct, es, fil), _) ->
      let module Fname = (val Fname.generate ()) in
      Fname.print ~option f fname;
      Sfmt.parens ~option
        (fun f _ ->
          Option.iter
            (fun _ ->
              Token.print ~option f Kw_distinct;
              Fmt.string f " ")
            distinct;

          let e = List.hd es
          and es = List.tl es in
          let module V = (val V.generate ()) in
          V.print ~option f e;

          List.iter
            (fun e ->
              Sfmt.comma ~option f ();
              V.print ~option f e)
            es)
        f ();

      Option.iter
        (fun fil ->
          Fmt.string f " ";
          let module Filter_clause = (val Filter_clause.generate ()) in
          Filter_clause.print ~option f fil)
        fil
    | Function (`extract (unit, e), _) ->
      Token.print ~option f Kw_extract;
      Sfmt.parens ~option
        (fun f _ ->
          let kw =
            match unit with
            | `year -> Kw_year
            | `month -> Kw_month
            | `day -> Kw_day
            | `hour -> Kw_hour
            | `minute -> Kw_minute
            | `second -> Kw_second
            | `quarter -> Kw_quarter
            | `epoch -> Kw_epoch
          in
          Sfmt.keyword ~option f [ kw; Kw_from ];
          Fmt.string f " ";
          let module V = (val V.generate ()) in
          V.print ~option f e)
        f ()
    | Function (`position (e1, e2), _) ->
      Token.print ~option f Kw_position;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          V.print ~option f e1;
          Sfmt.keyword ~option f [ Kw_in ];
          Fmt.string f " ";
          V.print ~option f e2)
        f ()
    | Function (`trim (spec, c, e), _) ->
      Token.print ~option f Kw_trim;
      Sfmt.parens ~option
        (fun f _ ->
          let module V = (val V.generate ()) in
          Option.iter
            (fun kw ->
              let kw =
                match kw with
                | `leading -> Kw_leading
                | `trailing -> Kw_trailing
                | `both -> Kw_both
              in
              Sfmt.keyword ~option f [ kw ];
              Fmt.string f " ")
            spec;

          Option.iter
            (fun e ->
              V.print ~option f e;
              Fmt.string f " ")
            c;

          Sfmt.keyword ~option f [ Kw_from ];
          Fmt.string f " ";
          V.print ~option f e)
        f ()
end
