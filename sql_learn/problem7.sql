create database shop;
use shop;

CREATE TABLE CustomerAndSuppliers (
    cusl_id CHAR(6) PRIMARY KEY CHECK (cusl_id REGEXP '^[CS][0-9]{5}$'),
    cusl_fname CHAR(15) NOT NULL,
    cusl_lname VARCHAR(15),
    cusl_address TEXT,
    cusl_telno CHAR(12) CHECK (cusl_telno REGEXP '^[0-9]{3}-[0-9]{8}$'),
    cusl_city CHAR(12) DEFAULT 'Rajshahi',
    sales_amnt DECIMAL(10, 2) CHECK (sales_amnt >= 0),
    proc_amnt DECIMAL(10, 2) CHECK (proc_amnt >= 0)
);

insert into CustomerAndSuppliers
(cusl_id, cusl_fname, cusl_lname, cusl_address, cusl_telno, cusl_city, sales_amnt, proc_amnt)
values
('S00001','Sohag','Hossain','BSMRH-501','017-61236455','Kurigram',100,50),
('C00006','Iqbal','Hossain','221/B Dhanmondi','017-00000000', 'Dhaka', 100,200),
('S00007','Fahim','Hossain','201/A Dhanmondi','017-00002300', 'Dhaka', 50,100),
('C00008','Sohan','Hossain','221/A Dhanmondi','017-00004000', 'Dhaka', 200,100);

create table Item(
	item_id char(6) primary key check (item_id regexp ('^[P][0-9]{5}$')),
	item_name char(12),
	item_catagory char(10),
	item_price decimal(10, 2) check(item_price>=0),
	item_qoh int check(item_qoh>=0),
	item_last_sold datetime  default current_timestamp
);

insert into Item
(item_id, item_name, item_catagory, item_price, item_qoh)
values
('P00001', 'i-phone12', 'phone', 50, 1),
('P00002', 'i-phone14', 'phone', 10, 3),
('P00003', 'i-phone13', 'phone', 30, 2),
('P00004', 'i-phone15', 'phone', 40, 1);


create table Transactions(
	tran_id char(10) primary key check (tran_id regexp ('^[T][0-9]{9}$')),
	item_id char(6),
	cusl_id char(6),
	tran_type char(1),
	tran_quality int check (tran_quality>=0),
	tran_date datetime default current_timestamp,
    foreign key(item_id) references item(item_id),
    foreign key(cusl_id) references CustomerAndSuppliers(cusl_id)
);

DELIMITER //
CREATE TRIGGER trg_update_item
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE price DECIMAL(10, 2);
    
    SELECT item_price INTO price FROM Item WHERE item_id = new.item_id;
    
    IF new.tran_type = 'S' THEN
        UPDATE Item SET item_qoh = item_qoh - NEW.tran_quality WHERE item_id = new.item_id;
        UPDATE CustomerAndSuppliers SET sales_amnt = sales_amnt + (price * new.tran_quality) WHERE cusl_id = new.cusl_id;
    ELSE
        UPDATE Item SET item_qoh = item_qoh + NEW.tran_quality WHERE item_id = new.item_id;
        UPDATE CustomerAndSuppliers SET proc_amnt = proc_amnt + (price * new.tran_quality) WHERE cusl_id = new.cusl_id;
    END IF;
END;
//
DELIMITER ;
insert Transactions(tran_id ,item_id,cusl_id,tran_type,tran_quality)
values('T000000001','P00002','C00006','S',1);

insert Transactions(tran_id ,item_id,cusl_id,tran_type,tran_quality)
values('T000000002','P00001','S00007','P',1);
select * from Transactions;
select * from CustomerAndSuppliers;
select * from Item;


