CREATE TABLE Sales_Invoice(
  invoice_id    NUMBER(6)   PRIMARY KEY,
  customer_id   NUMBER(6)   NOT NULL REFERENCES customer(customer_id),
  VIN           NUMBER(6)   NOT NULL REFERENCES sales_vehicle(VIN),
  employee_id   NUMBER(6)   NOT NULL REFERENCES employee(employee_id),
  sale_date     DATE);

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
   -- Associative entity Vehicle, Vendor and Employee (NEED TO CREATE VENDOR TABLE)
  purchase_orderID  NUMBER(6)   PRIMARY KEY,
  terms             VARCHAR2(10) 
    CONSTRAINT po_terms_method CHECK('credit', 'cash', 'check', 'financed'),
  VIN               NUMBER(17)  NOT NULL REFERENCES customer(customer_id),
  vendor_id         NUMBER(6)   NOT NULL REFERENCES sales_vechicle(VIN),
  employee_id       NUMBER(6)   NOT NULL REFERENCES employee(employee_id),
  purchase_date     DATE
  );
  
  CREATE TABLE Service_Invoice (
    
    );




