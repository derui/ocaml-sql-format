create temporary trigger a.some_trigger instead of update of (c,d) on foo_bar
for each row when v > 5
begin
update test set a = 5 where id = 3;
insert into foo select * from foo_bar;
end;
