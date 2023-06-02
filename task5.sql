-- Team Names:
-- Nathan Markham, Jesus Ocampo, Dylan Kau

-- DROP TABLE statements
DROP TABLE Sales_Invoice CASCADE CONSTRAINS PURGE;
DROP TABLE Vendor CASCADE CONSTRAINS PURGE;
DROP TABLE Purchase_Order CASCADE CONSTRAINS PURGE;
DROP TABLE Service_Invoice CASCADE CONSTRAINS PURGE;

CREATE TABLE Sales_Invoice(
  invoice_id    NUMBER(6)   PRIMARY KEY,
  customer_id   NUMBER(6)   NOT NULL REFERENCES customer(customer_id),
  VIN           NUMBER(6)   UNIQUE  NOT NULL REFERENCES sales_vehicle(VIN),
  employee_id   NUMBER(6)   NOT NULL REFERENCES employee(employee_id),
  terms         VARCHAR2(6) NOT NULL,
  tradein_VIN   NUMBER(6)   UNIQUE,
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
  CHECK (terms IN ('credit', 'cash', 'check')
  );
  
CREATE TABLE Service_Invoice (
  si_id NUMBER(4),
  employee_id NUMBER(4) NOT NULL REFERENCES employee(employee_id),
  customer_id NUMBER(6) NOT NULL REFERENCES customer(customer_id),
  service_date DATE NOT NULL,
  service_VIN VARCHAR2(17) NOT NULL REFERENCES service_vehicle(VIN),
  terms VARCHAR2(6) NOT NULL,
  CHECK (terms IN ('credit','cash','check')
  );
  
--Nate's 3 Car Purchases (Step 3 in task 5)
-- Create a vendor to buy vehicles from  *this wasn't listed but I beleive we have to do it
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (100, 'Vintage Auto America', 'Jason Jackson', '1045 Johnson St.', 'Atascadero', 'CA', '93420', 2547368594);

-- First sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('17392043928394073', 1963, 'Lincoln', 'Continental', 'black', 'convertible', 'Good', 'FORSALE', 55000, 90000);
  
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
INSERT INTO Sales_Invoice (invoice_id, customer_id, VIN, employee_id, terms, tradein_VIN);
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

-- Step 5
-- Service Invoices 
--- New customers -- not sold by SLO VA
-- Add new customers

INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (120, 'Joshua', 'Treeburn', '111 Singletree Ct', 'San Luis Obispo', 'CA',93405, 8054529901, 'joshuatree@gmail.com');
-- Add new car to service_vehicle
INSERT INTO service_vehicle (VIN, year, make, model, mileage)
VALUES('3VWCM7AJ1CM123456', 2002, 'Honda', 'Accord', 250000);
-- add new service_invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES(20000, 1009, 120, '5/1/2023', '3VWCM7AJ1CM123456', 'cash');
-- add parts
INSERT INTO service_parts (part_code, service_date, si_id)
VALUES('Oil-5/30', '5/1/2023', 20000);
-- add services
INSERT INTO services_provided (service_code, service_date, si_id)
VALUES('OC-123','5/1/2023',20000);

--2nd Customer not sold by SLO VA (one part, one service)
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (121, 'John', 'Turnover', '111 Higuera St', 'San Luis Obispo','CA',93408, 4158889201, 'johnturnover@gmail.com');
-- add new car to service_vehicle
INSERT INTO service_vehicle (VIN, year, make, model, mileage)
VALUES('JTHBJ46G182123456', 2015, 'Bugatti', 'Chiron', 37000);
-- add new service_invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES(20002, 1008, 121, '5/3/2023', 'JTHBJ46G182123456','credit');
-- add parts
INSERT INTO service_parts (part_code, service_date, si_id)
VALUES('PC-9873', '5/3/2023', 20002);
-- add services
INSERT INTO services_provided (service_code, service_date, si_id)
VALUES('SC-001', '5/3/2023', 20002);

-- 3rd customer not sold by SLO VA (one service)
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (122, 'John', 'Langle', '782 Marsh St', 'San Luis Obispo', 'CA', 93401, 8052348901, 'johnlangle@gmail.com');
-- add new car to service_vehicle
INSERT INTO service_vehicle (VIN, year, make, model, mileage)
VALUES('8Z7TCDKX1WL123456', 2012, 'Dodge', 'Challenger', 20000);
-- add new service_invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES(20003, 1009, 122, '5/4/2023', '8Z7TCDKX1WL123456','check');
-- add services
INSERT INTO services_provided (service_code, service_date, si_id)
VALUES('TR-01', '5/4/2023',20003);
  
--Sold by SLO VA (only one part)
-- copy sales-vehicle into service

INSERT INTO service_vehicle (vin, year, make, model, mileage)
SELECT('24681357902468135', 1995, 'Toyota', 'Tacoma', 67000)
FROM sales_vehicle;
-- create new service-invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES(20002, 1008, 114, '5/2/2023', '24681357902468135', 'credit');
-- add parts
INSERT INTO service_parts (part_code, service_date, si_id)
VALUES('FIL-1234', '5/2/2023', 20002);
  
-- Jesus'  Service Invoices(Step 5 in task 5)
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

-- Queries (Step 6 in task 5)
