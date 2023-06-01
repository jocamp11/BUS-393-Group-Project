-- Nathan Markham, Jesus Ocampo, and Dylan Kau
-- Drop Tables

DROP TABLE preferences CASCADE CONSTRAINTS PURGE;
DROP TABLE customer CASCADE CONSTRAINTS PURGE;
DROP TABLE employee CASCADE CONSTRAINTS PURGE;
DROP TABLE Parts CASCADE CONSTRAINTS PURGE;
DROP TABLE Services CASCADE CONSTRAINTS PURGE;
DROP TABLE Service_Parts CASCADE CONSTRAINTS PURGE;
DROP TABLE Services_Provided CASCADE CONSTRAINTS PURGE;
DROP TABLE Sales_Vehicle CASCADE CONSTRAINTS PURGE;
DROP TABLE Service_Vehicle CASCADE CONSTRAINTS PURGE;
DROP TABLE Sales_Invoice CASCADE CONSTRAINTS PURGE;
DROP TABLE Vendor CASCADE CONSTRAINTS PURGE;
DROP TABLE Purchase_Order CASCADE CONSTRAINTS PURGE;
DROP TABLE Service_Invoice CASCADE CONSTRAINTS PURGE;

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
    employee_id NUMBER(6) PRIMARY KEY,
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
  CHECK(status IN ('SOLD', 'FORSALE', 'TRADEIN')),
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
  
  CREATE TABLE Sales_Invoice(
  invoice_id    NUMBER(6)   PRIMARY KEY,
  customer_id   NUMBER(6)   NOT NULL REFERENCES customer(customer_id),
  VIN           VARCHAR2(17)   UNIQUE  NOT NULL REFERENCES sales_vehicle(VIN),
  employee_id   NUMBER(6)   NOT NULL REFERENCES employee(employee_id),
  terms         VARCHAR2(6) NOT NULL,
  tradein_VIN   VARCHAR2(17)   UNIQUE  REFERENCES sales_vehicle(VIN),
  approving_manager   NUMBER(6) REFERENCES employee(employee_id),
  sale_date     DATE,
  CHECK(terms IN('cash', 'check', 'credit')));

CREATE TABLE Vendor (
  vendor_id     NUMBER(6)   PRIMARY KEY,
  vendor_name   VARCHAR2(30)  UNIQUE  NOT NULL,
  contact_name  VARCHAR2(30),
  street        VARCHAR2(30)  NOT NULL,
  city          VARCHAR2(30)  NOT NULL,
  state         VARCHAR2(30)  NOT NULL,
  zip           VARCHAR2(30)  NOT NULL,
  phone         VARCHAR2(11)  UNIQUE  NOT NULL,
  fax           NUMBER(10));
  
CREATE TABLE Purchase_Order (
  purchase_id  NUMBER(6)   PRIMARY KEY,
  terms             VARCHAR2(6) NOT NULL,
  VIN               NUMBER(17)  UNIQUE NOT NULL REFERENCES sales_vehicle(VIN),
  vendor_id         NUMBER(6)   NOT NULL REFERENCES vendor(vendor_id),
  employee_id       NUMBER(6)   NOT NULL REFERENCES employee(employee_id),
  approving_manager NUMBER(6)   REFERENCES employee(employee_id),
  purchase_date     DATE,
  CHECK (terms IN ('credit', 'cash', 'check'))
  );
  
CREATE TABLE Service_Invoice (
  invoice_number NUMBER(4),
  employee_id NUMBER(4) NOT NULL REFERENCES employee(employee_id),
  customer_id NUMBER(6) NOT NULL REFERENCES customer(customer_id),
  service_date DATE NOT NULL,
  service_code VARCHAR2(20) NOT NULL,
  service_VIN VARCHAR2(17) NOT NULL REFERENCES service_vehicle(VIN), 
  parts_code VARCHAR2(20),   
  );

 --Nate's 3 Car Purchases (Step 3 in task 5)
-- Create a vendor to buy vehicles from  *this wasn't listed but I beleive we have to do it
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (100, 'Vintage Auto America', 'Jason Jackson', '1045 Johnson St.', 'Atascadero', 'CA', '93420', 2547368594, NULL);

-- First sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('17392043928394073', 1963, 'Lincoln', 'Continental', 'black', 'convertible', 10000, 'Good', 'FORSALE', 55000, 90000);
  
-- PO for Lincoln Continental
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (1, 'cash', '17392043928394073', 100, 1000, '05/29/2023');
  
-- Update of Lincoln Continental purchase order to add manager approval
UPDATE Purchase_Order
SET approving_manager = 1000
WHERE purchase_id = 1;
  
-- Second sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('84638459374937489', 1967, 'Chevrolet', 'Corvette Stingray', 'blue', 'convertible', 'Great', 'FORSALE', 40000, 60000);
  
-- PO for Chevrolet Stingray
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (2, 'credit', '84638459374937489', 100, 1004, '05/23/2023');
  
-- Update of Chevrolet Stingray purchase order to add manager approval
UPDATE Purchase_Order
SET approving_manager = 1003
WHERE purchase_id = 2;
  
-- Third sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('93759382749506876', 1962, 'Ford', 'Galaxie 500', 'white', NULL, 'Good', 'FORSALE', 35000, 80000);
  
-- PO for Ford Galaxie 500
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (3, 'cash', '93759382749506876', 100, 1005, '05/26/2023');
  
-- Update of Ford Galaxie 500 purchase order to add manager approval
UPDATE Purchase_Order
SET approving_manager = 1000
WHERE purchase_id = 3;
                        
--Jesus' 2 Car Purchases (Step 3 in task 5)
-- Create new vendor to buy vehicles from 
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (101, 'LAX Porsche', 'Alan Jones', '112 Airport Drive', 'Los Angeles', 'CA', '90045', 8005551123, 8005554211);
  
-- Porsche from PO example
-- Fourth sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('22241113642310809', 2023, 'Porsche', '911 Carrera', 'Metallic Black', 'Shadow Grey', 'New', 'FORSALE', 89400, 97175);
                  
-- Purchase Order for Porsche 911 Carrera
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (4, 'credit', '22241113642310809', 101, 1004, '04/22/2023');

-- Update of Porsche 911 Carrera purchase order to add manager approval
UPDATE  Purchase_Order
SET     approving_manager = 1000
WHERE   purchase_id = 4;

-- New Vendor for fifth vehicle
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (102, 'Classic Cars', 'Roger Falcione', '7400 E Monte Cristo Ave', 'Scottsdale', 'AZ', '85260', 4802851600);

-- Fifth sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('23163571633042318', 1997, 'Nissan', 'Skyline', 'Bayside Blue', 'GT-R V-Spec', 75000, 'Very Good', 'FORSALE', 53000, 85000);
  
 -- Purchase Order for Nissan Skyline
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (5, 'cash', '23163571633042318', 102, 1004, '05/31/2023');
  
-- Update of Nissan Skyline GT-R VSPEC purchase order to add manager approval
UPDATE Purchase_Order
SET    approving_manager = 1000
WHERE  purchase_id = 5;

--Dylan's 2 Car Purchases (Step 3 in task 5)
--New Vendor 
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (103, 'Fast Cars & More', 'Neil King', '132 Golden West Pl.', 'Arroyo Grande', 'CA', '93420', 8054437211);

-- Sixth sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('24681357902468135', 1995, 'Toyota', 'Tacoma', 'Sunshine Red', NULL , 67000, 'Very Good', 'FORSALE', 14000, 27000);
  
 -- PO for car
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (6, 'credit', '24681357902468135', 103, 1004, '06/01/2023');
  
-- Update of 1995 Toyota Tacoma purchase order to add manager approval
UPDATE Purchase_Order
SET    approving_manager = 1000
WHERE  purchase_id = 6;

--- New Vendor
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (104, "Bobby's Vintage Cars", 'Bobby Lee', '133 Hollywood St.', 'Los Angeles', 'CA', '93408', 8503322782,8053327899);

-- Seventh sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('98765432109876543', 1971, 'Ford', 'Mustang', 'Jet Black', 'Fastback' , 87000, 'Good', 'FORSALE', 41700, 79000);

-- PO for car
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (7, 'check', '98765432109876543', 104, 1005, '06/02/2023');

-- Update of 1971 Ford Mustang purchase order to add manager approval
UPDATE Purchase_Order
SET    approving_manager = 1000
WHERE  purchase_id = 7;

  
-- Nate's 2 sales (Step 4 in task 5) out of 5 total
-- Add 1st customer to the customer table (trade-in)
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (110, LeBron, James, '1234 Lakers St.', 'Los Angeles', 'CA', '90015', '8082546781', 'lebronjames23@lakers.com');

-- Add trade in vehicle to the sales vehicles table
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('83940738467859487', 1970, 'Datsun', '240Z', 'yellow', NULL, 'Excellent', 'TRADEIN', 15000, NULL);
  
-- Add sales invoice for the 1st car being bought
INSERT INTO Sales_Invoice (invoice_id, customer_id, VIN, employee_id, terms, tradein_VIN)
VALUES (10000, 110, '17392043928394073', 1005, 'cash', '83940738467859487');
  
-- Update sales invoice to add approval from Larry
UPDATE Sales_Invoice
SET approving_manager = 1000
WHERE invoice_id = 10000;
  
-- Update sales vehicle status to sold
UPDATE Sales_Vehicle 
SET status = 'SOLD'
WHERE VIN = '17392043928394073';
  
-- Update trade in to be listed as 'FORSALE'
UPDATE Sales_Vehicle
SET status = 'FORSALE'
WHERE VIN = '83940738467859487';
  
-- 2nd Customer to the customer table 
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (111, Stephen, Curry, '5678 Warriors Rd.', 'San Francisco', 'CA', '94016', '8158490049', 'stephencurry30@warriors.com');
  
-- Add sales invoice for the 2nd car being bought
INSERT INTO Sales_Invoice (invoice_id, customer_id, VIN, employee_id, terms)
VALUES (10002, 111, '84638459374937489', 1004, 'credit');
  
-- Update sales invoice to add approval from Larry
UPDATE Sales_Invoice
SET approving_manager = 1000
WHERE invoice_id = 10002;
  
-- Update sales vehicle status to sold
UPDATE Sales_Vehicle 
SET status = 'SOLD'
WHERE VIN = '84638459374937489';
  
-- Jesus' 2 sales (Step 4 in task 5) out of 5 total
-- 3rd customer to the customer table (trade-in)
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (112, 'Alejandro', 'Torres', 'S Main St', 'Los Angeles', 90011, 3232137802, 'alejandrotorres@gmail.com');

-- add trade in
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('WP0EB0911FS161840', 1985, 'Porsche', '911 Carrera', 'Red', NULL, 77571, 'Used', 'TRADEIN', 84499, 94499);
  
-- add sales invoice
INSERT INTO Sales_Invoice (invoice_id, customer_id, VIN, employee_id, terms, tradein_VIN)
VALUES (10003, 112, '22241113642310809', 1005, 'cash', 'WP0EB0911FS161840');
  
-- update sales invoice to add approval from Larry
UPDATE Sales_Invoice
SET approving_manager = 100
WHERE  invoice_id = 10003;

-- update sales vehicle status to sold
UPDATE Sales_Vehicle
SET status = 'SOLD'
WHERE VIN = '22241113642310809';
  
-- update trade in
UPDATE Sales_Vehicle
SET status = 'FORSALE'
WHERE VIN = 'WP0EB0911FS161840';
  
-- 4th customer to the customer table (no trade-in)
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (113, 'Daniel', 'Solano', '750 Paso de Luz', 'Chula Vista', 91911, 6094583118, 'dsolano@gmail.com');

-- add sales invoice
INSERT INTO Sales_Invoice (invoice_id, customer_id, VIN, employee_id, terms, tradein_VIN)
VALUES (10004, 113, '23163571633042318', 1005, 'cash', NULL);
  
-- update sales invoice
UPDATE Sales_Invoice
SET approving_manager = 1000 
WHERE invoice_id = 10004;

-- update sales vehicle
UPDATE Sales_Vehicle
SET status = 'SOLD'
WHERE VIN = '23163571633042318';

-- Dylan's Sale
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (114, 'Bob', 'Toliver', '1277 Singletree Ct', 'San Luis Obispo', 94568, 8052314439, 'btoliver13@gmail.com');

-- add trade in
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('4T1BE46K8XU123456', 1972, 'Toyota', 'Carolla', 'Light Blue', NULL, 91047, 'Used', 'TRADEIN', 24000, 40000);
  
-- add sales invoice
INSERT INTO Sales_Invoice (invoice_id, customer_id, VIN, employee_id, terms, tradein_VIN)
VALUES (10005, 114, '24681357902468135', 1004, 'check', '4T1BE46K8XU123456');
  
-- update sales invoice to add approval from Larry
UPDATE Sales_Invoice
SET approving_manager = 100
WHERE  invoice_id = 10005;

-- update sales vehicle status to sold
UPDATE Sales_Vehicle
SET status = 'SOLD'
WHERE VIN = '24681357902468135';

-- update trade in
UPDATE Sales_Vehicle
SET status = 'FORSALE'
WHERE VIN = '4T1BE46K8XU123456'; 


-- Jesus'  Service Invoices (Step 5 in task 5)
-- One that was sold by SLO Vintage Auto (Only one part and only one service)
-- add customer to customer table, if needed
  
-- add car to sevice vehicle table
  
-- add new service invoice
  
-- add service(s)
  
-- add part(s)
  
-- Another that was sold by SLO VA (Only one part)
-- add customer to customer table, if needed
  
-- add car to sevice vehicle
  
-- add new service vehicle
  
-- add part(s)

-- Not sold by SLO VA (only one service - tire rotation)
-- add customer to customer table
  
-- Not sold by SLO VA (only one service, one part)
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (120, 'Joshua', 'Treeburn', '111 Singletree Ct', 'San Luis Obispo', 93405, 8054529901, 'joshuatree@gmail.com') 

INSERT INTO service_vehicle (VIN, year, make, model, mileage)
VALUES('65432109876543210', 2002, 'Honda', 'Accord', 250000)

INSERT INTO service_invoice (invoice_number, employee_id, customer_id, service_date, service_vin)
VALUES(10000, 1002, 120, 6/1/2023, '3VWCM7AJ1CM123456')

INSERT INTO service_parts (part_code, service_date, invoice_number)
VALUES('Oil-5/30', 6/1/2023, '3VWCM7AJ1CM123456')

INSERT INTO services_provided (service_code, service_date, invoice number)
VALUES(OC-123,6/1/2023,'3VWCM7AJ1CM123456')
-- Queries (Step 6 in task 5)
