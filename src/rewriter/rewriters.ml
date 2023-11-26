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
