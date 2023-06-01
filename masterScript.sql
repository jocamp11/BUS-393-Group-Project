-- Nathan Markham, Jesus Ocampo, and Dylan Kau
-- Drop Tables

DROP TABLE preferences CASCADE CONSTRAINTS PURGE;
DROP TABLE customer CASCADE CONSTRAINTS PURGE;
DROP TABLE employee CASCADE CONSTRAINTS PURGE;
DROP TABLE Parts CASCADE CONSTRAINTS PURGE;
DROP TABLE Services CASCADE CONSTRAINTS PURGE;
DROP TABLE Service_Parts CASCADE CONSTRAINTS PURGE;
DROP TABLE Services_Provided CASCADE CONSTRAINTS PURGE;
DROP TABLE Sales_Vehicle CASCADE CONSTRAINTS PURGE
DROP TABLE Service_Vehicle CASCADE CONSTRAINTS PURGE

--  1 Creating Tables
 
-- Create Customer and Preferences Tables

CREATE TABLE customer (
    customer_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(20),
    last_name VARCHAR2(20),
    street VARCHAR2(50),
    city VARCHAR2(20),
    state VARCHAR2(2) DEFAULT 'CA' NOT NULL,
    zip CHAR(5),
    phone VARCHAR2(12) NOT NULL UNIQUE,
    email VARCHAR2(50) NOT NULL UNIQUE);


-- Insert Customer Data
-- Inserts with DEFAULT clause

INSERT INTO customer (customer_id, first_name, last_name, street, city, zip, phone, email) 
VALUES (100, 'John', 'Smith', '1000 Los Valley Road', 'San Luis Obispo', '93408', '805.123.1234', 'jsmith@hotmail.com');
INSERT INTO customer (customer_id, first_name, last_name, street, city, zip, phone, email)
VALUES (101, 'Mary', 'Jones', '12 Peach Street', 'San Luis Obispo', '93401', '800.333.4444', 'mjones@hotmail.com');
INSERT INTO customer (customer_id, first_name, last_name, street, city, zip, phone, email) 
VALUES (102, 'Ian', 'Thomas', '268 Tunnel Ave', 'Los Angeles', '90004', '213.815.4351', 'ian.thomas@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, street, city, zip, phone, email) 
VALUES (103, 'Hank', 'Franklin', '321 Pine St', 'San Diego', '92101', '555-3456', 'alice.smith@example.com');
INSERT INTO customer (customer_id, first_name, last_name, street, city, zip, phone, email) 
VALUES (104, 'Bill', 'Johnson', '654 Broadway', 'Fresno', '93721', '555-7890', 'mike.johnson@example.com');

-- Inserts without DEFAULT clause
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email) 
VALUES (105, 'Sara', 'Lee', '111 Baker St', 'Los Angeles', 'CA', '90001', '555-5555', 'sara.lee@example.com');
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email) 
VALUES (106, 'Tom', 'Jones', '222 Music Ave', 'San Francisco', 'CA', '94102', '555-6666', 'tom.jones@example.com');
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email) 
VALUES (107, 'Karen', 'White', '333 Snow Dr', 'Sacramento', 'CA', '95814', '555-7777', 'karen.white@example.com');
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email) 
VALUES (108, 'Mark', 'Davis', '444 Lake Rd', 'San Diego', 'CA', '92101', '555-8888', 'mark.davis@example.com');
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email) 
VALUES (109, 'Amy', 'Chen', '555 Hill Blvd', 'Fresno', 'CA', '93721', '555-9999', 'amy.chen@example.com');


CREATE TABLE preferences (
    preference_id NUMBER(6) PRIMARY KEY,
    customer_id NUMBER(6) NOT NULL,
    make VARCHAR2(20) NOT NULL,
    model VARCHAR2(20) NOT NULL,
    max_price NUMBER(8, 2) NOT NULL CHECK(max_price > 0),
    start_date DATE DEFAULT SYSDATE,
    end_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT preferences_end_date CHECK (end_date > start_date));
    -- customer_id    NUMBER(6)     NOT NULL REFERENCES customer(customer_id),
    -- CHECK (end_date > start_date

-- Insert Preferences Data
-- One customer (102) has 3 preferences
-- These make use of the default function for start date

INSERT INTO preferences (preference_id, customer_id, make, model, max_price)
VALUES (1, 102, 'Pontiac', 'Firebird', 80000);
INSERT INTO preferences (preference_id, customer_id, make, model, max_price)
VALUES (2, 102, 'Chevrolet', 'Corvette Coupe', 50000);
INSERT INTO preferences (preference_id, customer_id, make, model, max_price)
VALUES (3, 102, 'Ferrari', '360 Modena', 150000);

-- One customer (103) has 2 preferences
-- Three customers (104, 105, 106) each have one preference
-- These do not make use of the default function for start date

INSERT INTO preferences (preference_id, customer_id, make, model, max_price, start_date)
VALUES (4, 103, 'Mazda', 'MX-5 Miata', 40000, '05/01/2001');
INSERT INTO preferences (preference_id, customer_id, make, model, max_price, start_date)
VALUES (5, 103, 'Land Rover', 'Custom', 70000, '06/11/2002');
INSERT INTO preferences (preference_id, customer_id, make, model, max_price, start_date)
VALUES (6, 104, 'Porsche', '914', 200000, '07/21/2003');
INSERT INTO preferences (preference_id, customer_id, make, model, max_price, start_date)
VALUES (7, 105, 'Triumph', 'Spitfire', 90000, '08/22/2004');
INSERT INTO preferences (preference_id, customer_id, make, model, max_price, start_date)
VALUES (8, 106, 'Ford', 'Mustang', 60000, '09/11/2018');


-- VIEW Creation for query A
CREATE OR REPLACE VIEW CustomerList
AS SELECT first_name AS "First Name", last_name AS "Last Name", street, city, state, phone, email
FROM customer;

-- VIEW Creation for query B
CREATE OR REPLACE VIEW PreferenceList
AS SELECT c.first_name AS "First Name", c.last_name AS "Last Name", p.make AS "Make", p.model AS "Model", p.max_price "Max Price", p.start_date "Start Date", p.end_date AS "End Date"
FROM customer c JOIN preferences p
ON (c.customer_id = p.customer_id);

-- VIEW Creation for query C
CREATE OR REPLACE VIEW PreferenceListAll
AS SELECT c.first_name AS "First Name", c.last_name AS "Last Name", phone, NVL(p.make, 'No Preference') AS "Make", p.model AS "Model", p.max_price "Max Price", p.start_date "Start Date", p.end_date AS "End Date"
FROM customer c LEFT JOIN preferences p
ON (c.customer_id = p.customer_id);

-- Create Employee Table

CREATE TABLE employee (
    employee_id NUMBER(4) PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(20) NOT NULL,
    address VARCHAR2(50) NOT NULL,
    city VARCHAR2(20) NOT NULL,
    state VARCHAR2(2) DEFAULT 'CA' NOT NULL,
    zip CHAR(5) NOT NULL,
    phone VARCHAR2(12) NOT NULL UNIQUE,
    email VARCHAR2(50) NOT NULL UNIQUE,
    hire_date DATE DEFAULT SYSDATE NOT NULL,
    title VARCHAR2(20) NOT NULL,
    commission_pct NUMBER(2,2) CHECK(commission_pct BETWEEN 0.20 AND 0.30),
    manager_id NUMBER(4) REFERENCES employee(employee_id),
    CHECK (employee_id <> manager_id));

-- PRIMARY KEY (employee_id),
-- UNIQUE (phone),
-- UNIQUE (email),
-- FOREIGN KEY (manager_id) REFERENCES employee(employee_id),
-- CHECK ((title = 'SalesPerson' AND commission_pct BETWEEN 0.2 AND 0.3) OR (title <>'Saleperson' AND commission_pct is NULL));

-- Insert Employee Data

INSERT INTO employee (employee_id,first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1000, 'Larry', 'Margaria', '475 Sage St', 'San Luis Obispo', '93401', '805-423-6782', '9/1/2001' ,'larrym@gmail.com','Owner/Manager', Null, Null);

INSERT INTO employee (employee_id, first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1001, 'Jim', 'Kaney', '512 Lawrence Dr', 'San Luis Obispo', '93401', '805-521-8432','10/30/2002','jimk@gmail.com','Accounting Manager', Null, 1000);

INSERT INTO employee (employee_id, first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1002, 'Norm', 'Allen', '1713 Singletree Ct', 'San Luis Obispo', '93401', '805-555-4892','11/3/2002','norma@gmail.com','Service Manager', Null, 1000);

INSERT INTO employee (employee_id, first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1003, 'Mary', 'Long', '33 Marsh St', 'San Luis Obispo', '93401', '805-843-9023', '11/5/2007' ,'maryl@gmail.com','Sales Manager', 0.25, 1000);

INSERT INTO employee (employee_id, first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1004, 'Adam', 'Packer', '2102 Vicente Dr', 'San Luis Obispo', '93401', '805-902-6232', '10/21/2017' ,'adamp@gmail.com','Sales Person', 0.22, 1003);

INSERT INTO employee (employee_id, first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1005, 'Larry', 'Jones', '1778 Huasana Dr', 'San Luis Obispo', '93401', '805-403-9091', '1/1/2018' ,'larryj@gmail.com','Sales Person', 0.24, 1003);

INSERT INTO employee (employee_id, first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1006, 'Steve', 'Euro', '1966 Lima Dr', 'San Luis Obispo', '93401', '805-324-5043', '3/4/2019' ,'stevee@gmail.com','Cashier', Null, 1001);

INSERT INTO employee (employee_id, first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1007, 'Alice', 'Credit', '1765 Pinecove Dr', 'San Luis Obispo', '93401', '805-301-9213', '3/10/2019' ,'alicec@gmail.com','Bookkeeper', Null, 1001);

INSERT INTO employee (employee_id, first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1008, 'Alan', 'Wrench', '1150 Seaward St', 'San Luis Obispo', '93401', '805-124-6721', '6/6/2019' ,'alanw@gmail.com','Service Worker', Null, 1002);

INSERT INTO employee (employee_id,first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1009, 'Woody', 'Apple', '1524 Balboa St', 'San Luis Obispo', '93401', '805-221-7214', '8/10/2019' ,'woodya@gmail.com','Service Worker', Null, 1002);

INSERT INTO employee (employee_id,first_name, last_name, address, city, zip, phone, hire_date, email, title, commission_pct, manager_id)
VALUES (1010, 'Sherry', 'Sophomore', '93 Mustang Ln', 'San Luis Obispo', '93401', '415-714-2098', '1/14/2023' ,'sherrys@gmail.com','Intern', Null, 1009);

-- #4 Create View Data
CREATE OR REPLACE VIEW EmployeeContactList 
AS SELECT first_name AS "First Name", last_name AS "Last Name", phone AS "Phone", email AS "Email"
FROM employee
ORDER BY last_name;

CREATE OR REPLACE VIEW EmployeeReportingList
AS SELECT m.first_name || ' ' || m.last_name AS "Manager",
    m.title AS "Manager Title",
    r.first_name || ' ' || r.last_name AS "Reportee",
    r.title AS "Reportee Title"
FROM employee m
INNER JOIN employee r ON m.employee_id = r.manager_id
ORDER BY m.last_name;

CREATE TABLE Services (
  Service_Code    VARCHAR2(20)    PRIMARY KEY,
  Description     VARCHAR2(30)    NOT NULL,
  Cost            NUMBER(6,2)     NOT NULL,
  Price           NUMBER(6,2)     NOT NULL,
  Months          NUMBER(3)       NOT NULL,
  Mileage         NUMBER(7)       NOT NULL,
  CHECK(Cost > 0),
  CHECK(Price > 0),
  CHECK(Months > 0),
  CHECK(Mileage > 0));
  
INSERT INTO Services  (Service_Code, Description, Cost, Price, Months, Mileage)
VALUES ('OILCHG', 'Oil Change', 9.95, 10.95, 6, 6000);
INSERT INTO Services  (Service_Code, Description, Cost, Price, Months, Mileage)
VALUES ('TIREROTATE', 'Tire Rotation', 6.95, 9.95, 12, 12000);
INSERT INTO Services  (Service_Code, Description, Cost, Price, Months, Mileage)
VALUES ('FLUIDS', 'Fluid Replacement', 29.95, 49.96, 30, 30000);
INSERT INTO Services  (Service_Code, Description, Cost, Price, Months, Mileage)
VALUES ('TUNEUPBASIC', 'Basic Engine tune up', 69.95, 149.95, 18, 18000);
INSERT INTO Services  (Service_Code, Description, Cost, Price, Months, Mileage)
VALUES ('MULTIPOINTINSP', 'Multi-Point inspection', 29.95, 59.95, 6, 6000);
  
CREATE TABLE Parts  (
  Part_Code       VARCHAR2(20)    PRIMARY KEY,
  Description     VARCHAR2(30)    NOT NULL,
  Cost            NUMBER(6,2)     NOT NULL,
  Price           NUMBER(6,2)     NOT NULL,
  CHECK(Cost > 0),
  CHECK(Price > 0));
  
INSERT INTO Parts (Part_Code, Description, Cost, Price)
VALUES('OIL10W30','Oil 10W30', 2.79, 3.95);
INSERT INTO Parts (Part_Code, Description, Cost, Price)
VALUES('OILFILTER','Oil Filter', 6.95, 11.95);
INSERT INTO Parts (Part_Code, Description, Cost, Price)
VALUES('WINDSHIELDFLUID','Windshield Fluid', 2.96, 4.95);
INSERT INTO Parts (Part_Code, Description, Cost, Price)
VALUES('SPARKPLUG4', 'Spark plug set (4)', 9.95, 19.95);
INSERT INTO Parts (Part_Code, Description, Cost, Price)
VALUES('AIRFILTER', 'Air Filter', 3.95, 8.95);

-- This is the associative entity table between the Service_invoice table and Parts table
-- Will add in the foreign key for the Service Invoice Later

CREATE TABLE Service_Parts (
  Part_Code     VARCHAR2(20),
  Service_Date  DATE,
  PRIMARY KEY(Part_Code, Service_Date));

-- This is the associative entity table between the Service_Invoice table and Services table
--  We will add in the foreign key for the Service Invoice Later

CREATE TABLE Services_Provided  (
  Service_Code    VARCHAR2(20),
  Service_Date    Date,
  PRIMARY KEY(Service_Code, Service_Date));

-- Views for task 3

CREATE OR REPLACE VIEW Service_List
AS SELECT Service_Code, Description, Cost, Price, Months, Mileage
FROM Services
ORDER BY Service_Code;

CREATE OR REPLACE VIEW Part_List
AS SELECT Part_Code, Description, Cost, Price
FROM Parts
ORDER BY Part_Code;

-- Create Sales_Vehicle & Service_Vehicle

CREATE TABLE Sales_Vehicle (
  VIN             VARCHAR2(17)  PRIMARY KEY,
  year            NUMBER(4)     NOT NULL,
  make            VARCHAR2(30)  NOT NULL,
  model           VARCHAR2(30)  NOT NULL,
  exterior_color  VARCHAR2(20)  NOT NULL,
  trim            VARCHAR2(20),
  mileage         NUMBER(8, 2)  NOT NULL,
  condition       VARCHAR2(20),
  status          VARCHAR2(7)  NOT NULL,
  purchase_price  NUMBER(8, 2),
  list_price      NUMBER(8, 2),
  CHECK(status IN ('SOLD', 'FORSALE', 'TRADEIN'),
  CHECK(mileage > 0),
  CHECK (purchase_price > 0),
  CHECK (list_price > 0));
 -- We are assuming that there are cases where price could be lower than cost 
 -- (EX: A car isn't selling and Larry is willing to give a good deal to get rid of it)
  

CREATE TABLE Service_Vehicle (
  VIN       VARCHAR2(17)  PRIMARY KEY,
  year      NUMBER(4)     NOT NULL,
  make      VARCHAR2(30)  NOT NULL,
  model     VARCHAR2(30)  NOT NULL,
  mileage   NUMBER(8, 2)  NOT NULL,
  CHECK(mileage > 0));
