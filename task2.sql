-- Nathan Markham, Jesus Ocampo, and Dylan Kau
--Drop Table

DROP TABLE employee;

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
VALUES (1006, 'Steve', 'Euro', '1966 Lima Dr', 'San Luis Obispo', '93401', '805-324-5043', '3/4/2019' ,'stevee@gmail.com','Cashier', Null, 1002);

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
