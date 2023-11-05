use triggers;

create table cs(
	id int primary key,
    sales_amount decimal(10, 2) check(sales_amount >=0),
    purches_amount decimal(10, 2) check(purches_amount >=0)
);

create table item(
	id int primary key,
    total_item int,
    item_price decimal(10, 2)
);

create table transactions(
	id int primary key,
    cs_id int,
    item_id int,
    t_type varchar(1),
    t_item_amonut int,
    foreign key(cs_id) references cs(id),
    foreign key(item_id) references item(id)
);

insert into cs values (100, 0, 0),(101, 10, 10),(102, 20, 20);

insert into item value (1, 10, 2),(2, 3, 5);

insert into transactions values(201, 100, 1, 'S', 1);

DELIMITER $$

create trigger update_trc_trg
after insert on transactions
for each row
begin
	
    declare price decimal(10, 2);
    
    select item_price into price from item where id = new.item_id;
    if new.t_type = 'S' then
		update item set total_item = total_item - new.t_item_amonut where id = new.item_id;
        update cs set sales_amount = sales_amount + (price * new.t_item_amonut) where id = new.cs_id;
	else
		update item set total_item = total_item + new.t_item_amonut where id = new.item_id;
        update cs set purches_amount = purches_amount + (price * new.t_item_amonut) where id = new.cs_id;
    end if;
end;
$$
DELIMITER ;
select * from cs;
select * from item;

insert into transactions values(202, 100, 1, 'S', 1);

select * from cs;
select * from item;

insert into transactions values(203, 100, 1, 'P', 1);

select * from cs;
select * from item;