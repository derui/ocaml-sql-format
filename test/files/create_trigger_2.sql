create trigger if not exists a.some_trigger instead of update of (c,d) on foo_bar
begin
update test set a = 5;
end;
