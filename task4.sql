CREATE TABLE Sales_Vehicle (
  VIN             VARCHAR2(17)  PRIMARY KEY,
  year            NUMBER(4),
  make            VARCHAR2(30),
  model           VARCHAR2(30),
  exterior_color  VARCHAR2(20),
  trim            VARCHAR2(20),
  mileage         NUMBER(8, 2),
  condition       VARCHAR2(20),
  status          VARCHAR2(20),
  purchase_price  NUMBER(8, 2)
  list_price      NUMBER(8, 2),
  status          VARCHAR2(20)
);


CREATE TABLE Service_Vehicle (
  VIN       VARCHAR2(17)  PRIMARY KEY,
  year      NUMBER(4),
  make      VARCHAR2(30),
  model     VARCHAR2(30),
  mileage   NUMBER(8, 2)
);
