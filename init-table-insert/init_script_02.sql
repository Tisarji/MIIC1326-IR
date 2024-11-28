-- Drop existing tables
DROP TABLE department CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE dependent CASCADE CONSTRAINTS;
DROP TABLE dept_locations CASCADE CONSTRAINTS;
DROP TABLE project CASCADE CONSTRAINTS;
DROP TABLE works_on CASCADE CONSTRAINTS;

-- Create department table
CREATE TABLE department (
   DNumber NUMBER(3),
   DName VARCHAR2(15),
   MGRSSN VARCHAR2(9),
   MGRStartDate DATE,
   CONSTRAINT pk_department PRIMARY KEY (DNumber)
);

-- Create employee table
CREATE TABLE employee (
   SSN VARCHAR2(9),
   FName VARCHAR2(15),
   Minit CHAR(1),
   LName VARCHAR2(15),
   BDate DATE,
   Address VARCHAR2(30),
   Sex CHAR(1),
   Salary NUMBER(10,2),
   SuperSSN VARCHAR2(9),
   DNO NUMBER(3),
   CONSTRAINT pk_employee PRIMARY KEY (SSN)
);

-- Create dependent table
CREATE TABLE dependent (
   ESSN VARCHAR2(9),
   DEPENDENT_NAME VARCHAR2(50),
   Sex CHAR(1),
   BDate DATE,
   Relationship VARCHAR2(20),
   CONSTRAINT pk_dependent PRIMARY KEY (ESSN, DEPENDENT_NAME)
);

-- Create dept_locations table
CREATE TABLE dept_locations (
   DNumber NUMBER(11),
   DLocation VARCHAR2(50),
   CONSTRAINT pk_dept_locations PRIMARY KEY (DNumber, DLocation)
);

-- Create project table
CREATE TABLE project (
   PNumber NUMBER(11),
   PName VARCHAR2(50),
   Plocation VARCHAR2(50),
   DNum NUMBER(11),
   CONSTRAINT pk_project PRIMARY KEY (PNumber)
);

-- Create works_on table
CREATE TABLE works_on (
   ESSN VARCHAR2(9),
   PNO NUMBER(11),
   HOURS NUMBER(10,2),
   CONSTRAINT pk_works_on PRIMARY KEY (ESSN, PNO)
);

-- Add foreign key constraints
ALTER TABLE department
  ADD CONSTRAINT FK_DEP_EMP FOREIGN KEY (MGRSSN)
  REFERENCES employee (SSN)
  ON DELETE SET NULL;

ALTER TABLE dependent
  ADD CONSTRAINT FK_DEPEN_EMP FOREIGN KEY (ESSN)
  REFERENCES employee (SSN)
  ON DELETE CASCADE;

ALTER TABLE dept_locations
  ADD CONSTRAINT FK_DEPLOC_DEP FOREIGN KEY (DNumber)
  REFERENCES department (DNumber)
  ON DELETE SET NULL;

ALTER TABLE employee
  ADD CONSTRAINT FK_EMP_EMP FOREIGN KEY (SuperSSN)
  REFERENCES employee (SSN)
  ON DELETE SET NULL;

ALTER TABLE employee
  ADD CONSTRAINT FK_EMP_DEP FOREIGN KEY (DNO)
  REFERENCES department (DNumber)
  ON DELETE SET NULL;

ALTER TABLE project
  ADD CONSTRAINT FK_PRO_DEP FOREIGN KEY (DNum)
  REFERENCES department (DNumber)
  ON DELETE SET NULL;

ALTER TABLE works_on
  ADD CONSTRAINT FK_WORK_EMP FOREIGN KEY (ESSN)
  REFERENCES employee (SSN)
  ON DELETE CASCADE;

ALTER TABLE works_on
  ADD CONSTRAINT FK_WORK_PRO FOREIGN KEY (PNO)
  REFERENCES project (PNumber)
  ON DELETE CASCADE;

-- Insert data into employee table
INSERT INTO employee (SSN, FName, Minit, LName, BDate, Address, Sex, Salary, SuperSSN, DNO) VALUES ('123456789', 'John', 'B', 'Smith', TO_DATE('1955-01-09','YYYY-MM-DD'), '731 Fondren,Houston,TX', 'M', 30000, NULL, NULL);
INSERT INTO employee (SSN, FName, Minit, LName, BDate, Address, Sex, Salary, SuperSSN, DNO) VALUES ('333445555', 'Franklin', 'T', 'Wong', TO_DATE('1945-12-08','YYYY-MM-DD'), '638 Voss,Houston,TX', 'M', 40000, NULL, NULL);
INSERT INTO employee (SSN, FName, Minit, LName, BDate, Address, Sex, Salary, SuperSSN, DNO) VALUES ('999887777', 'Alicia', 'J', 'Zelaya', TO_DATE('1958-07-19','YYYY-MM-DD'), '3321 Castle,Spring,TX', 'F', 25000, NULL, NULL);
INSERT INTO employee (SSN, FName, Minit, LName, BDate, Address, Sex, Salary, SuperSSN, DNO) VALUES ('987654321', 'Jennifer', 'S', 'Walliance', TO_DATE('1931-06-20','YYYY-MM-DD'), '291 Berry,Bellaire,TX', 'F', 43000, NULL, NULL);
INSERT INTO employee (SSN, FName, Minit, LName, BDate, Address, Sex, Salary, SuperSSN, DNO) VALUES ('666884444', 'Ramesh', 'K', 'Narayan', TO_DATE('1945-12-08','YYYY-MM-DD'), '975 Fire Oak,Humble,TX', 'M', 38000, NULL, NULL);
INSERT INTO employee (SSN, FName, Minit, LName, BDate, Address, Sex, Salary, SuperSSN, DNO) VALUES ('453453453', 'Joyce', 'A', 'English', TO_DATE('1962-07-31','YYYY-MM-DD'), '5631 Rice,Houston,TX', 'F', 25000, NULL, NULL);
INSERT INTO employee (SSN, FName, Minit, LName, BDate, Address, Sex, Salary, SuperSSN, DNO) VALUES ('987987987', 'Ahmad', 'V', 'Jabbar', TO_DATE('1959-03-29','YYYY-MM-DD'), '980 Dallas,Houston,TX', 'M', 25000, NULL, NULL);
INSERT INTO employee (SSN, FName, Minit, LName, BDate, Address, Sex, Salary, SuperSSN, DNO) VALUES ('888665555', 'James', 'E', 'Borg', TO_DATE('1927-11-10','YYYY-MM-DD'), '450 Stone,Houston,TX', 'M', 55000, NULL, NULL);

-- Insert data into department table
INSERT INTO department (DNumber, DName, MGRSSN, MGRStartDate) VALUES (1, 'HeadQuarters', '888665555', TO_DATE('1971-06-19','YYYY-MM-DD'));
INSERT INTO department VALUES (4, 'Administration', '987654321', TO_DATE('1985-01-01','YYYY-MM-DD'));
INSERT INTO department VALUES (5, 'Research', '333445555', TO_DATE('1978-05-22','YYYY-MM-DD'));

-- Update employee table
UPDATE employee SET SuperSSN = '333445555', DNO = 5 WHERE SSN = '666884444';
UPDATE employee SET DNO = 1 WHERE SSN = '888665555';
UPDATE employee SET SuperSSN = '888665555', DNO = 4 WHERE SSN = '987654321';
UPDATE employee SET SuperSSN = '987654321', DNO = 4 WHERE SSN = '987987987';
UPDATE employee SET SuperSSN = '987654321', DNO = 4 WHERE SSN = '999887777';
UPDATE employee SET SuperSSN = '333445555', DNO = 5 WHERE SSN = '123456789';
UPDATE employee SET SuperSSN = '888665555', DNO = 5 WHERE SSN = '333445555';
UPDATE employee SET SuperSSN = '333445555', DNO = 5 WHERE SSN = '453453453';

-- Insert data into dept_locations table
INSERT INTO dept_locations (DNumber, DLocation) VALUES (1, 'Houston');
INSERT INTO dept_locations (DNumber, DLocation) VALUES (4, 'Stafford');
INSERT INTO dept_locations (DNumber, DLocation) VALUES (5, 'Bellaire');
INSERT INTO dept_locations (DNumber, DLocation) VALUES (5, 'Sugarland');
INSERT INTO dept_locations (DNumber, DLocation) VALUES (5, 'Houston');

-- Insert data into project table
INSERT INTO project (PNumber, PName, Plocation, DNum) VALUES (1, 'Project X', 'Bellaire', 5);
INSERT INTO project (PNumber, PName, Plocation, DNum) VALUES (2, 'Product Y', 'Sugarland', 5);
INSERT INTO project (PNumber, PName, Plocation, DNum) VALUES (3, 'Product Z', 'Houston', 5);
INSERT INTO project (PNumber, PName, Plocation, DNum) VALUES (10, 'Computerization', 'Stafford', 4);
INSERT INTO project (PNumber, PName, Plocation, DNum) VALUES (20, 'Reorganization', 'Houston', 1);
INSERT INTO project (PNumber, PName, Plocation, DNum) VALUES (30, 'NewBenefits', 'Stafford', 4);

-- Insert data into works_on table
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('123456789', 1, 32.5);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('123456789', 2, 7.5);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('666884444', 3, 40);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('453453453', 1, 20);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('453453453', 2, 20);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('333445555', 2, 10);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('333445555', 3, 10);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('333445555', 10, 10);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('333445555', 20, 10);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('999887777', 30, 30);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('999887777', 10, 10);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('987987987', 10, 35);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('987987987', 30, 5);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('987654321', 30, 20);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('987654321', 20, 15);
INSERT INTO works_on (ESSN, PNO, HOURS) VALUES ('888665555', 20, NULL);

-- Insert data into dependent table
INSERT INTO dependent (ESSN, DEPENDENT_NAME, Sex, BDate, Relationship) VALUES ('333445555', 'Alice', 'F', TO_DATE('1976-04-05','YYYY-MM-DD'), 'Daughter');
INSERT INTO dependent (ESSN, DEPENDENT_NAME, Sex, BDate, Relationship) VALUES ('333445555', 'Theodore', 'M', TO_DATE('1973-10-25','YYYY-MM-DD'), 'Son');
INSERT INTO dependent (ESSN, DEPENDENT_NAME, Sex, BDate, Relationship) VALUES ('333445555', 'Joy', 'F', TO_DATE('1948-05-03','YYYY-MM-DD'), 'Spouse');
INSERT INTO dependent (ESSN, DEPENDENT_NAME, Sex, BDate, Relationship) VALUES ('987654321', 'Abner', 'M', TO_DATE('1932-02-29','YYYY-MM-DD'), 'Spouse');
INSERT INTO dependent (ESSN, DEPENDENT_NAME, Sex, BDate, Relationship) VALUES ('123456789', 'Micheal', 'M', TO_DATE('1978-01-01','YYYY-MM-DD'), 'Son');
INSERT INTO dependent (ESSN, DEPENDENT_NAME, Sex, BDate, Relationship) VALUES ('123456789', 'Alice', 'F', TO_DATE('1978-12-31','YYYY-MM-DD'), 'Daughter');
INSERT INTO dependent (ESSN, DEPENDENT_NAME, Sex, BDate, Relationship) VALUES ('123456789', 'Elizabeth', 'F', TO_DATE('1957-05-05','YYYY-MM-DD'), 'Spouse');

COMMIT;
