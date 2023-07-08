let write_content file content =
  let chan =
    Out_channel.open_gen [ Open_creat; Open_append; Open_text ] 0o644 file
  in
  (try Out_channel.output_string chan ("\n" ^ content) with _ -> ());
  close_out chan

let ast = {| and 'a %%TYPE%% = %%CONST%% of 'a (* TODO *) |}

let printer =
  {|
open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext %%TYPE%%

module Make () : S = struct
  type t = ext %%TYPE%%

  let print f t ~option =
    match t with
    | %%CONST%% _ -> failwith "TODO: need implementation"
end
               |}

let printer_di = {| and %%TYPE%% () = %%CONST%%.((module Make(): S)) |}

let () =
  let name = Sys.argv.(1) in
  let re_type_name = Re.str "%%TYPE%%" |> Re.compile in
  let re_constr_name = Re.str "%%CONST%%" |> Re.compile in
  let type_name = String.lowercase_ascii name in
  let constr_name = String.lowercase_ascii name |> String.capitalize_ascii in

  let () =
    let fname = "src/types/ast.ml" in
    let content = Re.replace_string re_type_name ~by:type_name ast in
    let content = Re.replace_string re_constr_name ~by:constr_name content in
    write_content fname content
  in
  let () =
    let fname = "src/printer/printer.ml" in
    let content = Re.replace_string re_type_name ~by:type_name printer_di in
    let content = Re.replace_string re_constr_name ~by:constr_name content in
    write_content fname content
  in
  let fname = Printf.sprintf "src/printer/%s.ml" type_name in
  let content = Re.replace_string re_type_name ~by:type_name printer in
  let content = Re.replace_string re_constr_name ~by:constr_name content in
  write_content fname content
