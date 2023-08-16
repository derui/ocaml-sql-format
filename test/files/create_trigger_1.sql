create trigger if not exists a.some_trigger before delete on foo_bar
begin
insert into abc (a,b,c) values (1,2,3);
end;
