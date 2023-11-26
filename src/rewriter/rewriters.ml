module Sp = Support
module K = Sql_syntax.Kind
module R = Sql_syntax.Raw

let rec rewrite_expr env raw =
  let expr_rewriter env raw =
    Sp.choice
      [ (`leaf K.L_ident, fun env r -> Sp.space ~leading:1 env r)
      ; (`leaf K.L_qmark, fun env r -> Sp.space ~leading:1 env r)
      ; (`leaf K.L_string, fun env r -> Sp.space ~leading:1 env r)
      ; (`leaf K.L_numeric, fun env r -> Sp.space ~leading:1 env r)
      ; (`leaf K.L_blob, fun env r -> Sp.space ~leading:1 env r)
      ; (`node K.N_expr_name, rewrite_expr_name)
      ; (`node K.N_expr_unary, rewrite_expr_unary)
      ; (`node K.N_expr_cast, rewrite_expr_cast)
      ; (`node K.N_expr_collate, rewrite_expr_collate)
      ; (`node K.N_expr_like, rewrite_expr_like)
      ; (`node K.N_expr_glob, rewrite_expr_glob)
      ; (`node K.N_expr_regexp, rewrite_expr_regexp)
      ; (`node K.N_expr_match, rewrite_expr_match)
      ]
      env raw
  in

  let layouts = Sp.map ~rewriter:expr_rewriter env raw in
  R.replace_layouts layouts raw

and rewrite_expr_name env raw =
  Sp.should_be_node K.N_expr_name raw;
  let rewriter = Sp.space ~leading:0 ~trailing:0 in
  let layouts = Sp.map ~rewriter env raw in
  let layouts =
    match layouts with
    | r :: rest -> (Sp.space ~leading:1 env r |> Option.get) :: rest
    | _ as v -> v
  in
  R.replace_layouts layouts raw |> Option.some

and rewrite_expr_unary env raw =
  Sp.should_be_node K.N_expr_unary raw;
  let rewriter = Sp.choice [ (`leaf K.L_keyword, Sp.keyword); (`any, Sp.space ~leading:0 ~trailing:0) ] in
  let layouts = Sp.map ~rewriter env raw in
  let layouts =
    match layouts with
    | r :: rest -> (Sp.space ~leading:1 env r |> Option.get) :: rest
    | _ as v -> v
  in
  R.replace_layouts layouts raw |> Option.some

and rewrite_type_name env raw =
  Sp.should_be_node K.N_type_name raw;
  let rewriter =
    Sp.choice
      [ (`leaf K.L_ident, fun env r -> Sp.space ~trailing:1 env r)
      ; (`leaf K.L_lparen, Sp.space ~leading:0 ~trailing:0)
      ; (`leaf K.L_rparen, Sp.space ~leading:0 ~trailing:0)
      ; (`leaf K.L_comma, Sp.space ~leading:0 ~trailing:1)
      ]
  in
  let layouts = Sp.map ~rewriter env raw in
  let layouts =
    match layouts with
    | r :: rest -> (Sp.space ~leading:1 env r |> Option.get) :: rest
    | _ as v -> v
  in
  R.replace_layouts layouts raw |> Option.some

(* cast rewriter *)
and rewrite_expr_cast env raw =
  Sp.should_be_node K.N_expr_cast raw;
  let rewriter =
    Sp.choice
      [ (`leaf K.L_keyword, Sp.keyword)
      ; (`node K.N_type_name, rewrite_type_name)
      ; (`any, Sp.space ~leading:0 ~trailing:0)
      ]
  in
  let layouts = Sp.map ~rewriter env raw in
  let layouts =
    match layouts with
    | r :: rest -> (Sp.space ~leading:1 env r |> Option.get) :: rest
    | _ as v -> v
  in
  R.replace_layouts layouts raw |> Option.some

(* collation rewriter *)
and rewrite_expr_collate env raw =
  let open Sp.Syntax in
  Sp.should_be_node K.N_expr_collate raw;
  let rewriter =
    Sp.choice
      [ (`leaf K.L_keyword, fun env r -> Sp.keyword env r >>= Sp.shrink env >>= Sp.space ~leading:1 ~trailing:0 env)
      ; (`any, fun env r -> Sp.shrink env r >>= Sp.space ~leading:1 ~trailing:0 env)
      ]
  in
  let layouts = Sp.map ~rewriter env raw in
  let layouts =
    match layouts with
    | r :: rest -> (Sp.space ~leading:1 env r |> Option.get) :: rest
    | _ as v -> v
  in
  R.replace_layouts layouts raw |> Option.some

(* like rewriter *)
and _rewrite_expr_like_like node env raw =
  let open Sp.Syntax in
  Sp.should_be_node node raw;
  let rewriter =
    Sp.choice
      [ (`leaf K.L_keyword, fun env r -> Sp.keyword env r >>= Sp.shrink env >>= Sp.space ~leading:1 ~trailing:0 env)
      ; (`any, fun env r -> Sp.shrink env r >>= Sp.space ~leading:1 ~trailing:0 env)
      ]
  in
  let layouts = Sp.map ~rewriter env raw in
  R.replace_layouts layouts raw |> Option.some

and rewrite_expr_like env raw = _rewrite_expr_like_like K.N_expr_like env raw

(* glob rewriter *)
and rewrite_expr_glob env raw = _rewrite_expr_like_like K.N_expr_glob env raw

(* regexp rewriter *)
and rewrite_expr_regexp env raw = _rewrite_expr_like_like K.N_expr_regexp env raw

(* match rewriter *)
and rewrite_expr_match env raw = _rewrite_expr_like_like K.N_expr_match env raw
