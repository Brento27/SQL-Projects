 --ODBC and JDBC Support Chapter 1
  
  SELECT contact_id, COUNT(contact_id)
  FROM my_contacts
  GROUP BY contact_id
  HAVING COUNT(contact_id)> 1
  ORDER BY contact_id;
  
   --ODBC and JDBC Support Chapter 2
   
DELETE FROM my_contacts
WHERE contact_id IN (SELECT contact_id
					 FROM
					(SELECT contact_id,
					ROW_NUMBER() OVER (PARTITION BY contact_id
									  ORDER BY contact_id) AS row_num
					FROM my_contacts) t
					WHERE t.row_num > 1);

--ODBC and JDBC Support Chapter 3

CREATE TABLE my_contacts (
    contact_id bigserial CONSTRAINT contact_id_key PRIMARY KEY,
    last_name varchar(20) NOT NULL,
    first_name varchar(100) NOT NULL,
    phone varchar(15) NOT NULL,
    email varchar(50) NOT NULL constraint email_constraint unique,
    gender varchar(50) NOT NULL, 
    birthday varchar(100) NOT NULL,
    prof_id integer NOT NULL references profession (prof_id),
    zip_code integer NOT NULL references zip_code (zip_code),
   status_id integer NOT NULL references status (status_id)
);

CREATE TABLE profession (
    prof_id bigserial CONSTRAINT prof_id_key PRIMARY KEY,
    profession varchar(25) NOT NULL,
	CONSTRAINT unique_profession UNIQUE (profession)
);

CREATE TABLE zip_code (
    zip_code integer CONSTRAINT zip_code_key PRIMARY KEY,
    city varchar(25) NOT NULL,
    province varchar(25) NOT NULL,
	CONSTRAINT check_zip_code CHECK (lENGTH(zip_code::varchar(100)) < 5)
);

CREATE TABLE status (
    status_id bigserial CONSTRAINT status_id_key PRIMARY KEY,
    status varchar(25) NOT NULL
);

CREATE TABLE contact_intrest (
    contact_id bigserial references my_contacts (contact_id),
    intrest_id integer references intrests (intrest_id)
);

CREATE TABLE contact_seeking (
    contact_id bigserial references my_contacts (contact_id),
    seeking_id integer references seeking (seeking_id)
);

CREATE TABLE intrests (
    intrest_id bigserial CONSTRAINT intrest_id_key PRIMARY KEY,
    intrest varchar(250) NOT NULL
);

CREATE TABLE seeking (
    seeking_id bigserial CONSTRAINT seeking_id_key PRIMARY KEY,
    seeking varchar(250) NOT NULL
);

 --ODBC and JDBC Support Chapter 4

INSERT INTO profession (profession)
VALUES 	('Engineer'),
		('Accountant'),
		('Professor'),
		('Docter'),
		('Mechanic'),
		('Cleric'),
		('Office-assistant'),
		('Studing'),
		('Farmer'),
		('Scientist');
		
INSERT INTO zip_code (zip_code, city, province)
VALUES 	(0011, 'Pretoria', 'Guateng'),
		(2019, 'Johannesburg', 'Guateng'),
		(7103, 'Cape-Town', 'Western-Cape'),
		(6529, 'George', 'Western-Cape'),
		(8460, 'Kuruman', 'Northern-Cape'),
		(8300, 'Kimberley', 'Northern-Cape'),
		(5207, 'East-London', 'Eastern-Cape'),
		(4930, 'Stutterheim', 'Eastern-Cape'),
		(9307, 'Bloemfontein', 'Freestate'),
		(9700, 'Bethlehem', 'Freestate'),
		(2680, 'Christiana', 'North-West'),
		(2660, 'Bloemhof', 'North-West'),
		(0700, 'Polokwane', 'Limpopo'),
		(0900, 'Musina', 'Limpopo'),
		(1201, 'Mbombela', 'Mpumalanga'),
		(1100, 'Belfast', 'Mpumalanga'),
		(4000, 'Durban', 'KwaZulu-Natal'),
		(2940, 'Newcastle', 'KwaZulu-Natal');
		
INSERT INTO status (status)
VALUES 	('Matched'),
		('Searching'),
		('Stopped'),
		('Suspended'),
		('Inactive');
		
INSERT INTO my_contacts (last_name,first_name,phone,email,gender,birthday,prof_id,zip_code,status_id)
VALUES
  ('Alford','Destiny','025-595-5549','congue.elit@protonmail.com','Male','Feb 1, 2009',8,7103,3),
  ('Simpson','Kitra','036-571-8723','neque.sed@yahoo.org','Female','Sep 12, 2004',8,4000,3),
  ('Wheeler','Quintessa','066-821-4276','dapibus.quam@aol.couk','Male','Dec 11, 2005',1,1201,5),
  ('Briggs','Haley','032-558-5438','nulla.cras.eu@aol.couk','Male','May 12, 2006',8,0900,4),
  ('Castaneda','Ciaran','015-287-6728','facilisis@outlook.ca','Female','Oct 11, 2006',5,6529,5),
  ('Cook','Joel','048-193-1136','erat.eget@icloud.couk','Female','Feb 11, 2005',2,2940,3),
  ('David','Plato','025-521-4829','ornare@hotmail.com','Female','Aug 2, 2005',8,2680,1),
  ('Dickerson','Branden','078-965-8009','nulla.facilisi@aol.ca','Female','Aug 16, 2009',2,0700,2),
  ('Watson','Fuller','034-655-8078','risus.quisque@protonmail.couk','Male','Feb 16, 2007',7,1100,4),
  ('House','Joel','056-857-8369','a.arcu@icloud.net','Female','Sep 26, 2007',8,9700,2),
  ('Pate','Kelly','086-114-1987','purus.maecenas@hotmail.org','Female','Sep 2, 2006',2,1201,1),
  ('Buckley','David','031-001-6511','libero.morbi@google.com','Male','Feb 7, 2007',8,6529,1),
  ('Spencer','Natalie','098-117-5716','sollicitudin.adipiscing@protonmail.edu','Female','Dec 27, 2007',6,0700,4),
  ('Donaldson','Tad','070-428-5758','nam.ac@protonmail.edu','Female','Jun 8, 2006',9,0011,4),
  ('Reese','Kasper','025-323-5239','ornare.tortor@hotmail.com','Male','Sep 3, 2007',6,7103,1),
  ('Griffin','Aladdin','088-861-9030','felis@aol.com','Female','Oct 23, 2008',1,6529,5),
  ('Boyer','Dane','076-273-4842','at.auctor.ullamcorper@aol.couk','Male','Sep 5, 2006',2,2940,5),
  ('Beach','Hollee','064-546-1537','iaculis.quis@google.couk','Female','Nov 4, 2009',6,8300,2),
  ('Schultz','Louis','011-346-1132','lorem.auctor.quis@aol.org','Female','Jan 26, 2006',6,9700,2),
  ('Mueller','Beck','076-742-1338','proin.eget@google.net','Male','Dec 16, 2004',7,0011,1),
  ('Pittman','Mufutau','032-184-2483','vitae@google.edu','Female','Jun 4, 2009',5,9700,4),
  ('Durham','Uma','072-041-6225','ornare@aol.com','Male','Feb 4, 2006',5,4000,2),
  ('Mccormick','Vance','061-866-4145','dolor.sit@google.ca','Female','Mar 9, 2005',1,5207,3),
  ('Harrington','Stacey','094-944-4583','sit@protonmail.ca','Male','Oct 20, 2007',2,5207,1),
  ('Hooper','Willow','013-875-3231','egestas@icloud.edu','Male','Nov 29, 2009',2,2019,4),
  ('Alexander','Heather','064-283-8386','in.ornare@protonmail.edu','Male','Oct 1, 2009',3,8460,1),
  ('Pate','Abraham','097-442-6358','turpis@yahoo.net','Female','Jun 13, 2005',10,0900,1),
  ('Oneil','Marcia','003-200-6649','curabitur.egestas@outlook.net','Male','May 10, 2005',1,6529,4),
  ('Marshall','Meredith','021-778-8505','nec@protonmail.couk','Female','Sep 22, 2004',3,2940,5),
  ('Merrill','Willow','045-768-7374','nec@hotmail.org','Male','Mar 15, 2005',10,7103,2),
  ('Stanley','Hop','056-417-5094','quis.pede.praesent@aol.net','Male','Feb 13, 2008',8,0700,1),
  ('Hawkins','Pearl','004-333-7465','quisque.fringilla@yahoo.couk','Male','Apr 20, 2005',2,9307,1),
  ('Burks','Dana','061-340-2107','a@yahoo.ca','Male','Aug 20, 2006',10,1201,5),
  ('Montgomery','Teegan','057-244-1276','tincidunt@google.couk','Male','May 13, 2009',5,4930,4),
  ('Hines','Walter','061-056-2477','mauris.vestibulum.neque@google.net','Female','Jul 9, 2005',9,9700,3),
  ('Castillo','Francis','083-858-2055','sociis.natoque.penatibus@outlook.edu','Female','Oct 8, 2006',5,2019,2),
  ('Blake','Zachery','030-414-5410','maecenas.libero.est@aol.net','Female','Jan 19, 2009',3,8460,3),
  ('Mendez','Flynn','077-511-5535','metus.urna@google.net','Female','Mar 8, 2009',10,6529,1),
  ('Gill','Zia','024-386-2138','pharetra.sed@hotmail.com','Female','Apr 22, 2009',5,8460,5),
  ('Hobbs','Caldwell','073-184-0514','proin@protonmail.edu','Female','Jan 21, 2007',7,2940,5),
  ('Ward','Nita','073-317-7111','imperdiet.nec@aol.couk','Female','Jun 26, 2009',2,1201,1),
  ('Lang','Drew','038-114-7133','nec.mollis@icloud.edu','Male','Oct 11, 2008',7,4930,4),
  ('Henry','Brian','077-477-5195','rhoncus.id.mollis@hotmail.couk','Female','Mar 17, 2004',1,8300,5),
  ('Conner','Stephen','003-162-1111','velit.dui.semper@aol.com','Female','Jul 3, 2005',10,5207,4),
  ('Garza','Desiree','013-592-5770','nec.urna.suscipit@aol.net','Female','Oct 3, 2007',5,0900,2),
  ('Hart','Josephine','073-428-1794','ligula@google.edu','Female','Nov 6, 2007',7,2019,4),
  ('Williams','Kyra','033-163-1231','consectetuer.adipiscing@yahoo.ca','Male','Feb 4, 2006',3,9700,2),
  ('Herring','Inez','007-292-8471','cras@protonmail.net','Male','Feb 28, 2007',7,2019,3),
  ('Murphy','Flavia','082-286-6147','sed.est@google.ca','Female','Dec 9, 2007',2,2019,3),
  ('Gordon','Moana','051-421-2263','dolor.vitae@protonmail.edu','Male','Nov 30, 2009',10,4930,2);

INSERT INTO intrests (intrest)
VALUES	('Alcohol, Hiking, Gaming, Fishing'),
		  ('Fishing, Drugs, Gaming, Alcohol'),
		  ('Art, Fishing, Alcohol, Drugs, Exercise'),
		  ('Gaming, Art, Fishing, Nature'),
		  ('Art, Animals, Hiking, Drugs, Nature'),
		  ('Alcohol, Nature'),
		  ('Reading, Drugs, Hiking'),
		  ('Fishing, Nature'),
		  ('Animals, Alcohol, Nature'),
		  ('Fishing, Alcohol, Art'),
		  ('Reading, Nature'),
		  ('Art, Gaming, Exercise'),
		  ('Fishing, Nature, Alcohol, Gaming'),
		  ('Reading, Drugs, Exercise'),
		  ('Music, Reading, Drugs'),
		  ('Music, Animals, Gaming, Alcohol'),
		  ('Animals, Reading, Fishing'),
		  ('Music, Nature, Reading'),
		  ('Exercise, Music, Drugs, Reading'),
		  ('Gaming, Reading, Exercise, Nature'),
		  ('Art, Exercise, Nature'),
		  ('Fishing, Art'),
		  ('Exercise, Nature, Art'),
		  ('Alcohol, Drugs, Art, Gaming, Animals'),
		  ('Reading, Music, Nature, Art'),
		  ('Reading, Alcohol, Nature, Exercise'),
		  ('Music, Nature, Hiking'),
		  ('Gaming, Nature, Music, Art'),
		  ('Music, Reading, Gaming'),
		  ('Fishing, Alcohol, Animals'),
		  ('Music, Exercise, Alcohol'),
		  ('Gaming, Fishing, Music'),
		  ('Drugs, Fishing, Nature, Alcohol'),
		  ('Nature, Art, Hiking, Music, Alcohol'),
		  ('Drugs, Nature, Music, Exercise'),
		  ('Art, Nature, Music, Hiking, Reading'),
		  ('Fishing, Nature, Music, Animals'),
		  ('Reading, Exercise, Alcohol, Hiking'),
		  ('Exercise, Art, Hiking'),
		  ('Drugs, Animals'),
		  ('Nature, Fishing, Animals, Art'),
		  ('Exercise, Fishing, Hiking'),
		  ('Fishing, Hiking, Gaming, Alcohol'),
		  ('Drugs, Animals, Nature'),
		  ('Nature, Fishing, Drugs, Reading, Art'),
		  ('Exercise, Hiking'),
		  ('Nature, Gaming, Animals'),
		  ('Animals, Hiking, Alcohol'),
		  ('Art, Hiking, Drugs'),
		  ('Gaming, Alcohol, Art, Music, Nature');
		
INSERT INTO contact_intrest (intrest_id)
VALUES 	(1),
		(2),
		(3),
		(4),
		(5),
		(6),
		(7),
		(8),
		(9),
		(10),
		(11),
		(12),
		(13),
		(14),
		(15),
		(16),
		(17),
		(18),
		(19),
		(20),
		(21),
		(22),
		(23),
		(24),
		(25),
		(26),
		(27),
		(28),
		(29),
		(30),
		(31),
		(32),
		(33),
		(34),
		(35),
		(36),
		(37),
		(38),
		(39),
		(40),
		(41),
		(42),
		(43),
		(44),
		(45),
		(46),
		(47),
		(48),
		(49),
		(50);
		
INSERT INTO seeking (seeking)
VALUES 	('Long term relationship'),
		('Fling'),
		('Friendship'),
		('Someone with same intrests');
		
INSERT INTO contact_seeking (seeking_id)
VALUES 	 (2),
  (2),
  (3),
  (3),
  (2),
  (4),
  (3),
  (4),
  (1),
  (2),
  (1),
  (1),
  (4),
  (4),
  (1),
  (3),
  (3),
  (1),
  (3),
  (3),
  (2),
  (3),
  (3),
  (2),
  (2),
  (2),
  (1),
  (1),
  (2),
  (1),
  (3),
  (2),
  (3),
  (2),
  (2),
  (1),
  (4),
  (3),
  (3),
  (2),
  (3),
  (1),
  (1),
  (1),
  (3),
  (2),
  (1),
  (2),
  (3),
  (3);
  

   
--ODBC and JDBC Support Chapter 5
 
 WITH RECURSIVE cohort AS (
 SELECT contact_id, prof_id, first_name
 FROM my_contacts
 WHERE contact_id = 2
 UNION
 SELECT e.contact_id, e.prof_id, e.first_name
 FROM my_contacts e
 INNER JOIN cohort s on s.contact_id = e.prof_id)
 SELECT * FROM cohort;
	
--ODBC and JDBC Support Chapter 6
 
 SELECT contact_id, first_name
 FROM my_contacts
 ORDER BY contact_id
 FETCH FIRST ROW ONLY
	
--ODBC and JDBC Support Chapter 7
 
 SELECT my_contacts.contact_id,first_name, profession.profession
 FROM my_contacts
 INNER JOIN profession ON profession.prof_id = my_contacts.prof_id
 --SPECIFIC person
 WHERE my_contacts.contact_id =x ;
 
--ODBC and JDBC Support Chapter 8
 
SELECT s1.first_name, s2.first_name, s1.prof_id
FROM my_contacts s1
INNER JOIN my_contacts s2 ON s1.contact_id <> s2.contact_id
AND s1.prof_id = s2.prof_id;

--ODBC and JDBC Support Chapter 9

SELECT e.first_name, e.last_name, d.profession
FROM my_contacts e
FULL OUTER JOIN profession d ON d.prof_id = e.prof_id;
--Docter null Value

--ODBC and JDBC Support Chapter 10

SELECT e.first_name, e.last_name, d.profession
FROM my_contacts e
FULL OUTER JOIN profession d ON d.prof_id = e.prof_id
WHERE first_name IS NULL

--ODBC and JDBC Support Chapter 11

SELECT d.first_name, d.prof_id, e.prof_id, e.profession
FROM my_contacts AS d
LEFT JOIN profession AS e ON d.prof_id = e.prof_id;
 



--ODBC and JDBC Support Chapter 12

SELECT * FROM status CROSS JOIN intrests;

--ODBC and JDBC Support Chapter 13

SELECT * FROM status NATURAL JOIN intrests;

--ODBC and JDBC Support Chapter 14

SELECT * FROM status
UNION ALL
SELECT * FROM intrests
ORDER BY status ASC;

--ODBC and JDBC Support Chapter 15

SELECT contact_id, prof_id
INTO engineer_contacts
from my_contacts
Where prof_id = 1;

--ODBC and JDBC Support Chapter 16

SELECT AVG (prof_id) FROM my_contacts;
SELECT random() * 100 + 1 AS RAND_1_100;

--ODBC and JDBC Support Chapter 17

SELECT contact_id, prof_id
FROM my_contacts 
WHERE prof_id > (SELECT AVG (prof_id) FROM my_contacts);

--ODBC and JDBC Support Chapter 18

SELECT relname, relpages FROM pg_class 
ORDER BY relpages DESC limit 1;

--ODBC and JDBC Support Chapter 19

SELECT DISTINCT ON
contact_id, prof_id
FROM my_contacts 
WHERE prof_id > (SELECT AVG (prof_id) FROM my_contacts);

--Object-Oriented SQL for Data Complexity 1

CREATE TABLE sales (
    brand VARCHAR NOT NULL,
    segment VARCHAR NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (brand, segment)
);

INSERT INTO sales (brand, segment, quantity)
VALUES
    ('ABC', 'Premium', 100),
    ('ABC', 'Basic', 200),
    ('XYZ', 'Premium', 100),
    ('XYZ', 'Basic', 300);

SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    ROLLUP (brand, segment)
ORDER BY
    brand,
    segment;

--Object-Oriented SQL for Data Complexity 2

SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    CUBE (brand, segment)
ORDER BY
    brand,
    segment;

--Object-Oriented SQL for Data Complexity 3

CREATE INDEX index_contacts ON my_contacts (first_name);

--Object-Oriented SQL for Data Complexity 4

SELECT prof_id, count(prof_id)
FROM my_contacts
GROUP BY prof_id
HAVING count(*)>5;

--Object-Oriented SQL for Data Complexity 7

SELECT first_name, last_name, prof_id, status_id,
RANK () OVER (
PARTITION BY prof_id
ORDER BY status_id)
FROM my_contacts

--Object-Oriented SQL for Data Complexity 8

SELECT first_name, last_name, prof_id, status_id,
DENSE_RANK () OVER (
PARTITION BY prof_id
ORDER BY status_id)
FROM my_contacts

--Object-Oriented SQL for Data Complexity 9

SELECT first_name, prof_id, zip_code,
FIRST_VALUE(first_name) OVER (
PARTITION BY zip_code
ORDER BY first_name )
AS low_first_name
FROM my_contacts

--Object-Oriented SQL for Data Complexity 10

SELECT first_name, prof_id, zip_code,
Last_VALUE(first_name) OVER (
PARTITION BY zip_code
ORDER BY first_name )
AS high_first_name
FROM my_contacts

--Object-Oriented SQL for Data Complexity 11

EXPLAIN SELECT * FROM my_contacts;

--Object-Oriented SQL for Data Complexity 12

CREATE ROLE Brent
LOGIN
PASSWORD 'myPass1';

--Object-Oriented SQL for Data Complexity 13

CREATE ROLE emp;
GRANT emp TO Brent;









SELECT * FROM my_contacts;
SELECT * FROM status;
SELECT first_name, prof_id FROM my_contacts;  --Showing All the collumns in my_contacts table

------Presentation----------
--Chapter 8
--WE are selecting all the people with the same jobs
SELECT s1.first_name, s2.first_name, s1.prof_id 
FROM my_contacts s1
INNER JOIN my_contacts s2 On s1.contact_id <> s2.contact_id
AND s1.prof_id = s2.prof_id;

--Chapter 9
--We are demonstrating full outer join to show which jobs different people have
SELECT e.first_name, e.last_name, d.profession
FROM my_contacts e
FULL OUTER JOIN profession d On d.prof_id = e.prof_id;

--Chapter 12
--SHowing different possibilties between two tables (data)
--SHOWING which people with a certain status and what intrests they can have
SELECT * FROM status CROSS JOIN intrests

--ODBC and JDBC Support Chapter 17 subqueries
--Extracting certain data within a querie to get more summarised data
SELECT contact_id, prof_id
FROM my_contacts 
WHERE prof_id > (SELECT AVG (prof_id) FROM my_contacts);

--Object-Oriented SQL for Data Complexity 8

--DENSE RANK wil ALLocate second place if there is more than 1 first place where Rank wil allocate third place

SELECT first_name, last_name, prof_id, status_id,
DENSE_RANK () OVER (
PARTITION BY prof_id
ORDER BY status_id)
FROM my_contacts

--Object-Oriented SQL for Data Complexity 12
--Creating new users
CREATE ROLE Brent
LOGIN
PASSWORD 'myPass1';

--Object-Oriented SQL for Data Complexity 13
--Creating new user groups
CREATE ROLE emp;
GRANT emp TO Brent;