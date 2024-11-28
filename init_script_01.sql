-- Drop Tables
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE saledetail CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE sale CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE product CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE cus CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE product (
  productid CHAR(3) PRIMARY KEY,
  proname VARCHAR2(50),
  cost NUMBER(10, 2),
  price NUMBER(10, 2),
  amount NUMBER(3)
);

CREATE TABLE cus (
  cusid CHAR(3) PRIMARY KEY,
  name VARCHAR2(30),
  address VARCHAR2(50)
);

CREATE TABLE sale (
  saleid CHAR(8) PRIMARY KEY,
  saledate DATE,
  cusid CHAR(3),
  CONSTRAINT fk_sal_cus FOREIGN KEY (cusid) REFERENCES cus(cusid)
);

CREATE TABLE saledetail (
  saleid CHAR(8),
  proid CHAR(3),
  itemNo NUMBER(3),
  amount NUMBER(3),
  priceperunit NUMBER(10, 2),
  itemtotal NUMBER(10, 2),
  CONSTRAINT pk_sale_detail PRIMARY KEY (saleid, itemNo),
  CONSTRAINT fk_sale_saledetail FOREIGN KEY (saleid) REFERENCES sale(saleid)
);

-- Insert Data into Product Table
INSERT INTO product VALUES ('P01', 'Pencil', 500, 560, 20);
INSERT INTO product VALUES ('P02', 'Eraser', 1500, 1600, 100);
INSERT INTO product VALUES ('P03', 'Ring', 200, 280, 150);
INSERT INTO product VALUES ('P04', 'Notebook', 25000, 30000, 150);
INSERT INTO product VALUES ('P05', 'Diamond', 20000, 50000, 150);

-- Insert Data into Customer Table
INSERT INTO cus VALUES ('C01', 'Peter', 'Minburee, Bangkok');
INSERT INTO cus VALUES ('C02', 'Paul', 'Nongjok, Bangkok');
INSERT INTO cus VALUES ('C03', 'Mary', 'Nongjok, Bangkok');
INSERT INTO cus VALUES ('C04', 'Harry', 'Chonburi');
INSERT INTO cus VALUES ('C05', 'Dobby', 'Nongjok, Bangkok');

-- Insert Data into Sale Table
INSERT INTO sale VALUES ('SALE0001', TO_DATE('15/02/2024', 'DD/MM/YYYY'), 'C05');
INSERT INTO sale VALUES ('SALE0002', TO_DATE('21/02/2024', 'DD/MM/YYYY'), 'C02');
INSERT INTO sale VALUES ('SALE0003', TO_DATE('12/04/2023', 'DD/MM/YYYY'), 'C01');
INSERT INTO sale VALUES ('SALE0004', TO_DATE('16/04/2024', 'DD/MM/YYYY'), 'C01');
INSERT INTO sale VALUES ('SALE0005', TO_DATE('30/04/2024', 'DD/MM/YYYY'), 'C01');
INSERT INTO sale VALUES ('SALE0006', TO_DATE('30/04/2024', 'DD/MM/YYYY'), 'C02');
INSERT INTO sale VALUES ('SALE0007', TO_DATE('30/04/2024', 'DD/MM/YYYY'), 'C01');
INSERT INTO sale VALUES ('SALE0008', TO_DATE('30/04/2024', 'DD/MM/YYYY'), 'C03');

-- Insert Data into SaleDetail Table
INSERT INTO saledetail VALUES ('SALE0001', 'P01', 1, 5, 560, 2800);
INSERT INTO saledetail VALUES ('SALE0001', 'P02', 2, 1, 1600, 1600);
INSERT INTO saledetail VALUES ('SALE0002', 'P01', 1, 1, 560, 560);
INSERT INTO saledetail VALUES ('SALE0002', 'P02', 2, 2, 1600, 3200);
INSERT INTO saledetail VALUES ('SALE0003', 'P02', 1, 2, 1600, 3200);
INSERT INTO saledetail VALUES ('SALE0004', 'P01', 1, 5, 560, 2800);
INSERT INTO saledetail VALUES ('SALE0004', 'P02', 2, 2, 1600, 3200);
INSERT INTO saledetail VALUES ('SALE0004', 'P03', 3, 2, 280, 560);
INSERT INTO saledetail VALUES ('SALE0005', 'P03', 1, 2, 280, 560);
INSERT INTO saledetail VALUES ('SALE0006', 'P01', 1, 1, 560, 560);
INSERT INTO saledetail VALUES ('SALE0006', 'P02', 2, 2, 1600, 3200);
INSERT INTO saledetail VALUES ('SALE0007', 'P01', 1, 1, 560, 560);
INSERT INTO saledetail VALUES ('SALE0008', 'P01', 1, 5, 560, 2800);

-- Commit Changes
COMMIT;
