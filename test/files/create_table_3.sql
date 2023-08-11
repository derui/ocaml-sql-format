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
