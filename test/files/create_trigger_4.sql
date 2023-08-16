create trigger a.some_trigger after insert on foo_bar
for each row
begin
insert into foo select * from foo_bar;
end;
