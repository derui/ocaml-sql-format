module F = Formatter
module P = Parser.Parser

let actual =
  {|
  create table a (
 b varchar(2) not null unique,
 c decimal(1) check (c > 3),
 e blob collate something constraint pp generated always as (3)
 ,constraint pk primary key (b)
 ,unique (c,e)
,check (c > 3)
,foreign key (b) references c
,foreign key (c) references d on update set null on update set default on update cascade on update restrict  on update no action
,foreign key (c) references d on delete set null on delete set default on delete cascade on delete restrict  on delete no action
,foreign key (c) references d on delete set null match "v" match "d" deferrable
,foreign key (c) references d match "v" match "d" not deferrable
,foreign key (c) references d match "v" match "d" not deferrable initially deferred
,foreign key (c) references d match "v" match "d" not deferrable initially immediate
)
|}

let option = F.Options.default

let%test_unit "create_table_3 for AST" =
  let actual_ast = F.from_string ~option actual
  and expect_ast = F.from_string ~option @@ F.from_string actual ~option in
  assert (actual_ast = expect_ast)

let%expect_test "create_table_3 for formatting" =
  print_endline @@ F.from_string actual ~option;
  [%expect
    {|
    CREATE TABLE a (
        b varchar(2) NOT NULL UNIQUE,
        c decimal(1) CHECK(c > 3),
        e blob COLLATE something CONSTRAINT pp GENERATED ALWAYS AS(3),
        CONSTRAINT pk PRIMARY KEY (b),
        UNIQUE (c, e),
        CHECK (c > 3),
        FOREIGN KEY (b) REFERENCES c ,
        FOREIGN KEY (c) REFERENCES d
         ON UPDATE SET NULL
         ON UPDATE SET NULL
         ON UPDATE CASCADE
         ON UPDATE RESTRICT
         ON UPDATE NO ACTION,
        FOREIGN KEY (c) REFERENCES d
         ON DELETE SET NULL
         ON DELETE SET NULL
         ON DELETE CASCADE
         ON DELETE RESTRICT
         ON DELETE NO ACTION,
        FOREIGN KEY (c) REFERENCES d
         ON DELETE SET NULL
        MATCH "v"
        MATCH "d"DEFERRABLE,
        FOREIGN KEY (c) REFERENCES d
        MATCH "v"
        MATCH "d"NOT DEFERRABLE,
        FOREIGN KEY (c) REFERENCES d
        MATCH "v"
        MATCH "d"NOT DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (c) REFERENCES d
        MATCH "v"
        MATCH "d"NOT DEFERRABLE INITIALLY IMMEDIATE
    ); |}]
