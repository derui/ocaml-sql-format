open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext general_value_specification

module Make
    (V : GEN with type t = ext host_parameter_specification)
    (Sql : GEN with type t = ext sql_parameter_reference)
    (Dynamic : GEN with type t = ext dynamic_parameter_specification)
    (Current : GEN with type t = ext current_collation_specification)
    (Path : GEN with type t = ext path_resolved_user_defined_type_name) : S =
struct
  type t = ext general_value_specification

  let print f t ~option =
    match t with
    | General_value_specification (`host v, _) ->
      let module V = (val V.generate ()) in
      V.print f ~option v
    | General_value_specification (`sql v, _) ->
      let module Sql = (val Sql.generate ()) in
      Sql.print f ~option v
    | General_value_specification (`dynamic v, _) ->
      let module Dynamic = (val Dynamic.generate ()) in
      Dynamic.print f ~option v
    | General_value_specification (`current_collation v, _) ->
      let module Current = (val Current.generate ()) in
      Current.print f ~option v
    | General_value_specification (`default_transform_group, _) ->
      Printer_token.print ~option f Kw_current_default_transform_group
    | General_value_specification (`path, _) ->
      Printer_token.print ~option f Kw_current_path
    | General_value_specification (`role, _) ->
      Printer_token.print ~option f Kw_current_role
    | General_value_specification (`transform_group_for_type v, _) ->
      Printer_token.print ~option f Kw_current_transform_group_for_type;
      Fmt.string f " ";
      let module Path = (val Path.generate ()) in
      Path.print f ~option v
    | General_value_specification (`current_user, _) ->
      Printer_token.print ~option f Kw_current_user
    | General_value_specification (`session_user, _) ->
      Printer_token.print ~option f Kw_session_user
    | General_value_specification (`system_user, _) ->
      Printer_token.print ~option f Kw_system_user
    | General_value_specification (`user, _) ->
      Printer_token.print ~option f Kw_user
    | General_value_specification (`value, _) ->
      Printer_token.print ~option f Kw_value
end
