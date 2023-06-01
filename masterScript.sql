-- Nathan Markham, Jesus Ocampo, and Dylan Kau
-- Drop Tables

DROP TABLE preferences CASCADE CONSTRAINTS PURGE;
DROP TABLE customer CASCADE CONSTRAINTS PURGE;

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
