--===========================================================
--                  PL/SQL
--===========================================================
--Must enable output in SQL Developer:-
SET SERVEROUTPUT ON;

--DBMS_OUTPUT is a built-in Oracle package
--  👉 Print output from PL/SQL block
--It stores the message somewhere temporarily
--Buffer = temporary storage (like a waiting area)
--Oracle stores your printed messages in memory (buffer), not on screen

--SET SERVEROUTPUT ON - Show what is inside the buffer

--DBMS_OUTPUT → puts message in buffer
--SERVEROUTPUT ON → shows buffer on screen


--EXAMPLE :-
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;


--SYNTAX :-

--DECLARE
--    --variables
--BEGIN
--    --executable statements
--EXCEPTION
--    --error handling
--END;


--FULL SYNTAX
DECLARE
       v_var NUMBER :=10;
BEGIN
       DBMS_OUTPUT.PUT_LINE(v_var);
EXCEPTION
       WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE('Error');
END;

--
DECLARE
     v_name VARCHAR2(50);
     c_pi CONSTANT NUMBER := 3.14;
BEGIN
     v_name := 'Ravi';
     DBMS_OUTPUT.PUT_LINE(v_name);
     DBMS_OUTPUT.PUT_LINE(c_pi);
END;


--BASIC
BEGIN
     DBMS_OUTPUT.PUT_LINE('WELCOME TO PL/SQL');
END;


--INTERMEDIATE
DECLARE
      v_salary NUMBER := 5000;
BEGIN
      v_salary := v_salary + 1000;
      DBMS_OUTPUT.PUT_LINE(v_salary);
END;


--ADVANCED
SELECT * FROM xxdn_emp;

DECLARE
     v_name VARCHAR2(50);
BEGIN
     SELECT emp_name INTO v_name FROM xxdn_emp WHERE emp_id = 3;
     DBMS_OUTPUT.PUT_LINE(v_name);
EXCEPTION
     WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No Employee Found');
END;


--TASKS
--[1]
BEGIN
    DBMS_OUTPUT.PUT_LINE('DILIP');
END;

--[2]
DECLARE
       v_salary NUMBER := 5000;
BEGIN
      v_salary := v_salary * 110/100;
      DBMS_OUTPUT.PUT_LINE(v_salary);
END;

--[3]
DECLARE
       v_name VARCHAR2(50);
BEGIN 
     SELECT emp_name INTO v_name
     FROM xxdn_emp
     WHERE emp_id = 2;
     
     DBMS_OUTPUT.PUT_LINE(v_name);
     
EXCEPTION
    WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('NO EMPLOYEE FOUND');
    WHEN TOO_MANY_ROWS THEN
         DBMS_OUTPUT.PUT_LINE('MULTIPLE EMPLOYEES FOUND');
END;

      
--OUTPUT-BASED LEARNING       
DECLARE
   v_num NUMBER := 10;
BEGIN
   v_num := v_num * 2;
   DBMS_OUTPUT.PUT_LINE(v_num);
END;

--OUTPUT - 20

BEGIN
     DBMS_OUTPUT.PUT_LINE('Welcome to Oracle PL/SQL');
END;
/


BEGIN
    UPDATE xxdn_emp
    SET salary = salary + 2000
    WHERE dept_no = 10;
    
    DBMS_OUTPUT.PUT_LINE('Salary Updated');
END;
/

select * from xxdn_emp;


--CURSOR VARIABLES
--Cursor Flow

DECLARE
    CURSOR c1 IS SELECT emp_name FROM xxdn_emp;
    v_name xxdn_emp.emp_name%TYPE;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_name;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;
    CLOSE c1;
END;


-- CURSOR FOR LOOPS

FOR rec IN (SELECT emp_name FROM emp) LOOP
    DBMS_OUTPUT.PUT_LINE(rec.emp_name);
END LOOP;


BEGIN 
     FOR rec IN (SELECT emp_name FROM xxdn_emp) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.emp_name);
        END LOOP;
END;