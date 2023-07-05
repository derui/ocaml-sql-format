(* no-info types *)
type qualifier =
  [ `Distinct
  | `All
  ]
[@@deriving show, eq]

and joiner =
  [ `Union
  | `Except
  ]
[@@deriving show, eq]

and row_variant_ =
  [ `row
  | `rows
  ]
[@@deriving show, eq]

and not_op = [ `not' ] option [@@deriving show, eq]

and sign =
  [ `plus
  | `minus
  ]
[@@deriving show, eq]

and non_second_primary_datetime_field =
  [ `year
  | `month
  | `day
  | `hour
  | `minute
  ]
[@@deriving show, eq]
