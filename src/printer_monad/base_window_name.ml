open Intf

(* base window name is alias of identifier *)
module Make (V : GEN_M) : PRINTER_M = struct
  let print () =
    let module V = (val V.generate ()) in
    V.print ()
end
