module Sp = Support
module K = Sql_syntax.Kind
module R = Sql_syntax.Raw

let rewrite_expr env raw =
  Sp.should_be_node K.N_expr raw;

  let expr_rewriter env raw = Sp.choice [ (`leaf K.L_ident, fun env r -> Sp.space ~leading:1 env r) ] env raw in

  let layouts = Sp.map ~rewriter:expr_rewriter env raw in
  R.replace_layouts layouts raw
