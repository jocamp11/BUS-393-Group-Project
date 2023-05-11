-- Create Employee Table

CREATE TABLE employees (
    employee_id NUMBER(4) PRIMARY KEY,
    first_name VARCHAR2(20) NOT NULL,
    last_name VARCHAR2(20) NOT NULL,
    address VARCHAR2(50) NOT NULL,
    city VARCHAR2(20) NOT NULL,
    state VARCHAR2(2) NOT NULL,
    zip NUMBER(5) NOT NULL,
    phone VARCHAR2(12) NOT NULL UNIQUE,
    email VARCHAR2(50) NOT NULL UNIQUE,
    hire_date DATE DEFAULT SYSDATE NOT NULL,
    title VARCHAR2(20) NOT NULL,
    commission_pct NUMBER(2,2)
);

-- Insert Employee Data

INSERT INTO employees (first_name, last_name, address, city, state, zip, phone, email, title, commission_pct)
VALUES ()