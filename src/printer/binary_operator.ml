open Types.Ast
open Types.Token
open Intf

module type S = PRINTER with type t = ext binary_operator

module Make () : S = struct
  type t = ext binary_operator

  let wrap ~option f t =
    Fmt.string f " ";
    Token.print ~option f t;
    Fmt.string f " "

  let print f t ~option =
    match t with
    | Binary_operator (`concat, _) -> wrap ~option f Op_concat
    | Binary_operator (`extract, _) -> wrap ~option f Op_extract
    | Binary_operator (`extract_2, _) -> wrap ~option f Op_extract_2
    | Binary_operator (`asterisk, _) -> wrap ~option f Op_star
    | Binary_operator (`divide, _) -> wrap ~option f Op_slash
    | Binary_operator (`plus, _) -> wrap ~option f Op_plus
    | Binary_operator (`minus, _) -> wrap ~option f Op_minus
    | Binary_operator (`land', _) -> wrap ~option f Op_amp
    | Binary_operator (`lor', _) -> wrap ~option f Op_pipe
    | Binary_operator (`lshift, _) -> wrap ~option f Op_lshift
    | Binary_operator (`rshift, _) -> wrap ~option f Op_rshift
    | Binary_operator (`lt, _) -> wrap ~option f Op_lt
    | Binary_operator (`gt, _) -> wrap ~option f Op_gt
    | Binary_operator (`le, _) -> wrap ~option f Op_le
    | Binary_operator (`ge, _) -> wrap ~option f Op_ge
    | Binary_operator (`eq, _) -> wrap ~option f Op_eq
    | Binary_operator (`eq2, _) -> wrap ~option f Op_eq2
    | Binary_operator (`ne, _) -> wrap ~option f Op_ne
    | Binary_operator (`ne2, _) -> wrap ~option f Op_ne2
    | Binary_operator (`and', _) ->
      Fmt.string f " ";
      Token.print ~option f Kw_and;
      Fmt.string f " "
    | Binary_operator (`or', _) ->
      Fmt.string f " ";
      Token.print ~option f Kw_or;
      Fmt.string f " "
end
