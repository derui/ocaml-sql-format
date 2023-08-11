create table a (
 b varchar(2) constraint pk primary key not null unique,
 c decimal(1) check (c > 3),
 e blob collate something constraint pp generated always as (3)
)
