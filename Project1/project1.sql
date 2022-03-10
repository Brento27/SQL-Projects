CREATE TABLE Employees (
	emp_id bigserial,
	first_name varchar(25),
	surname varchar(50),
	gender varchar(6),
	address varchar (150),
	email varchar (100),
	depart_id serial REFERENCES Department (depart_id),
	role_id	serial REFERENCES Roles (role_id),
	salary_id serial REFERENCES Salaries (salary_id),
	overtime_id serial REFERENCES Overtime_Hours (overtime_id),
	CONSTRAINT emp_key PRIMARY KEY (emp_id),
	CONSTRAINT email_unique UNIQUE (email)
);

CREATE TABLE Department (
	depart_id serial,
	depart_name varchar(50),
	depart_city varchar(30),
	CONSTRAINT depart_key PRIMARY KEY (depart_id)
);

CREATE TABLE Roles (
	role_id serial,
	"role" varchar(75),
	CONSTRAINT role_key PRIMARY KEY (role_id)
);

CREATE TABLE Salaries (
	salary_id serial,
	salary_pa bigint,
	CONSTRAINT salary_key PRIMARY KEY (salary_id)
);

CREATE TABLE Overtime_Hours(
	overtime_id serial,
	overtime_hours smallint,
	CONSTRAINT overtime_key PRIMARY KEY (overtime_id)
);

INSERT INTO Employees (first_name, surname, gender, address, email, depart_id, role_id, salary_id, overtime_id)
VALUES 	('Brent', 'Lombaard', 'Male', '13 van der merwe str', 'lombaardbrent@gmail.com', 1, 2, 4, 3),
		('Zelda', 'Boshof', 'Female', '24 livingstone str', 'zeldaboshof@gmail.com', 2, 3, 1, 5),
		('Dian', 'Reinecke', 'Male', '5 enghelbrecght str', 'dianreinecke@gmail.com', 3, 3, 4, 6),
		('Franco', 'Salim', 'Male', '18 kroon str', 'francosalim@gmail.com', 4, 1, 4, 2),
		('Dyllan', 'Van Den Heever', 'Male', '18a wagtial crest', 'dyllanvdh@gmail.com', 2, 1, 2, 1),
    	('Armand', 'Ooztuizen', 'Male', '27 owl street', 'armando2@gmail.com', 4, 3, 5, 2),
    	('Andrea', 'Fick', 'Female','90 redback road', 'andreafck98@yahoo.com', 1, 2, 6, 3);

INSERT INTO Department (depart_name, depart_city)
VALUES 	('IT', 'Joburg'),
		('Management', 'Pretoria'),
		('Advertisement', 'Centurion'),
		('Cleric', 'Pretoria');
		
INSERT INTO Roles ("role")
Values 	('Senior'),
		('Junior'),
		('Rep');
		
INSERT INTO Salaries (salary_pa)
Values 	(300000),
		(350000),
		(450000),
		(600000),
		(750000),
		(800000);
		
INSERT INTO Overtime_Hours (overtime_hours)
VALUES 	(2),
		(4),
		(6),
		(8),
		(10),
		(12);
		
SELECT emp.first_name, emp.surname, emp.gender, emp.address, emp.email, dep.depart_name, roles.role, salaries.salary_pa, overtime_hours.overtime_hours
from employees AS emp LEFT JOIN department AS dep
	ON emp.depart_id = dep.depart_id
lEFT JOIN roles
	ON emp.role_id = roles.role_id
LEFT JOIN salaries
	ON emp.salary_id = salaries.salary_id
LEFT JOIN overtime_hours
	ON emp.overtime_id =overtime_hours.overtime_id;