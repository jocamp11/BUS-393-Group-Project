-- -- Nathan Markham, Jesus Ocampo, and Dylan Kau

DROP TABLE Sales_Vehicle CASCADE CONSTRAINTS PURGE;
DROP TABLE Service_Vehicle CASCADE CONSTRAINTS PURGE;

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

-- Task 4 Part B (Queries)

-- Task 4 Query A (Vehicle List)
CREATE OR REPLACE VIEW Vehicle_List 
AS SELECT VIN, year, make, model, exterior_color, trim, mileage, condition, status, list_price
FROM sales_vehicle
ORDER BY make, model;

-- Task 4 Query B (Vehicle List For Sale)
CREATE OR REPLACE VIEW Forsale_List 
AS SELECT year, make, model, exterior_color, trim, mileage, condition, status, list_price
FROM sales_vehicle
WHERE status = 'FORSALE'
ORDER BY make, model;

-- Task 4 Query c (Vehicle List Sold)
CREATE OR REPLACE VIEW Sold_List
AS SELECT VIN, year, make, model, mileage, condition, list_price
FROM sales_vehicle
WHERE status = 'SOLD';

-- Task 4 Query d (Vehicle Inventory Value)
CREATE OR REPLACE VIEW Inventory_Value
AS SELECT SUM(list_price) AS "Total Value ($)"
FROM sales_vehicle
WHERE status = 'FORSALE';

-- Task 4 Query e (Vehicle Inventory Value by Make: Make and the total value of the vehicles for sale,
-- ordered by Make)
CREATE OR REPLACE VIEW Inventory_value_by_make
AS SELECT make, SUM(list_price) AS "Inventory Value ($)"
FROM sales_vehicle
GROUP BY make
ORDER BY make;
