--This table will have all the items in the shop with their prices and stock on hand with unique codes for each item

CREATE TABLE stock (
	item_code bigserial primary KEY,
	item_name varchar(100),
	item_price numeric(2),
	on_hand integer
);

--This table will list all the users on your database with their email, first name, last name and unique user id

CREATE TABLE users (
	user_id bigserial primary key,
	first_name varchar(25),
	last_name varchar(25),
	email varchar(50) CONSTRAINT unique_constraint UNIQUE
);

--This table will store every item with a quantity and subtotal for the user to checkout 

CREATE TABLE cart (
	user_id integer REFERENCES users (user_id),
	item_code integer REFERENCES stock (item_code),
	quantity integer
);

--Inserting stock items into the stock table

INSERT INTO stock (item_name, item_price, on_hand)
VALUES 	('Coca Cola', 15, 50),
		('Fanta', 12, 50),
		('Pepsi', 14, 50),
		('bar-one', 8, 50),
		('Kit-Kat', 7, 50),
		('Nosh', 5, 50);
		
--Inserting our first users to our databse into our users table

INSERT INTO users (first_name,last_name,email)
VALUES
  ('Tatyana','Short','quis.turpis.vitae@google.edu'),
  ('Hayfa','Valentine','morbi.tristique.senectus@protonmail.couk'),
  ('Murphy','Salazar','orci.sem@protonmail.net'),
  ('Rashad','Morrison','non.lacinia@hotmail.edu'),
  ('Nell','Morgan','vulputate@aol.couk');


--3) Select query to show you the menu of all the items in the store
--MENU

SELECT item_name, item_price FROM stock

--4) Insert query that will update the shopping cart with the item and quantity that you have specified
--ADD TO CART

--item1
INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 1, 1);

INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 1, 2);

--item2
INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 2, 1);

INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 2, 3);

--item3
INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 3, 1);

INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 3, 5);

--item4
INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 4, 1);

INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 4, 7);

--item5
INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 5, 1);

INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 5, 4);

--item6
INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 6, 1);

INSERT INTO cart (user_id, item_code, quantity)
VALUES (1, 6, 3);

--4.1) Update query to update the quantity of a item in your cart

--ADD to quantity for each item

UPDATE cart SET quantity = quantity + 1
Where item_code = 1;

UPDATE cart SET quantity = quantity + 1
Where item_code = 2;

UPDATE cart SET quantity = quantity + 1
Where item_code = 3;

UPDATE cart SET quantity = quantity + 1
Where item_code = 4;

UPDATE cart SET quantity = quantity + 1
Where item_code = 5;

UPDATE cart SET quantity = quantity + 1
Where item_code = 6;

--Subtract from quantity for each item

UPDATE cart SET quantity = quantity - 1
Where item_code = 1;

UPDATE cart SET quantity = quantity - 1
Where item_code = 2;

UPDATE cart SET quantity = quantity - 1
Where item_code = 3;

UPDATE cart SET quantity = quantity - 1
Where item_code = 4;

UPDATE cart SET quantity = quantity - 1
Where item_code = 5;

UPDATE cart SET quantity = quantity - 1
Where item_code = 6;

--This clears your shopping cart data
TRUNCATE cart;

--5) This query show everything in your cart
SELECT user_id, item_code, SUM(quantity) AS quantity
FROM cart
GROUP BY user_id, item_code;

--6) This query runs the checkout and will calculate the totals for you
SELECT cart.user_id, cart.item_code, stock.item_name, stock.item_price, SUM(cart.quantity) AS quantity, SUM(cart.quantity)*stock.item_price AS subtotals
into temp_checkout
FROM cart
LEFT JOIN stock
ON cart.item_code = stock.item_code
GROUP BY cart.user_id,cart.item_code, stock.item_name, stock.item_price;

--This drops your temp_checkout table
DROP TABLE temp_checkout

--This clears your shopping cart data
TRUNCATE cart;

--Bonus
--The order table will store all orders with the user who ordered it
CREATE TABLE orders (
	user_id integer REFERENCES users (user_id),
	item_code integer REFERENCES stock (item_code),
	item_name varchar(100),
	item_price numeric,
	quantity numeric,
	subtotals numeric
);

--This insert query will insert the temp order data table into the order table
INSERT INTO orders (user_id, item_code, item_name, item_price, quantity, subtotals)
SELECT * from temp_checkout

--This query shows all the orders made by a specific user
SELECT * FROM orders 
WHERE user_id =1

--This query shows what your temp checkout looks like
select * from temp_checkout

--This query show all the orders ever made
SELECT * from orders 