DROP TABLE Parts CASCADE CONSTRAINTS PURGE;
DROP TABLE Services CASCADE CONSTRAINTS PURGE;

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
  CHECK(Price > 0),);
  
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

-- Will add in the foreign key for the Service Invoice Later

CREATE TABLE Service_Parts (
  Part_Code     VARCHAR2(20),
  Service_Date  DATE,
  PRIMARY KEY(Part_Code, Service_Date));













--  We will add in the foreign key for the Service Invoice Later

CREATE TABLE Services_Provided  (
  Service_Code    VARCHAR2(20),
  Service_Date    Date,
  PRIMARY KEY(Service_Code, Service_Date));
  
  
CREATE VIEW Service_List
AS SELECT Service_Code, Description, Cost, Price, Months, Mileage
FROM Services
ORDER BY Service_Code;
