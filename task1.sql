-- Drop Tables

-- Testing

-- in github
DROP TABLE customer;
DROP TABLE preferences;

--  1 Creating Tables
 
-- Create Customer and Preferences Tables

CREATE TABLE customer (
    customer_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(20) NOT NULL,
    street VARCHAR2(50) NOT NULL,
    city VARCHAR2(20) NOT NULL,
    state VARCHAR2(2) DEFAULT('CA') NOT NULL,
    zip NUMBER(5) NOT NULL,
    phone VARCHAR2(12) NOT NULL UNIQUE,
    email VARCHAR2(50) NOT NULL UNIQUE,
);

CREATE TABLE preferences (
    preference_id NUMBER(6) PRIMARY KEY,
    customer_id NUMBER(6) NOT NULL,
    make VARCHAR2(20) NOT NULL,
    model VARCHAR2(20) NOT NULL,
    max_price NUMBER(12) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    CONSTRAINT preferences_end_date CHECK (end_date > start_date)
);



--  2 Data 

-- Insert Customer Data

-- Inserts with DEFAULT clause
INSERT INTO customer (first_name, last_name, street, city, zip, phone, email) 
VALUES ('Ian', 'Thomas', '268 Tunnel Ave', 'Los Angeles', '90004', '213.815.4351', 'ian.thomas@gmail.com');
INSERT INTO customer (first_name, last_name, street, city, zip, phone, email) 
VALUES ('John', 'Smith', '1000 Los Valley Road', 'San Luis Obispo', '93408', '805.123.1234', 'jsmith@hotmail.com');
INSERT INTO customer (first_name, last_name, street, city, zip, phone, email)
VALUES ('Mary', 'Jones', '12 Peach Street', 'San Luis Obispo', '93401', '800.333.4444', 'mjones@hotmail.com');
INSERT INTO customer (first_name, last_name, street, city, zip, phone, email) 
VALUES ('Hank', 'Franklin', '321 Pine St', 'San Diego', '92101', '555-3456', 'alice.smith@example.com');
INSERT INTO customer (first_name, last_name, street, city, zip, phone, email) 
VALUES ('Bill', 'Johnson', '654 Broadway', 'Fresno', '93721', '555-7890', 'mike.johnson@example.com');

-- Inserts without DEFAULT clause
INSERT INTO customer (first_name, last_name, street, city, state, zip, phone, email) 
VALUES ('Sara', 'Lee', '111 Baker St', 'Los Angeles', 'CA', '90001', '555-5555', 'sara.lee@example.com');
INSERT INTO customer (first_name, last_name, street, city, state, zip, phone, email) 
VALUES ('Tom', 'Jones', '222 Music Ave', 'San Francisco', 'CA', '94102', '555-6666', 'tom.jones@example.com');
INSERT INTO customer (first_name, last_name, street, city, state, zip, phone, email) 
VALUES ('Karen', 'White', '333 Snow Dr', 'Sacramento', 'CA', '95814', '555-7777', 'karen.white@example.com');
INSERT INTO customer (first_name, last_name, steet, city, state, zip, phone, email) 
VALUES ('Mark', 'Davis', '444 Lake Rd', 'San Diego', 'CA', '92101', '555-8888', 'mark.davis@example.com');
INSERT INTO customer (first_name, last_name, street, city, state, zip, phone, email) 
VALUES ('Amy', 'Chen', '555 Hill Blvd', 'Fresno', 'CA', '93721', '555-9999', 'amy.chen@example.com');

-- Insert Preferences Data


-- Change customer_id 
INSERT INTO preferences (customer_id, make, model, max_price, start_date, end_date)
VALUES (1, 'Porsche', '911', 70000, SYSDATE, (SYSDATE + 365)) -- Ian Thomas
INSERT INTO preferences (customer_id, make, model, max_price, start_date, end_date)
VALUES (1, 'Mazda', 'Miata', 29000, SYSDATE, (SYSDATE + 365)) -- Ian Thomas
INSERT INTO preferences (customer_id, make, model, max_price, start_date, end_date)
VALUES (1, 'Land Rover', 'Custom', 38000, SYSDATE, (SYSDATE + 365)) -- Ian Thomas

