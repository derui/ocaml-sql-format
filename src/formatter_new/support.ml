(** Support functions *)

include Support_intf.Type

include (
  struct
    module R = Sql_syntax.Raw
    module K = Sql_syntax.Kind
    module Tr = Sql_syntax.Trivia
    open Monad
    open Let_syntax

    let trivia pp tr =
      let tr = Tr.shrink tr in
      Fmt.pf pp "%s" @@ Tr.to_string tr

    module Condition = struct
      let contains sel =
        let* raw = current in
        let contains raw = sel raw |> Option.is_some in
        let contained =
          match raw with
          | R.Leaf _ -> contains raw
          | R.Node { layouts; _ } -> List.exists contains layouts
        in
        return contained
    end

    let iter f =
      let* raw = current in
      match raw with
      | R.Node { layouts; _ } ->
        (* TODO should be hidden implementation detail of layouts *)
        List.fold_right
          (fun x acc ->
            let* () = acc in
            let* _ = push x in
            let* _ = f () in
            let* _ = pop () in
            return ())
          layouts (return ())
      | _ -> return ()

    let leaf_inner leading trailing v =
      let* _ = append @@ Fmt.const trivia leading in
      let* _ = append @@ Fmt.const Fmt.string v in
      let* _ = append @@ Fmt.const trivia trailing in
      return ()

    let leaf ?leading:leading_m ?trailing:trailing_m selector =
      let* raw = current in
      match selector raw with
      | Some (R.Leaf { leading; trailing; token; _ }) ->
        let* _ = Option.map Fun.id leading_m |> Option.value ~default:(return ()) in
        let* _ = leaf_inner leading trailing @@ Types.Token.show token in
        let* _ = Option.map Fun.id trailing_m |> Option.value ~default:(return ()) in
        return ()
      | _ -> return ()

    let node selector f =
      let* raw = current in
      match selector raw with
      | Some (R.Node _ as r) ->
        let* () = push r in
        let* _ = f () in
        let* _ = pop () in
        return ()
      | _ -> return ()

    let keyword ?leading:leading_m ?trailing:trailing_m selector =
      let* raw = current in
      match selector raw with
      | Some (R.Leaf { kind = L_keyword; leading; trailing; token }) ->
        let* opts = options in
        let kw =
          match opts.keyword_case with
          | `as_is -> Types.Token.show token
          | `lower -> Types.Token.show token |> String.lowercase_ascii
          | `upper -> Types.Token.show token |> String.uppercase_ascii
        in
        let* _ = Option.map Fun.id leading_m |> Option.value ~default:(return ()) in
        let* _ = leaf_inner leading trailing kw in
        let* _ = Option.map Fun.id trailing_m |> Option.value ~default:(return ()) in
        return ()
      | _ -> return ()

    let nonbreak = append @@ Fmt.any " "

    let cut ?(indentation = false) () =
      let* opts = options in
      let indent =
        match indentation with
        | true -> opts.indent_size
        | false -> 0
      in

      append @@ fun fmt _ -> Format.pp_print_break fmt 0 indent

    let sp ?(sps = 1) () =
      assert (sps > 0);
      append @@ fun fmt _ -> Format.pp_print_break fmt sps 0

    let spi ?(sps = 1) ~indent () =
      assert (indent >= 0);
      append @@ fun fmt _ -> Format.pp_print_break fmt sps indent

    let vbox ?(indentation = false) m =
      let* opt = options in
      let indent =
        match indentation with
        | true -> opt.indent_size
        | false -> 0
      in

      let* ppf = with_new_ppf m in
      append @@ Fmt.vbox ~indent ppf

    let hvbox ?(indentation = false) m =
      let* opt = options in
      let indent =
        match indentation with
        | true -> opt.indent_size
        | false -> 0
      in

      let* ppf = with_new_ppf m in
      append @@ Fmt.hvbox ~indent ppf

    let hovbox ?(indentation = false) m =
      let* opt = options in
      let indent =
        match indentation with
        | true -> opt.indent_size
        | false -> 0
      in
      let* ppf = with_new_ppf m in
      append @@ Fmt.hovbox ~indent ppf
  end :
    Support_intf.S)
