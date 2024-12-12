-- SET SERVEROUTPUT ON;

-- DECLARE
--     empname     VARCHAR2(30);
--     emplname    VARCHAR2(30);
--     countdepend NUMBER;
-- BEGIN
--     BEGIN
--         SELECT FNAME, LNAME, COUNT(D.DEPENDENT_NAME) 
--         INTO empname, emplname, countdepend
--         FROM EMPLOYEE E
--         JOIN DEPENDENT D ON E.SSN = D.ESSN
--         WHERE UPPER(E.FNAME) LIKE UPPER('&inputempname') || '%'
--           AND UPPER(E.LNAME) LIKE UPPER('&inputemplname') || '%'
--         GROUP BY FNAME, LNAME;

--         DBMS_OUTPUT.PUT_LINE(empname || ' ' || emplname || ' has ' || countdepend || ' dependent(s).');
--     END;
-- END;

SET SERVEROUTPUT ON;

DECLARE
    facid   FAC.FACID%TYPE;
    nextnum NUMBER;        
    facname FAC.FACNAME%TYPE;
BEGIN
    facname := '&facname';

    SELECT NVL(MAX(SUBSTR(FACID, 4, 3)), 0) + 1
    INTO nextnum
    FROM FAC;

    facid := 'FAC' || LPAD(nextnum, 3, '0');

    INSERT INTO FAC (FACID, FACNAME)
    VALUES (facid, facname);

    DBMS_OUTPUT.PUT_LINE('Department added:');
    DBMS_OUTPUT.PUT_LINE('ID: ' || facid || ', Name: ' || facname);

    COMMIT;
END;
