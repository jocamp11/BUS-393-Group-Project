-- Team Names:
-- Nathan Markham, Jesus Ocampo, Dylan Kau

-- DROP TABLE statements
DROP TABLE Sales_Invoice CASCADE CONSTRAINS PURGE
DROP TABLE Vendor CASCADE CONSTRAINS PURGE
DROP TABLE Purchase_Order CASCADE CONSTRAINS PURGE
DROP TABLE Service_Invoice CASCADE CONSTRAINS PURGE

CREATE TABLE Sales_Invoice(
  invoice_id    NUMBER(6)   PRIMARY KEY,
  customer_id   NUMBER(6)   NOT NULL REFERENCES customer(customer_id),
  VIN           NUMBER(6)   UNIQUE NOT NULL REFERENCES sales_vehicle(VIN),
  employee_id   NUMBER(6)   NOT NULL REFERENCES employee(employee_id),
  tradein_VIN   NUMBER(6)   UNIQUE,
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
  purchase_ID  NUMBER(6)   PRIMARY KEY,
  terms             VARCHAR2(6) NOT NULL,
  VIN               NUMBER(17)  NOT NULL REFERENCES sales_vehicle(VIN),
  vendor_id         NUMBER(6)   NOT NULL REFERENCES vendor(vendor_id),
  employee_id       NUMBER(6)   NOT NULL REFERENCES employee(employee_id),
  approving_manager NUMBER(6)   REFERENCES employee(employee_id),
  purchase_date     DATE,
  CHECK (terms IN ('credit', 'cash', 'check')
  );
  
  CREATE TABLE Service_Invoice (
    
    );
  
--Nate's 3 Car Purchases (Step 3 in task 5)
-- Create a vendor to buy vehicles from  *this wasn't listed but I beleive we have to do it
INSERT INTO Vendor (vendor_id, vendor_name, contact_name, street, city, state, zip, phone, fax)
VALUES (100, 'Vintage Auto America', 'Jason Jackson', '1045 Johnson St.', 'Atascadero', 'CA', '93420', 2547368594);

-- First sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES (17392043928394073, 1963, 'Lincoln', 'Continental', 'black', 'convertible', 'Good', 'FORSALE', 55000, 90000);
  
-- PO for Lincoln Continental
INSERT INTO Purchase_Order (purchase_ID, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (1, 'cash', 17392043928394073, 100, 1000, '05/29/2023');
  
-- Update of Lincoln Continental purchase order to add manager approval
UPDATE Purchase_Order
SET approving_manager = 1000
WHERE purchase_ID = 1;
  
-- Second sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES (84638459374937489, 1967, 'Cheverlet', 'Corvette Stingray', 'blue', 'convertible', 'Great', 'FORSALE', 40000, 60000);
  
-- PO for Cheverlet Stingray
INSERT INTO Purchase_Order (purchase_ID, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (2, 'credit', 84638459374937489, 100, 1004, '05/23/2023');
  
-- Update of Lincoln Continental purchase order to add manager approval
UPDATE Purchase_Order
SET approving_manager = 1003
WHERE purchase_ID = 2;
  
-- Third sales vehicle insert statement
INSERT INTO Sales_Vehicle (VIN, year, make, model, exterior_color, trim, mileage, condition, status, purchase_price, list_price)
VALUES (93759382749506876, 1962, 'Ford', 'Galaxie 500', 'white', NULL, 'Good', 'FORSALE', 35000, 80000);
  
-- PO for Ford Galaxie 500
INSERT INTO Purchase_Order (purchase_ID, terms, VIN, vendor_id, employee_id, purchase_date)
VALUES (3, 'cash', 93759382749506876, 100, 1005, '05/26/2023');
  
-- Update of Lincoln Continental purchase order to add manager approval
UPDATE Purchase_Order
SET approving_manager = 1000
WHERE purchase_ID = 3;
                        



