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
  VIN               VARCHAR2(17)  UNIQUE NOT NULL REFERENCES sales_vehicle(VIN),
  vendor_id         NUMBER(6)   NOT NULL REFERENCES vendor(vendor_id),
  employee_id       NUMBER(6)   NOT NULL REFERENCES employee(employee_id),
  approving_manager NUMBER(6)   REFERENCES employee(employee_id),
  purchase_date     DATE,
  CHECK (terms IN ('credit', 'cash', 'check'))
  );
  
CREATE TABLE Service_Invoice (
  SI_ID NUMBER(6) PRIMARY KEY,
  employee_id NUMBER(6) NOT NULL REFERENCES employee(employee_id),
  customer_id NUMBER(6) NOT NULL REFERENCES customer(customer_id),
  service_date DATE NOT NULL,
  service_VIN VARCHAR2(17) NOT NULL REFERENCES service_vehicle(VIN),
  terms VARCHAR2(6) NOT NULL,   
  CHECK (terms IN('credit', 'check', 'cash')));

CREATE TABLE Service_Parts (
  Part_Code     VARCHAR2(20),
  Service_Date  DATE,
  si_id NUMBER(6) REFERENCES service_invoice(si_id),
  PRIMARY KEY(Part_Code, si_id));

CREATE TABLE Services_Provided  (
  Service_Code    VARCHAR2(20),
  Service_Date    Date,
  si_id NUMBER(6) REFERENCES service_invoice(si_id),
  PRIMARY KEY(Service_Code, si_id));

 --Nate's 3 Car Purchases (Step 3 in task 5)
-- Create a vendor to buy vehicles from  *this wasn't listed but I beleive we have to do it
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (100, 'Vintage Auto America', 'Jason Jackson', '1045 Johnson St.', 'Atascadero', 'CA', '93420', 2547368594, NULL);

-- First sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('17392043928394073', 1963, 'Lincoln', 'Continental', 'black', 'convertible', 10000, 'Good', 'FORSALE', 55000, 66000);
  
-- PO for Lincoln Continental
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (1, 'cash', '17392043928394073', 100, 1000, '05/29/2023');
  
-- Update of Lincoln Continental purchase order to add manager approval
UPDATE Purchase_Order
SET approving_manager = 1000
WHERE purchase_id = 1;
  
-- Second sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('84638459374937489', 1967, 'Chevrolet', 'Corvette Stingray', 'blue', 'convertible', 25000, 'Great', 'FORSALE', 40000, 48000);
  
-- PO for Chevrolet Stingray
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (2, 'credit', '84638459374937489', 100, 1004, '05/23/2023');
  
-- Update of Chevrolet Stingray purchase order to add manager approval
UPDATE Purchase_Order
SET approving_manager = 1003
WHERE purchase_id = 2;
  
-- Third sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('93759382749506876', 1962, 'Ford', 'Galaxie 500', 'white', NULL, 40000, 'Good', 'FORSALE', 35000, 42000);
  
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
VALUES ('22241113642310809', 2023, 'Porsche', '911 Carrera', 'Metallic Black', 'Shadow Grey', 5, 'New', 'FORSALE', 90000, 108000);
                  
-- Purchase Order for Porsche 911 Carrera
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (4, 'credit', '22241113642310809', 101, 1004, '04/22/2023');

-- Update of Porsche 911 Carrera purchase order to add manager approval
UPDATE  Purchase_Order
SET     approving_manager = 1000
WHERE   purchase_id = 4;

-- New Vendor for fifth vehicle
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (102, 'Classic Cars', 'Roger Falcione', '7400 E Monte Cristo Ave', 'Scottsdale', 'AZ', '85260', 4802851600, NULL);

-- Fifth sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('23163571633042318', 1997, 'Nissan', 'Skyline', 'Bayside Blue', 'GT-R V-Spec', 75000, 'Very Good', 'FORSALE', 53000, 63600);
  
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
VALUES (103, 'Fast Cars & More', 'Neil King', '132 Golden West Pl.', 'Arroyo Grande', 'CA', '93420', 8054437211, NULL);

-- Sixth sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('24681357902468135', 1995, 'Toyota', 'Tacoma', 'Sunshine Red', NULL , 67000, 'Very Good', 'FORSALE', 14000, 16800);
  
 -- PO for car
INSERT INTO Purchase_Order (purchase_id, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (6, 'credit', '24681357902468135', 103, 1004, '06/01/2023');
  
-- Update of 1995 Toyota Tacoma purchase order to add manager approval
UPDATE Purchase_Order
SET    approving_manager = 1000
WHERE  purchase_id = 6;

--- New Vendor
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (104, 'Bobbys Vintage Cars', 'Bobby Lee', '133 Hollywood St.', 'Los Angeles', 'CA', '93408', 8503322782,8053327899);

-- Seventh sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('98765432109876543', 1971, 'Ford', 'Mustang', 'Jet Black', 'Fastback' , 87000, 'Good', 'FORSALE', 41700, 50040);

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
VALUES (110, 'LeBron', 'James', '1234 Lakers St.', 'Los Angeles', 'CA', '90015', '8082546781', 'lebronjames23@lakers.com');

-- Add trade in vehicle to the sales vehicles table
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('83940738467859487', 1970, 'Datsun', '240Z', 'yellow', NULL, 15000, 'Excellent', 'TRADEIN', 15000, 18000);
  
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
VALUES (111, 'Stephen', 'Curry', '5678 Warriors Rd.', 'San Francisco', 'CA', '94016', '8158490049', 'stephencurry30@warriors.com');
  
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
VALUES (112, 'Alejandro', 'Torres', 'S Main St', 'Los Angeles', 'CA', 90011, 3232137802, 'alejandrotorres@gmail.com');

-- add trade in
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('WP0EB0911FS161840', 1985, 'Porsche', '911 Carrera', 'Red', NULL, 77571, 'Used', 'TRADEIN', 85000, 102000);
  
-- add sales invoice
INSERT INTO Sales_Invoice (invoice_id, customer_id, VIN, employee_id, terms, tradein_VIN)
VALUES (10003, 112, '22241113642310809', 1005, 'cash', 'WP0EB0911FS161840');
  
-- update sales invoice to add approval from Larry
UPDATE Sales_Invoice
SET approving_manager = 1000
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
VALUES (113, 'Daniel', 'Solano', '750 Paso de Luz', 'Chula Vista', 'CA', '91911', 6094583118, 'dsolano@gmail.com');

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
VALUES (114, 'Bob', 'Toliver', '1277 Singletree Ct', 'San Luis Obispo', 'CA', '94568', 8052314439, 'btoliver13@gmail.com');

-- add trade in
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES ('4T1BE46K8XU123456', 1972, 'Toyota', 'Corolla', 'Light Blue', NULL, 91047, 'Used', 'TRADEIN', 24000, 28800);
  
-- add sales invoice
INSERT INTO Sales_Invoice (invoice_id, customer_id, VIN, employee_id, terms, tradein_VIN)
VALUES (10005, 114, '24681357902468135', 1004, 'check', '4T1BE46K8XU123456');
  
-- update sales invoice to add approval from Larry
UPDATE Sales_Invoice
SET approving_manager = 1000
WHERE  invoice_id = 10005;

-- update sales vehicle status to sold
UPDATE Sales_Vehicle
SET status = 'SOLD'
WHERE VIN = '24681357902468135';

-- update trade in
UPDATE Sales_Vehicle
SET status = 'FORSALE'
WHERE VIN = '4T1BE46K8XU123456'; 



-- Service Invoices
-- Service Invoice (Step 5 of Task 5) 

INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (120, 'Joshua', 'Treeburn', '111 Singletree Ct', 'San Luis Obispo', 'CA','93405', 8054529901, 'joshuatree@gmail.com');
-- Add new car to service_vehicle
INSERT INTO service_vehicle (VIN, year, make, model, mileage)
VALUES('3VWCM7AJ1CM123456', 2002, 'Honda', 'Accord', 250000);
-- add new service_invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES(20000, 1009, 120, '5/1/2023', '3VWCM7AJ1CM123456', 'cash');
-- add parts
INSERT INTO service_parts (part_code, service_date, si_id)
VALUES('OIL10W30', '5/1/2023', 20000);
-- add services
INSERT INTO services_provided (service_code, service_date, si_id)
VALUES('OILCHG','5/1/2023',20000);

--2nd Customer not sold by SLO VA (one part, one service)
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (121, 'John', 'Turnover', '111 Higuera St', 'San Luis Obispo','CA','93408', 4158889201, 'johnturnover@gmail.com');
-- add new car to service_vehicle
INSERT INTO service_vehicle (VIN, year, make, model, mileage)
VALUES('JTHBJ46G182123456', 2015, 'Bugatti', 'Chiron', 37000);
-- add new service_invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES(20002, 1008, 121, '5/3/2023', 'JTHBJ46G182123456','credit');
-- add parts
INSERT INTO service_parts (part_code, service_date, si_id)
VALUES('WINDSHIELDFLUID', '5/3/2023', 20002);
-- add services
INSERT INTO services_provided (service_code, service_date, si_id)
VALUES('TUNEUPBASIC', '5/3/2023', 20002);

-- 3rd customer not sold by SLO VA (one service)
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (122, 'John', 'Langle', '782 Marsh St', 'San Luis Obispo', 'CA', '93401', 8052348901, 'johnlangle@gmail.com');
-- add new car to service_vehicle
INSERT INTO service_vehicle (VIN, year, make, model, mileage)
VALUES('8Z7TCDKX1WL123456', 2012, 'Dodge', 'Challenger', 20000);
-- add new service_invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES(20003, 1009, 122, '5/4/2023', '8Z7TCDKX1WL123456','check');
-- add services
INSERT INTO services_provided (service_code, service_date, si_id)
VALUES('TIREROTATE', '5/4/2023',20003);
  
--Sold by SLO VA (only one part)
-- copy sales-vehicle into service

INSERT INTO service_vehicle (vin, year, make, model, mileage)
SELECT VIN, year, make, model, mileage
        FROM sales_vehicle
        WHERE VIN = '24681357902468135';

-- create new service-invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES(20001, 1008, 114, '5/2/2023', '24681357902468135', 'credit');
-- add parts
INSERT INTO service_parts (part_code, service_date, si_id)
VALUES('OILFILTER', '5/2/2023', 20001);


-- Jesus'  Service Invoices (Step 5 in task 5)
-- One that was sold by SLO Vintage Auto (Only one part and only one service)

-- add car to sevice vehicle table using an insert/select subquery
INSERT INTO service_vehicle (vin, year, make, model, mileage)
SELECT VIN, year, make, model, mileage
        FROM sales_vehicle
        WHERE VIN = '22241113642310809';

-- add new service invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES (20004, 1009, 112, '05/30/2023', '22241113642310809', 'credit');

-- add service(s)
INSERT INTO services_provided (service_code, service_date, si_id)
VALUES ('OILCHG', '5/30/2023', 20004);

-- add part(s)
INSERT INTO service_parts (part_code, service_date, si_id)
VALUES ('OILFILTER', '5/30/2023', 20004);

-- Another that was sold by SLO VA (Only one part)
-- add car to sevice vehicle table
INSERT INTO service_vehicle (vin, year, make, model, mileage)
SELECT VIN, year, make, model, mileage
        FROM sales_vehicle
        WHERE VIN = '23163571633042318';

-- add new service invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES (20005, 1009, 113, '6/2/2023', '23163571633042318', 'credit');

-- add part(s)
INSERT INTO service_parts (part_code, service_date, si_id)
VALUES ('SPARKPLUG4', '6/2/2023', 20005);

-- Not sold by SLO VA (only one service - tire rotation)
-- add customer to customer table
INSERT INTO customer (customer_id, first_name, last_name, street, city, state, zip, phone, email)
VALUES (125, 'Jeff', 'Jefferson', '2783 Chorro St.', 'San Luis Obispo', 'CA', '93405', 8059998383, 'jeffjohnson1995@yahoo.com');

-- add customer's car to service vehicle table
INSERT INTO service_vehicle (VIN, year, make, model, mileage)
VALUES ('84938726485974857', 2018, 'Ford', 'Mustang', 55000);

-- add new service invoice
INSERT INTO service_invoice (si_id, employee_id, customer_id, service_date, service_vin, terms)
VALUES (20006, 1008, 125, '05/24/2023', '84938726485974857', 'cash');

-- add service
INSERT INTO services_provided (service_code, service_date, si_id)
VALUES ('TIREROTATE', '05/24/2023', 20006);
-- Queries (Step 6 in task 5)


-- Query A
-- Car seller list
CREATE OR REPLACE VIEW car_seller_list AS 
SELECT vendor_name, contact_name, street, city, state, zip, phone, fax
FROM vendor
ORDER BY vendor_name; 


-- Query B, Vehicle Sales List (Nate)

CREATE OR REPLACE VIEW Vehicle_Sales_List 
AS SELECT s.invoice_id, e.first_name || ' ' || e.last_name "Sales Person", a.first_name || ' ' || a.last_name "Approved By", v.VIN "VIN",
          v.make "Make", v.model "Model", NVL(s.tradein_VIN, 'none') "Trade-in VIN", NVL(vt.make, 'none') "Trade-in Make", NVL(vt.model, 'none') "Trade-in Model",
          v.list_price "Selling Price", 0.01 * v.list_price "Shipping", NVL(vt.purchase_price, 0) "Trade-in Allowance", 
          v.list_price + (0.01 * v.list_price) - (NVL(vt.purchase_price, 0)) AS "Subtotal", 
          0.075 * v.list_price "Taxes", v.list_price + (0.01 * v.list_price) - (NVL(vt.purchase_price, 0)) + (0.075 * v.list_price) AS "Total Selling Price"
FROM sales_invoice s LEFT OUTER JOIN employee a ON s.approving_manager = a.employee_id
JOIN employee e ON s.employee_id = e.employee_id
JOIN sales_vehicle v ON v.VIN = s.VIN
LEFT OUTER JOIN sales_vehicle vt ON s.tradein_VIN = vt.VIN;


-- Query C, Vehicle Purchase List
-- Vehicle Purchase List: Purchase Order Number, Company Name, Contact Name, VIN,
-- Make, Model, Sales Amount, Shipping, Taxes, Total Price, Manager Name

CREATE OR REPLACE VIEW Vehicle_Purchase_List
AS SELECT po.purchase_id, v.vendor_name, v.contact_name, po.vin, sv.make, sv.model, sv.list_price,
          0.01 * sv.list_price "Shipping", 0.075 * sv.list_price "Taxes", (0.01 * sv.list_price) + sv.list_price + (0.075 * sv.list_price) "Total Price",
          e.first_name || ' ' || e.last_name "Approving Manager"
FROM purchase_order po JOIN vendor v
ON po.vendor_id = v.vendor_id
JOIN sales_vehicle sv 
ON sv.vin = po.vin
LEFT OUTER JOIN employee e
ON po.approving_manager = e.employee_id;

-- Query D 
-- service invoice list
CREATE OR REPLACE VIEW service_invoice_list AS 
SELECT 
    i.si_id "Invoice Number", 
    c.first_name || ' ' || c.last_name "Customer Name", 
    i.service_vin "VIN", 
    s.make, 
    s.model, 
    s.mileage, 
    NVL(ROUND(SUM(se.price)), 0) "Service Charge",
    NVL(ROUND(SUM(p.price)), 0) "Parts Charge",
    ROUND((NVL(SUM(se.price), 0) + NVL(SUM(p.price), 0)) * .0725, 2) "Taxes", 
    ROUND((NVL(SUM(se.price), 0) + NVL(SUM(p.price), 0)) * .015, 2) "Misc Charges",
    ROUND(NVL(SUM(se.price), 0) + NVL(SUM(p.price), 0) + ((NVL(SUM(se.price), 0) + NVL(SUM(p.price), 0)) * .0725)+ (NVL(SUM(se.price),0)+NVL(SUM(p.price),0)*.015)) "Total Charges"
FROM service_invoice i 
JOIN customer c 
ON i.customer_id = c.customer_id 
JOIN service_vehicle s
ON i.service_vin = s.vin
LEFT JOIN services_provided spr
ON i.si_id = spr.si_id 
LEFT JOIN services se
ON se.service_code = spr.service_code
LEFT JOIN service_parts spa
ON i.si_id = spa.si_id 
LEFT JOIN parts p
ON spa.part_code = p.part_code
GROUP BY i.si_id, c.first_name, c.last_name, i.service_vin, s.make, s.model, s.mileage;
