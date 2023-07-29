%{
open Types.Ast
open Types.Literal
open Types.Token

exception Invalid_token of [`keyword of keyword | `raw of string] list
%}

%token Tok_lparen
%token Tok_rparen
%token Tok_period
%token Tok_comma
%token Tok_colon
%token Tok_dollar
%token Tok_lbrace
%token Tok_rbrace
%token Tok_lsbrace
%token Tok_rsbrace
%token Tok_qmark
%token Tok_semicolon
%token Tok_quote
%token <[`keyword of keyword | `raw of string]> Tok_ident
%token <string> Tok_string
%token <string> Tok_blob
%token <string> Tok_numeric

(* operators *)
%token Op_plus
%token Op_minus
%token Op_star
%token Op_slash
%token Op_double_amp
%token Op_concat
%token Op_eq
%token Op_ge
%token Op_gt
%token Op_le
%token Op_lt
%token Op_ne
%token Op_ne2
%token Op_dereference

%token Tok_eof

%start <Types.Statement.t list> statements

%%

let statement :=
                 | v = sql_statement; { v }


let statements :=
  | v = separated_nonempty_list(Tok_semicolon, statement); Tok_eof; { v }

                      (* basic *)
let sign ==
  | Op_plus; {`plus}
  | Op_minus; {`minus}

(* literal *)
let identifier := | x = Tok_ident; {Identifier (x, ())}

let literal_value :=
  | v = numeric_literal; { Literal_value (`numeric v, ())}
  | v = string_literal; { Literal_value (`string v, ())}
  | v = blob_literal; { Literal_value (`blob v, ())}
  | v = Tok_ident; { match v with
                      |  (`keyword Kw_null) -> Literal_value (`null, ())
                      |  (`keyword Kw_true) -> Literal_value (`true', ())
                      |  (`keyword Kw_false) -> Literal_value (`false', ())
                      |  (`keyword Kw_current_date) -> Literal_value (`current_date, ())
                      |  (`keyword Kw_current_time) -> Literal_value (`current_time, ())
                      |  (`keyword Kw_current_timestamp) -> Literal_value (`current_timestamp, ())
                      | _ -> raise (Invalid_token [v])
                    }

let numeric_literal :=
  | v = Tok_numeric; { Numeric_literal (v, ()) }

let string_literal :=
  | v = Tok_string ;{ String_literal (v, ()) }

let blob_literal :=
  | v = Tok_blob; { Blob_literal (v, ()) }

let bind_parameter :=
  | Tok_qmark; {Bind_parameter ()}

let schema_name ==
  | v = identifier; { Schema_name (v, ()) }

let table_name ==
  | v = identifier; { Table_name (v, ()) }

let column_name ==
  | v = identifier; { Column_name (v, ()) }

let type_name :=
 | name = nonempty_list(identifier); Tok_lparen;
   size = signed_number; Tok_comma; max_size = signed_number;
   Tok_lparen ;
   { Type_name (name, `with_size (size, max_size), ()) }
 | name = nonempty_list(identifier); size = delimited(Tok_lparen, signed_number, Tok_rparen); { Type_name (name, `size size, ()) }
 | name = nonempty_list(identifier); { Type_name (name, `name_only, ()) }

let signed_number :=
 | sign = option(sign); v = numeric_literal; { Signed_number (sign ,v, ()) }

let qualified_name :=
 | name = column_name; { Qualified_name (None, None, name, ()) }
 | tname = table_name;Tok_period; name = column_name; { Qualified_name (None, Some tname, name, ()) }
 | sname = schema_name; Tok_period; tname = table_name;
   Tok_period; name = column_name; { Qualified_name (Some sname, Some tname, name, ()) }


let expr :=
 | v = literal_value; { Expr (`literal v, ()) }
 | v = bind_parameter; { Expr (`parameter v, ()) }
 | v = qualified_name; { Expr (`name v, ()) }


let sql_statement :=
 | s = select_statement; { Sql_statement (`select s, ()) }


let select_statement :=
 | c = select_core ;{ Select_statement (c, ())}


let select_core :=
 | s = select_clause;
   f = option(from_clause);
   wh = option(where_clause);
   g = option(group_by_clause);
   h = option(having_clause);
   wi = option(window_clause);
   { Select_core (`select (s,f,wh,g,h,wi), ()) }


let result_column :=
 | Op_star; { Result_column (`asterisk, ()) }
 | v = table_name; Tok_period; Op_star; { Result_column (`qualified_asterisk v, ()) }
 | e = expr; { Result_column (`expr (e, None), ()) }
 | e = expr; kw = option(Tok_ident); alias = identifier; {
       match kw with
       | Some (`keyword Kw_as) | None -> Result_column (`expr (e, Some alias), ())
       | _ -> raise (Invalid_token [`keyword Kw_as])
     }


let table_or_subquery ==
 | sname = schema_name; Tok_period; tname = table_name; kw = option(Tok_ident); alias = identifier;
   { match kw with
     | Some (`keyword Kw_as) | None -> Table_or_subquery (`name (Some sname, tname, Some alias), ())
     | _ -> raise (Invalid_token [`keyword Kw_as])
   }
 | sname = schema_name; Tok_period; tname = table_name; { Table_or_subquery (`name (Some sname, tname, None), ()) }
 | tname = table_name; { Table_or_subquery (`name (None, tname, None), ()) }

let quantifier ==
  | v = Tok_ident; {
      match v with
      | `keyword Kw_distinct -> `distinct
      | `keyword Kw_all -> `all
      | _ -> raise (Invalid_token [v])
    }

let select_clause :=
 | select = Tok_ident; q = option(quantifier); cols = separated_nonempty_list(Tok_comma, result_column); {
       match select with
       | `keyword Kw_select -> Select_clause (q, cols, ())
       | _ -> raise (Invalid_token [select])
     }


let from_clause :=
 | ts = separated_nonempty_list(Tok_comma, table_or_subquery); { From_clause (`table_or_subquery ts, ()) }


let where_clause :=
 | where = Tok_ident; e = expr; { match where with
                                   | `keyword Kw_where -> Where_clause (e, ())
                                   | _ -> raise (Invalid_token [where])
                                 }


let group_by_clause :=
 | group = Tok_ident; by = Tok_ident; es = separated_nonempty_list(Tok_comma, expr);
   {
     match (group, by) with
     | `keyword Kw_group, `keyword Kw_by -> Group_by_clause (es, ())
     | _ -> raise (Invalid_token [group; by])
   }


let window_clause :=
 | kw = Tok_ident; ds = separated_nonempty_list(Tok_comma, window_clause_sublist); {
       match kw with
       | `keyword Kw_window -> Window_clause (ds, ())
       | _ -> raise (Invalid_token [kw])
     }

let window_clause_sublist ==
  | n = window_name; kw = Tok_ident; w = window_defn; {
            match kw with
            | `keyword Kw_as -> (n, w)
            | _  -> raise (Invalid_token [kw])
          }


let having_clause :=
 | having = Tok_ident; e = expr; { match having with
                                    | `keyword Kw_having -> Having_clause (e, ())
                                    | _ -> raise (Invalid_token [having])
                                  }


let window_name ==
 | v = identifier; { Window_name (v, ()) }


let window_defn :=
 | Tok_lparen;
   n = option(base_window_name);
   p = option(partition_clause);
   o = option(order_by_clause);
   s = option(frame_spec);
   Tok_rparen; { Window_defn (n,p,o,s, ()) }


let base_window_name :=
 | i = identifier; { Base_window_name (i, ()) }


let order_by_clause :=
  | order = Tok_ident; by = Tok_ident; term = ordering_term; {
        match (order, by) with
        | `keyword Kw_order, `keyword Kw_by -> Order_by_clause (term, ())
        | _ -> raise (Invalid_token [order; by])
      }

let order ==
  | kw = Tok_ident; {
            match kw with
            | `keyword Kw_asc -> `asc
            | `keyword Kw_desc -> `desc
            | _ -> raise (Invalid_token [kw])
          }

let null_order ==
  | n = Tok_ident; o = Tok_ident; {
            match (n, o) with
            | `keyword Kw_null, `keyword Kw_first -> `first
            | `keyword Kw_null, `keyword Kw_last -> `last
            | _ -> raise (Invalid_token [n; o])
          }

let frame_spec :=
 | r = Tok_ident; core = frame_spec_core; e = option(frame_spec_excluding);  {
       match r with
       | `keyword Kw_range -> Frame_spec (`range, core, e, ())
       | `keyword Kw_rows -> Frame_spec (`rows, core, e, ())
       | `keyword Kw_groups -> Frame_spec (`groups, core, e, ())
       | _ -> raise (Invalid_token [r])
     }


let ordering_term :=
 | e = expr; collation = option(collation_name);
   o = option(order); no = option(null_order);
   { Ordering_term (e, collation, o, no, ())  }


let partition_clause :=
 | kw = Tok_ident; kw2 = Tok_ident; es = separated_nonempty_list(Tok_comma, expr); {
       match kw, kw2 with
       | `keyword Kw_partition, `keyword Kw_by -> Partition_clause (es, ())
       | _ -> raise (Invalid_token [kw;kw2])
     }


let collation_name :=
 | kw = Tok_ident; name = identifier; {
       match kw with
       | `keyword Kw_collation -> Collation_name (name, ())
       | _ -> raise (Invalid_token [kw])
     }


let frame_spec_between :=
  | kw = Tok_ident; b1 = frame_spec_between_1; kw2 = Tok_ident; b2 = frame_spec_between_2;
    {
      match kw, kw2 with
      | `keyword Kw_between, `keyword Kw_and -> Frame_spec_between (b1, b2, ())
      | _ -> raise (Invalid_token [kw; kw2])
    }


let frame_spec_between_1 :=
 | e = expr; kw = Tok_ident; {
        match kw with
        | `keyword Kw_preceding -> Frame_spec_between_1 (`preceding e, ())
        | `keyword Kw_following -> Frame_spec_between_1 (`following e, ())
        | _ -> raise (Invalid_token [kw])
      }
 | v = Tok_ident; v2 = Tok_ident; {
        match v, v2 with
        |  `keyword Kw_unbounded, `keyword Kw_preceding -> Frame_spec_between_1 (`unbounded, ())
        |  `keyword Kw_current, `keyword Kw_row -> Frame_spec_between_1 (`current_row, ())
        | _ -> raise (Invalid_token [v; v2])
      }


let frame_spec_between_2 :=
 | e = expr; kw = Tok_ident; {
        match kw with
        | `keyword Kw_preceding -> Frame_spec_between_2 (`preceding e, ())
        | `keyword Kw_following -> Frame_spec_between_2 (`following e, ())
        | _ -> raise (Invalid_token [kw])
      }
 | v = Tok_ident; v2 = Tok_ident; {
        match v, v2 with
        | `keyword Kw_unbounded,  `keyword Kw_following -> Frame_spec_between_2 (`unbounded, ())
        | `keyword Kw_current,  `keyword Kw_row -> Frame_spec_between_2 (`current_row, ())
        | _ -> raise (Invalid_token [v; v2])
      }


let frame_spec_core :=
 | e = expr; kw = Tok_ident; {
       match kw with
       | `keyword Kw_preceding -> Frame_spec_core (`preceding e, ())
       | _ -> raise (Invalid_token [kw])
     }
 | kw = Tok_ident; kw2 = Tok_ident; {
       match kw, kw2 with
       | `keyword Kw_unbounded, `keyword Kw_preceding -> Frame_spec_core (`unbounded, ())
       | `keyword Kw_current, `keyword Kw_row -> Frame_spec_core (`current_row, ())
       | _ -> raise (Invalid_token [kw; kw2])
     }
 | b = frame_spec_between; { Frame_spec_core (`between b, ()) }


let frame_spec_excluding :=
 | e = Tok_ident; v1 = Tok_ident; {
        match (e, v1) with
        | `keyword Kw_exclude, `keyword Kw_group -> Frame_spec_excluding (`group, ())
        | `keyword Kw_exclude, `keyword Kw_ties -> Frame_spec_excluding (`current_row, ())
        | _ -> raise (Invalid_token [e; v1])
      }
 | e = Tok_ident; v1 = Tok_ident; v2 = Tok_ident; {
        match (e, v1, v2) with
        | `keyword Kw_exclude, `keyword Kw_no,
          `keyword Kw_others -> Frame_spec_excluding (`no_others, ())
        | `keyword Kw_exclude,
          `keyword Kw_current,
          `keyword Kw_row -> Frame_spec_excluding (`current_row, ())
        | _ -> raise (Invalid_token [e; v1; v2])
      }
