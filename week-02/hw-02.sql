-- 1
SELECT FName, LName
  FROM employee
 WHERE UPPER(FName) LIKE UPPER(:first_name) || '%'
   AND UPPER(LName) LIKE UPPER(:last_name) || '%';

-- 2
CREATE TABLE fac (
  facid CHAR(6) PRIMARY KEY,
  facname VARCHAR2(30)
);

SELECT 'FAC' || LPAD(NVL(MAX(TO_NUMBER(SUBSTR(facid, 4))), 0) + 1, 3, '0') AS next_facid
  FROM fac;
