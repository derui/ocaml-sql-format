create table public.foo (
 id bigint primary key
);

alter table foo rename to foo_bar;

select * from foo_bar where id < 100 and id between 10 and 50;
