--===============================================
--13 Apr 2026
--===============================================

-- DDL: create table
CREATE TABLE xxdn_dept(
      dept_no NUMBER PRIMARY KEY,
      dept_name VARCHAR2(50),
      location VARCHAR2(50)
      );
      
-- DML: insert
INSERT INTO xxdn_dept VALUES (10, 'HR', 'HYD');
INSERT INTO xxdn_dept VALUES (20, 'IT', 'BLR');
INSERT INTO xxdn_dept VALUES (30, 'FINANCE','MUM');
COMMIT;

-- select
SELECT * FROM xxdn_dept;


-- DDL + FK
CREATE TABLE xxdn_emp(
      emp_id NUMBER PRIMARY KEY,
      emp_name VARCHAR2(50),
      job VARCHAR2(50),
      salary NUMBER(10,2),
      dept_no NUMBER,
      CONSTRAINT fk_dept
      FOREIGN KEY (dept_no)
      REFERENCES xxdn_dept(dept_no)
      );
   
-- insert (with NULL)
INSERT INTO xxdn_emp VALUES (1, 'RAM', 'CLERK', 5000, 10);
INSERT INTO xxdn_emp VALUES (2, 'JOHN', 'MANAGER', 6000, 20);
INSERT INTO xxdn_emp VALUES (3, 'SMITH', 'CLERK', 7000, 10);
INSERT INTO xxdn_emp VALUES (4, 'ALLEN', 'SALESMAN', NULL, 30);
INSERT INTO xxdn_emp VALUES (5, 'KING', 'MANAGER', 10000, 20);
INSERT INTO xxdn_emp VALUES (6, 'SCOTT', 'ANALYST', NULL, 20);

COMMIT;

-- select
SELECT * FROM xxdn_emp;


-- concat
SELECT emp_name || '-' || job AS "Employee jobs"
FROM xxdn_emp;

-- concat NULL
SELECT emp_name || NULL FROM xxdn_emp;

-- concat + number
SELECT emp_name || ' earns ' || salary AS "Employee salary"
FROM xxdn_emp;   --#1

SELECT emp_name || ' monthly salary is ' || salary AS "Monthly Salary"
FROM xxdn_emp;  --#2

-- distinct
SELECT DISTINCT dept_no FROM xxdn_emp;  --#3

-- where
SELECT emp_name || ' is working as ' || job AS "Employee job"
FROM xxdn_emp
WHERE emp_id = 1;

-- distinct
SELECT DISTINCT job FROM xxdn_emp;

-- concat + where
SELECT emp_name || ' earns ' || salary || ' per month' AS "Monthly salary"
FROM xxdn_emp
WHERE emp_id = 1;

-- where filters
SELECT * 
FROM xxdn_emp
WHERE dept_no = 10;

SELECT *
FROM xxdn_emp
WHERE salary != 5000;

SELECT * 
FROM xxdn_emp
WHERE salary > 6000;

SELECT *
FROM xxdn_emp
WHERE dept_no = 20;

-- NULL
SELECT * 
FROM xxdn_emp
WHERE salary IS NULL;

SELECT * 
FROM xxdn_emp
WHERE salary IS NOT NULL;

-- NULL + condition
SELECT *
FROM xxdn_emp
WHERE salary != 5000 OR salary IS NULL;

-- operators
SELECT *
FROM xxdn_emp
WHERE salary <> 5000;

SELECT *
FROM xxdn_emp
WHERE salary > 5000;

SELECT *
FROM xxdn_emp
WHERE salary IS NULL;

SELECT *
FROM xxdn_emp
WHERE dept_no = 20;

-- precedence: NOT > AND > OR

SELECT *
FROM xxdn_emp
WHERE (dept_no = 10 OR dept_no = 20) AND salary > 6000;

----
-- OR
SELECT *
FROM xxdn_emp
WHERE dept_no = 10 OR dept_no = 20;

-- AND + OR
SELECT *
FROM xxdn_emp
WHERE (dept_no = 10 OR dept_no = 20) AND salary > 6000;

SELECT *
FROM xxdn_emp
WHERE dept_no = 10 OR (salary > 6000 AND job = 'MANAGER');

-- NOT / !=
SELECT *
FROM xxdn_emp
WHERE dept_no != 10;  

SELECT *
FROM xxdn_emp
WHERE salary > 5000 AND dept_no <> 20;

---
-- complex
SELECT *
FROM xxdn_emp
WHERE (dept_no=10 OR dept_no=20) AND (salary > 5000) AND (job = 'MANAGER');

SELECT *
FROM xxdn_emp
WHERE (dept_no <> 10) AND (salary < 7000 OR salary IS NULL);

SELECT *
FROM xxdn_emp
WHERE dept_no=20 OR (dept_no=10 AND salary > 6000);

SELECT *
FROM xxdn_emp
WHERE NOT( salary > 5000) OR salary IS NULL;

SELECT *
FROM xxdn_emp
WHERE (dept_no <> 20) AND (salary > 5000 OR salary IS NULL);

---
SELECT *
FROM xxdn_emp
WHERE (dept_no=10 OR dept_no=20) AND (salary>5000 OR salary IS NULL);

SELECT *
FROM xxdn_emp
WHERE NOT dept_no = 10 AND (salary < 8000 OR salary IS NULL);

SELECT *
FROM xxdn_emp
WHERE (dept_no=10 OR dept_no=20) AND (salary >7000 OR salary IS NULL);

---
SELECT *
FROM xxdn_emp
WHERE (dept_no=10 AND salary>5000) OR (dept_no=20 AND salary>8000);

SELECT *
FROM xxdn_emp
WHERE (dept_no <> 30) AND (salary>=4000 AND salary <=9000 OR salary IS NULL); 

SELECT * 
FROM xxdn_emp
WHERE dept_no=10 OR dept_no=20 OR (dept_no=30 AND salary>7000);

-- order by
SELECT *
FROM xxdn_emp
ORDER BY salary DESC NULLS LAST;

SELECT *
FROM xxdn_emp
ORDER BY dept_no ASC, salary DESC;

-- order by position
SELECT emp_name, dept_no
FROM xxdn_emp
ORDER BY 2;

--
-- sorting
SELECT * 
FROM xxdn_emp
ORDER BY  emp_name;

SELECT *
FROM xxdn_emp
ORDER BY salary DESC;

SELECT *
FROM xxdn_emp
ORDER BY dept_no ASC, salary ASC;

SELECT *
FROM xxdn_emp
ORDER BY salary ASC NULLS FIRST;

SELECT * 
FROM xxdn_emp
ORDER BY dept_no ASC, salary DESC;

---
-- row limiting
SELECT *
FROM xxdn_emp
ORDER BY salary DESC NULLS LAST
FETCH FIRST 2 ROWS ONLY;

SELECT *
FROM xxdn_emp
ORDER BY salary ASC NULLS LAST
FETCH FIRST 3 ROWS ONLY;

-- offset
SELECT * 
FROM xxdn_emp
ORDER BY salary DESC NULLS LAST
OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY;

-- with ties
SELECT * 
FROM xxdn_emp
ORDER BY salary DESC NULLS LAST
FETCH FIRST 3 ROWS WITH TIES;

SELECT *
FROM xxdn_emp
ORDER BY emp_id ASC
OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;

-- substitution
SELECT *
FROM xxdn_emp
WHERE emp_id = &emp_id;

SELECT *
FROM xxdn_emp
WHERE dept_no = &dept_no;

SELECT emp_id, emp_name, salary --[IMP]
FROM xxdn_emp
WHERE salary > &salary;

SELECT * 
FROM xxdn_emp
WHERE dept_no = &&dept_no;

-- define

DEFINE dept = 10;  -- avoids repeated input
SELECT *
FROM xxdn_emp
WHERE dept_no = &&dept;

DEFINE dept = 20
SELECT *
FROM xxdn_emp
WHERE dept_no = &dept;

--verify  -substitution before execution(debugging)
SET VERIFY OFF;

SELECT *
FROM xxdn_emp
WHERE emp_id = &emp_id;


-- select
SELECT * FROM xxdn_emp;
DESC xxdn_emp;

-- TCL
COMMIT;

-- system
SELECT * FROM v$version;
--DROP TABLE xxdn_emp;
--DROP TABLE xxdn_dept;




--==================================================
--14 Apr 2026
--==================================================

--SINGLE ROW FUNCTIONS -single value for single data(single value per row)

SELECT emp_name, UPPER(emp_name) AS CAPITAL
FROM xxdn_emp;

SELECT emp_name, LOWER(emp_name) AS LOWER
FROM xxdn_emp;

SELECT emp_name, INITCAP(emp_name) as INITCAPITAL
FROM xxdn_emp;

SELECT emp_name, LENGTH(emp_name) AS STRLENGTH
FROM xxdn_emp;

--***** IN SQL STRING POSITION STARTS FROM '1' NOT '0' **********
--substr(column, start position, length)
SELECT emp_name, SUBSTR(emp_name,1,3) SUBSTRING
FROM xxdn_emp; --inclusive

--instr - finds position of character
SELECT emp_name, INSTR(emp_name,'A') AS CHARPOS
FROM xxdn_emp;

--TRIM() - REMOVES SPACES
SELECT TRIM('   SQL ')AS TRIM FROM dual;

--practice problems
SELECT emp_name, LOWER(emp_name) AS LOWERCASE
FROM xxdn_emp;

SELECT emp_name, INITCAP(emp_name) AS INITCAP
FROM xxdn_emp;

SELECT emp_name, SUBSTR(emp_name,-2,1 ) AS SUBSTRING
FROM xxdn_emp;

SELECT emp_name, INSTR(emp_name,'M') AS CHARPOS
FROM xxdn_emp;

SELECT TRIM('   ORACLE SQL   ') AS TRIMMED_TEXT
FROM dual;

SELECT emp_name, SUBSTR(emp_name,1,1) AS FIRST_CHAR
FROM xxdn_emp;

--MULTIPLE ROW FUNCTIONS  - single value for group data
--                        - one overall

SELECT SUM(salary) "TOTAL SALARY"
FROM xxdn_emp;


--NESTING FUNCTIONS - using one function inside another
--iner fucntion executes first
--output of inner -> input of outer
--must match data type

SELECT SUBSTR(UPPER(emp_name),1,3) "substr upppercase"
FROM xxdn_emp;

SELECT LENGTH(TRIM('   SQL   ')) "trimmed text len" 
FROM dual;


SELECT LOWER(SUBSTR(emp_name,1,2)) "substr lowercase"
FROM xxdn_emp;

--practice problems
SELECT emp_name,SUBSTR(UPPER(emp_name),1,2) "substr uppercase"
FROM xxdn_emp;

SELECT LENGTH(TRIM('   DATABASE   ')) "trimmed text"
FROM dual;

SELECT emp_name, LOWER(SUBSTR(emp_name,-3,3)) "last 3 char to lower case"
FROM xxdn_emp;

SELECT emp_name, SUBSTR(UPPER(emp_name),1,2) "lower to upper to first 2 char"
FROM xxdn_emp;

SELECT emp_name, INSTR(UPPER(emp_name),'A') "pos of 'A' after converting to uppercase"
FROM xxdn_emp;

--ROUND() - round number to nearest place
--        - ROUND(number,decimal_places)

--EXAMPLES
SELECT ROUND(123.457, 2)
FROM dual;

SELECT ROUND(198.456, -1)
FROM dual;

--TRUNC() - Cut decimals ( no rounding)
--        - TRUNC(number, decimal_places)

SELECT TRUNC(123.457, 2)
FROM dual;

SELECT TRUNC(123.456, 0)
FROM dual;

SELECT TRUNC(198.456, -1)
FROM dual;

--MOD()  -  Find Remainder
--       -  MOD(a,b)

SELECT MOD(10,3) FROM dual;

SELECT emp_id,
       MOD(emp_id,2) AS mod_2
FROM xxdn_emp;

--practice problems
SELECT emp_name, ROUND(salary) AS rounded_salary 
FROM xxdn_emp;

SELECT TRUNC(salary)
FROM xxdn_emp;

SELECT ROUND(salary,2)
FROM xxdn_emp;

SELECT MOD(salary,1000)
FROM xxdn_emp;

SELECT emp_id, emp_name
FROM xxdn_emp
WHERE MOD(emp_id,2) = 0;

--alternative with label
SELECT emp_id, emp_name,
       CASE
           WHEN MOD(emp_id,2) = 0 THEN 'EVEN'
           ELSE 'ODD'
       END AS type
FROM xxdn_emp;

--DATE FUNCTIONS
--      - used for salary increments by time
--      - experince calci

SELECT SYSDATE FROM dual; --current system date

--DATE arithmetic

SELECT SYSDATE+10 FROM dual;

SELECT ADD_MONTHS(SYSDATE,2) FROM dual;

SELECT MONTHS_BETWEEN(SYSDATE, '14-01-2026') FROM dual;

SELECT NEXT_DAY(SYSDATE,'MONDAY') FROM dual;

SELECT LAST_DAY(SYSDATE) FROM dual;

--practice problems

SELECT SYSDATE FROM dual;

SELECT SYSDATE+15 FROM dual;

SELECT ADD_MONTHS(SYSDATE,3) FROM dual;

SELECT MONTHS_BETWEEN(SYSDATE,'01-01-2020') FROM dual;
--alternatives 
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('01-01-2020','DD-MM-YYYY')) FROM dual;
SELECT MONTHS_BETWEEN(SYSDATE, DATE '2020-01-01') FROM dual; --yyyy-mm-dd
--ALWAYS CONVERT STRINGS TO DATE EXPLICITELY
--If not done explicitely , Oracle wil try implicit conversion

SELECT NEXT_DAY(SYSDATE,'MONDAY') FROM dual;

--CONVERSION FUNCTIONS
--TO_CHAR() - converts number/date -> string

SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY') AS To_char FROM dual;

SELECT TO_CHAR(12345,'99999') FROM dual;

--TO_DATE() - converts string -> date

SELECT TO_DATE('15-08-2025','DD-MM-YYYY') FROM dual;

--TO_NUMBER() - converts string-> number

SELECT TO_NUMBER('12345') AS TO_NUMBER FROM dual;

--practice problems

SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY') AS current_date FROM dual;

SELECT TO_DATE('25-12-2025','DD-MM-YYYY') AS into_date FROM dual;

SELECT TO_NUMBER('5000') AS TO_NUMBER FROM dual;

SELECT 'Salary: '|| salary AS salary_text FROM xxdn_emp;

SELECT TO_CHAR(SYSDATE, 'DAY, DD MONTH YYYY') AS dis_curr_date FROM dual;

--======================================
--15 Apr 2026
--======================================
--NVL - Null Value Replacement Logic
SELECT emp_name, NVL(salary,0)
FROM xxdn_emp;

--COALESCE() - Returns first non-null value

SELECT COALESCE(NULL,NULL,5000)
FROM dual;

--NULLIF() - compare two values and if equal - return NULL

SELECT NULLIF(100,100) FROM dual;

SELECT NULLIF(100,200) FROM dual;

--practice problems
SELECT emp_name, NVL(salary,0) AS salary FROM xxdn_emp;

SELECT emp_name,'Salary: ' || NVL(salary,0) AS salary_text FROM xxdn_emp;

SELECT COALESCE(NULL,salary,1000)AS first_non_null 
FROM xxdn_emp;

SELECT emp_name, NULLIF(salary,5000) AS Result FROM xxdn_emp;

--Conditional Expressions - CASE

SELECT emp_name,
       CASE
           WHEN salary >= 8000 THEN 'HIGH'
           WHEN salary >= 5000 THEN 'MEDIUM'
           ELSE 'LOW'
        END AS salary_category
FROM xxdn_emp;

SELECT emp_name,
       CASE
           WHEN salary IS NOT NULL THEN 'HAS SALARY'
           ELSE 'NO SALARY'
       END AS Display_salary
FROM xxdn_emp;

SELECT emp_name,
       CASE
           WHEN dept_no=10 THEN 'HR'
           WHEN dept_no=20 THEN 'IT'
           ELSE 'OTHER'
        END AS Departments
FROM xxdn_emp;

SELECT emp_name,
       CASE
           WHEN salary IS NULL THEN 'MISSING'
           WHEN salary >= 7000 THEN 'GOOD'
           ELSE 'AVERAGE'
        END AS Salary
FROM xxdn_emp;

--GROUP FUNCTIONS
--GROUP FUNCTIONS IGNORE NULL (except COUNT(*))

SELECT SUM(salary) AS Total_salary FROM xxdn_emp;

SELECT AVG(salary) AS Average_salary FROM xxdn_emp;

SELECT COUNT(emp_id) AS Total_employees FROM xxdn_emp;
SELECT COUNT(*) AS Total_employees FROM xxdn_emp;

SELECT COUNT(salary) AS Employees_with_salary FROM xxdn_emp;

SELECT MAX(salary) AS Max_salary FROM xxdn_emp;


--GROUP BY + HAVING FUNCTIONS

SELECT dept_no, SUM(salary)
FROM xxdn_emp
GROUP BY dept_no;

SELECT dept_no, COUNT(*)
FROM xxdn_emp
GROUP BY dept_no;

SELECT job, COUNT(*)
FROM xxdn_emp
GROUP BY job;

SELECT dept_no, SUM(salary)
FROM xxdn_emp
GROUP BY dept_no;

SELECT job, AVG(salary)
FROM xxdn_emp
GROUP BY job;

SELECT dept_no, COUNT(*)
FROM xxdn_emp
GROUP BY dept_no;

SELECT dept_no, SUM(salary)
FROM xxdn_emp
GROUP BY dept_no
HAVING SUM(salary) > 10000;

SELECT job, AVG(salary) AS avrg
FROM xxdn_emp
GROUP BY job
HAVING AVG(salary) >6000;


--Joins

SELECT e.emp_name, d.dept_name, location
FROM xxdn_emp e
JOIN xxdn_dept d
ON e.dept_no = d.dept_no;

--practice problems

SELECT e.emp_name, d.dept_name
FROM xxdn_emp e
JOIN xxdn_dept d
ON e.dept_no = d.dept_no;

SELECT e.emp_name, d.dept_name, e.salary
FROM xxdn_emp e
JOIN xxdn_dept d
ON e.dept_no = d.dept_no;

SELECT e.emp_name, d.dept_name
FROM xxdn_emp e
JOIN xxdn_dept d
ON e.dept_no = d.dept_no
WHERE d.dept_name = 'IT';

SELECT d.dept_name, COUNT(*) AS employee_count
FROM xxdn_emp e
JOIN xxdn_dept d
ON e.dept_no = d.dept_no
GROUP BY d.dept_name;

SELECT d.dept_name, SUM(salary) AS total_salary
FROM xxdn_emp e
JOIN xxdn_dept d
ON e.dept_no = d.dept_no
GROUP BY d.dept_name
HAVING SUM(e.salary) > 10000;

--Natural Join

SELECT emp_name, dept_name
FROM xxdn_emp
NATURAL JOIN xxdn_dept;

--Self Join

SELECT e.emp_name, m.emp_name AS manager
FROM xxdn_emp e
JOIN xxdn_emp m
ON e.manager_id = m.emp_id;



--Nonequi Join

SELECT e.emp_name, e.salary, s.grade
FROM xxdn_emp e
JOIN sal_grade s
ON e.salary BETWEEN s.min_sal AND s.max_sal;

--Outer Join
  --Left Join

SELECT e.emp_name, d.dept_name
FROM xxdn_emp e
LEFT JOIN xxdn_dept d
ON e.dept_no = d.dept_no;

   --Right Join

SELECT e.emp_name, d.dept_name
FROM xxdn_emp e
RIGHT JOIN xxdn_dept d
ON e.dept_no = d.dept_no;

--FULL JOIN
SELECT e.emp_name, d.dept_name
FROM xxdn_emp e
FULL JOIN xxdn_dept d
ON e.dept_no = d.dept_no;

--CARTESIAN PRODUCT
SELECT * FROM xxdn_emp,xxdn_dept;




ALTER TABLE xxdn_emp ADD manager_id NUMBER;

UPDATE xxdn_emp SET manager_id = 2 WHERE emp_id = 1;
UPDATE xxdn_emp SET manager_id = 5 WHERE emp_id = 2;
COMMIT;

CREATE TABLE sal_grade (
    grade VARCHAR2(2),
    min_sal NUMBER,
    max_sal NUMBER
);

INSERT INTO sal_grade VALUES ('A', 0, 5000);
INSERT INTO sal_grade VALUES ('B', 5001, 8000);
INSERT INTO sal_grade VALUES ('C', 8001, 15000);

INSERT INTO xxdn_dept VALUES (40, 'ADMIN', 'DEL');

INSERT INTO xxdn_dept VALUES (50, 'LEGAL', 'PUNE');

INSERT INTO xxdn_emp 
(emp_id, emp_name, salary, job, dept_no, manager_id)
VALUES 
(7, 'ADAM', 4000, 'CLERK', 99, NULL);

UPDATE xxdn_emp SET manager_id = 2 WHERE emp_id = 1;
UPDATE xxdn_emp SET manager_id = 2 WHERE emp_id = 3;
UPDATE xxdn_emp SET manager_id = 5 WHERE emp_id = 6;

INSERT INTO xxdn_emp 
(emp_id, emp_name, salary, job, dept_no, manager_id)
VALUES 
(8, 'ROCKY', 3000, 'CLERK', 99, NULL);

--DESCRIBE TABLE
DESC xxdn_emp;

--UPDATE
UPDATE xxdn_emp
SET dept_no = 99
WHERE emp_id = 7;

--TRUNCATE
--TRUNCATE table sal_grade;

COMMIT;



--========================================
--16 Apr 2026
--========================================

--SUBQUERY
--SINGLE ROW SUBQUERY
  --Arithmetic operators used :-
  --  =  >  <  >=  <=
  
SELECT *
FROM xxdn_emp
WHERE salary = (
      SELECT MAX(salary)
      FROM xxdn_emp
);

SELECT *
FROM xxdn_emp
WHERE salary>(
      SELECT AVG(salary)
      FROM xxdn_emp
);

--Multiple Row Subquery
  --Operators used :-
    -- IN - match any
    -- ANY - compare with any
    -- ALL - compare with all

--IN  - outer query mathces the list of inner query
--    - Value must match any of these
--    - (Easiest)

SELECT *
FROM xxdn_emp
WHERE dept_no IN(
     SELECT dept_no
     FROM xxdn_dept
     WHERE location = 'BLR'
);

--ANY - outer query compares with least value of inner query
--    - If greater that at least one -> keep (that means atleast greater than minimum -> keep)
--    - (Important)
SELECT *
FROM xxdn_emp
WHERE salary > ANY (
      SELECT salary
      FROM xxdn_emp
      WHERE dept_no = 10
);

--ALL - outer query matches the inner query's largest value
--    - Must beat every value ( that means must beat highest value of inner query output)  
--    - (Strict)

SELECT *
FROM xxdn_emp
WHERE salary > ALL(
      SELECT salary
      FROM xxdn_emp
      WHERE dept_no = 10
      );

--NULL Handling in Subqueries

SELECT *
FROM xxdn_emp
WHERE dept_no NOT IN (
      SELECT dept_no
      FROM xxdn_emp
      WHERE dept_no IS NOT NULL
      );
      
SELECT *
FROM xxdn_emp e
WHERE NOT EXISTS(
     SELECT 1
     FROM xxdn_dept d
     WHERE d.dept_no = e.dept_no
     );

--===============================
--17 Apr 2026
--===============================

SELECT *
FROM xxdn_emp
WHERE dept_no IN (
      SELECT dept_no
      FROM xxdn_dept
      WHERE location = 'BLR'
      );

--NULL HANDLING IN SUBQUERIES
SELECT emp_name
FROM xxdn_emp
WHERE dept_no NOT IN (
     SELECT dept_no FROM xxdn_emp
     );
     
SELECT emp_name
FROM xxdn_emp e1 
WHERE NOT EXISTS (
     SELECT 1
     FROM xxdn_emp e2
     WHERE e1.dept_no = e2.dept_no
     );
     
--Exists (use case) - to check if related data is present in another table

SELECT *
FROM customers c
WHERE EXISTS (
     SELECT 1
     FROM orders o
     WHERE o.customer_id = c.customer_id)
     ;
   
-- NOT EXISTS - For inactive users, unused account, pending actions     
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
); 
     
-- NOT IN vs NOT EXISTS   => USE NOT EXISTS
--  NOT IN - checks values - if NULL -> UNKNOWN
--  NOT EXISTS - checks rows - doesn't compare with NULL directly

--IN - works fine with NULL
--NOT IN - breaks if NULL present

-- IF STILL WANT TO USE - NOT IN -> REMOVE NULLS


SELECT emp_name
FROM xxdn_emp
WHERE dept_no NOT IN (
     SELECT dept_no
     FROM xxdn_emp
     WHERE dept_no IS NOT NULL
     );
     
SELECT e.emp_name, e.salary
FROM xxdn_emp e
WHERE salary > (
     SELECT AVG(salary)
     FROM xxdn_emp
     WHERE dept_no = e.dept_no) --Compare employee salary with their own department average, not whole company.
     ;

--practice problems

SELECT *
FROM xxdn_emp
WHERE salary = (
     SELECT MAX(salary)
     FROM xxdn_emp);
     
SELECT *
FROM xxdn_emp
WHERE salary > (
      SELECT AVG(salary)
      FROM xxdn_emp
      );
      
SELECT *
FROM xxdn_emp
WHERE dept_no IN (
     SELECT dept_no
     FROM xxdn_dept
     WHERE location = 'BLR'
     );

SELECT *
FROM xxdn_emp
WHERE dept_no IS NULL;
--OR
SELECT *
FROM xxdn_emp e
WHERE NOT EXISTS (
     SELECT 1
     FROM xxdn_dept d
     WHERE d.dept_no = e.dept_no
     );

--CORRELATED SUBQUERY - Subquery runs for each other
--                    - row by row comparison

SELECT e.emp_name, e.salary
FROM xxdn_emp e
WHERE salary > (
     SELECT AVG(salary)
     FROM xxdn_emp
     WHERE dept_no = e.dept_no
     );
     
SELECT dept_no
FROM xxdn_emp e
GROUP BY dept_no
HAVING salary > (
     SELECT MAX(salary)
     FROM xxdn_emp
     WHERE dept_no = e.dept_no);
     
SELECT dept_no
FROM xxdn_emp
GROUP BY dept_no
HAVING SUM(salary) = (
     SELECT MAX(Total_salary)
     FROM
     (
        SELECT SUM(salary) AS Total_salary
        FROM xxdn_emp
        GROUP BY dept_no
     )
);
     
--=============================
--19 Apr 2026
--=============================

--SET OPERATORS - Combine results of multiple SELECT queries
--              - All SELECT Must match - Same no of columns
--                                      - Same data types
--                                      - Same order


--UNION - Combines results and removes duplicates
--      - Distinct Automatically

SELECT emp_name FROM xxdn_emp
UNION
SELECT dept_name FROM xxdn_dept;


SELECT dept_no FROM xxdn_emp
UNION
SELECT dept_no FROM xxdn_dept;

--UNION ALL - Combines results with duplicates
--          - Faster than UNION (bcz no duplicate check)

SELECT dept_no FROM xxdn_emp
UNION ALL
SELECT dept_no FROM xxdn_dept;

--INTERSECT - Returns common values
--          - Only matching dept_no

SELECT dept_no FROM xxdn_emp
INTERSECT
SELECT dept_no FROM xxdn_dept;

--MINUS - Returns values in first query NOT present in second query
--      - Dept no in emp but not in dept

SELECT dept_no FROM xxdn_emp
MINUS
SELECT dept_no FROM xxdn_dept;

-- Order By in SET Operations
--       Rule - Only one Order By at the -> END

SELECT dept_no FROM xxdn_emp
UNION
SELECT dept_no FROM xxdn_dept
ORDER BY dept_no;

--Column Naming Rule

SELECT dept_no AS d FROM xxdn_emp
UNION
SELECT dept_no FROM xxdn_dept;

--practice problems

SELECT dept_no FROM xxdn_emp
UNION
SELECT dept_no FROM xxdn_dept;

SELECT dept_no FROM xxdn_emp
UNION ALL
SELECT dept_no FROM xxdn_dept;

SELECT dept_no FROM xxdn_emp
INTERSECT
SELECT dept_no FROM xxdn_dept;

SELECT dept_no FROM xxdn_emp
MINUS
SELECT dept_no FROM xxdn_dept;

SELECT emp_name as name FROM xxdn_emp
UNION
SELECT dept_name FROM xxdn_dept;

SELECT emp_name FROM xxdn_emp
UNION ALL
SELECT emp_name FROM xxdn_emp
ORDER BY emp_name;

-- Rules to remember in SET OPERATORS

--1) Column matching - Same count + same data type + same order
--2) ORDER BY        - Only at the end
--3) UNION VS UNION ALL - UNION - Unique
--                      - UNION ALL - Faster



--DML - Data Manipulation Language

--1)Multitable Insert :-
--   - Definition: Insert into multiple tables using ONE query
--   - Types :-
--            1)Unconditional - Insert into all tables
--            2)Conditional - Insert based on condition

--1)Unconditional Insert :-

INSERT ALL
    INTO xxdn_dept VALUES (60, 'SUPPORT', 'DELHI')
    INTO xxdn_dept VALUES (70, 'HR2', 'MUMBAI')
SELECT * FROM dual;   -- just triggers insert


INSERT ALL
     INTO xxdn_emp VALUES (8,'ROMAN','MANAGER',2000,20,4)
     INTO xxdn_dept VALUES (80,'HR3','SOLAPUR')
SELECT * FROM dual;

--2)Conditional Insert :- Rows split based on condition

CREATE TABLE high_salary (
   emp_id NUMBER,
   emp_name VARCHAR2(50),
   salary NUMBER
   );
   
CREATE TABLE low_salary (
   emp_id NUMBER,
   emp_name VARCHAR2(50),
   salary NUMBER
   );
   
   
INSERT ALL
   WHEN salary > 7000 THEN
     INTO high_salary VALUES(emp_id, emp_name, salary)
   WHEN salary <= 7000 THEN
     INTO low_salary VALUES(emp_id,emp_name,salary)
SELECT emp_id, emp_name, salary
FROM xxdn_emp;

SELECT * FROM high_salary;
SELECT * FROM low_salary;

--practice problems

INSERT ALL
      INTO xxdn_emp VALUES (9,'SETH','SALESMAN',1000,30,5)
      INTO xxdn_dept VALUES(90,'SALES','MADRAS')
SELECT * FROM dual;

INSERT ALL 
    WHEN salary > 7000 THEN 
      INTO high_salary VALUES (emp_id, emp_name,salary)
    WHEN salary <=7000 THEN 
      INTO low_salary VALUES (emp_id,emp_name, salary)
SELECT emp_id,emp_name, salary 
FROM xxdn_emp;


--MERGE - Combine Insert + Update = Upsert in one statement
--      - Update if exists, else insert

MERGE INTO xxdn_emp t
USING (
    SELECT 1 emp_id, 'NEW_EMP' emp_name, 5000 salary, 10 dept_no FROM dual
    ) s 
    ON (t.emp_id = s.emp_id)
    
    WHEN MATCHED THEN 
       UPDATE SET t.salary = s.salary
       
    WHEN NOT MATCHED THEN 
       INSERT (emp_id, emp_name, salary, dept_no)
       VALUES (s.emp_id, s.emp_name, s.salary, s.dept_no);

--practice problem

MERGE INTO xxdn_emp t
USING (
       SELECT 1 emp_id, 'NEW_EMP' emp_name, 5000 salary, 10 dept_no FROM dual)
       s
       ON (t.emp_id = s.emp_id)
       WHEN MATCHED THEN 
         UPDATE SET t.salary = s.salary 
         
        WHEN NOT MATCHED THEN
           INSERT (emp_id, emp_name, salary, dept_no)
           VALUES (s.emp_id, s.emp_name, s.salary, s.dept_no);

--FLASHBACK (ADVANCED) - View past data (time travel)
--                     - Purpose - recover deleted data
--                     - Audit history

--          Types :-
--            1)Flashback Query - see old data
--            2)Flashback Table - restore table


SELECT *
FROM xxdn_emp
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE);

-- Shows table 5 min ago
-- FLASHBACK TABLE needs permission to change row positions (ROWIDs)
-- That permission is called row movement

ALTER TABLE xxdn_emp ENABLE ROW MOVEMENT;

FLASHBACK TABLE xxdn_emp TO TIMESTAMP
(SYSTIMESTAMP - INTERVAL '5' MINUTE);

--practice problems 

SELECT * 
FROM xxdn_emp
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE );

--TRACKING CHANHGES - Track changes in data over time
--                  - Purpose - Auditing
--                            - Data History
--                            - Debugging

--     Methods:-

--1)Using TIMESTAMP COLUMN

ALTER TABLE xxdn_emp
ADD last_updated TIMESTAMP;

UPDATE xxdn_emp
SET last_updated = SYSTIMESTAMP;

--2)Using TRIGGERS (ADVANCED) - Automatically Tracks Updates

CREATE OR REPLACE TRIGGER emp_update_trg
BEFORE UPDATE ON xxdn_emp
FOR EACH ROW
BEGIN
  :NEW.last_updated := SYSTIMESTAMP;
END;

--practice problems

SELECT *
FROM xxdn_emp
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '10' MINUTE);


CREATE OR REPLACE TRIGGER emp_update_trg
BEFORE UPDATE ON xxdn_emp
FOR EACH ROW
BEGIN
    :NEW.last_updated := SYSTIMESTAMP;
END;

--Pseudo column = temporary, system-generated column used in queries
--Examples:-
--ROWNUM
--SYSDATE
--ROWID

SELECT emp_name, ROWNUM
FROM xxdn_emp;

--ROWNUM is not in table → still works

ALTER TABLE xxdn_emp ENABLE ROW MOVEMENT;

ALTER TABLE xxdn_emp
ADD last_updated TIMESTAMP;


--DDL - Data Defintion Language
--    - Auto Commits (No Rollback)
--    - Logical structure stored in database
--    - Purpose - Organize and store data
--   🔥 COMMON OBJECTS
--      [Object]	    [Use]
--      Table	    store data
--      View	    virtual table
--      Index	    fast access
--      Sequence	auto numbers


--CREATE TABLE - Define structure before storing data

CREATE TABLE xxdn_student (
     id NUMBER PRIMARY KEY,
     name VARCHAR2(50),
     marks NUMBER(5,2)
);

CREATE TABLE xxdn_employee_test(
     emp_id NUMBER PRIMARY KEY,
     emp_name VARCHAR2(50),
     salary NUMBER
);

--Data types - Defines type of data column stores
--           - Control what data can be stored

--🔥 COMMON TYPES
--  [Type]	[Use]
--   NUMBER	    numeric
--   VARCHAR2	text
--   DATE	    date
--   TIMESTAMP	date + time


CREATE TABLE xxdn_sample(
    id NUMBER,
    name VARCHAR2(50),
    created_date DATE
);


--Constraints - Rules applied on columns
--            - Purpose - Ensure data integrity

--🔥 TYPES
--   [Constraint]	[Meaning]
--   PRIMARY KEY	unique + not null
--   NOT NULL	    cannot be empty
--   UNIQUE	        no duplicates
--   FOREIGN KEY	reference another table
--   CHECK	        condition

CREATE TABLE xxdn_dept_test(
     dept_no NUMBER PRIMARY KEY,
     dept_name VARCHAR2(50) NOT NULL
);

--FORIEGN KEY

CREATE TABLE xxdn_emp_test(
    emp_id NUMBER PRIMARY KEY,
    dept_no NUMBER,
    CONSTRAINT fk_xxdn_dept_test
    FOREIGN KEY (dept_no)
    REFERENCES xxdn_dept_test(dept_no)
);

--You can only insert dept_no in emp_test
--if that dept_no already exists in dept_test

--CREATE TABLE USING SUBQUERY (CTAS)
--     create table from existing data
--     Purpose - Copy structure + data quickly
--     IMP NOTE : Constraints are not copied
--                Only structure and data is copied


CREATE TABLE xxdn_emp_copy AS
SELECT * FROM xxdn_emp;

--SELECT *    - copies data
--WHERE 1=0   - copies structure only

CREATE TABLE xxdn_emp_empty AS
SELECT * FROM xxdn_emp WHERE 1=0;

SELECT * FROM xxdn_emp_copy;
SELECT * FROM xxdn_emp_empty;


--ALTER TABLE - Modify existing table
--       Purpose - Add/change/delete columns
--       Heavily used in real projects

--ADD COLUMN
-- no changes in existing ones
ALTER TABLE xxdn_emp
ADD email VARCHAR2(100);

--MODIFY COLUMN - chnage in columns properties like - data type, constraints, size
-- may affect existing data
ALTER TABLE xxdn_emp
MODIFY emp_name VARCHAR2(100);

--DROP COLUMN
ALTER TABLE xxdn_emp
DROP COLUMN email;

--DROP TABLE - Deletes table completely
--           - Data is lost permanently
--           - irreversible

DROP TABLE xxdn_emp_empty;

--practice problems

CREATE TABLE xxdn_dept_demo(
    dept_no NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50) NOT NULL
);


CREATE TABLE xxdn_emp_demo(
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    dept_no NUMBER,
    CONSTRAINT fk_dept_demo
    FOREIGN KEY (dept_no)
    REFERENCES xxdn_dept_demo(dept_no)
    );
    
CREATE TABLE xxdn_emp_demo_copy AS
SELECT * FROM xxdn_emp_demo;

CREATE TABLE xxdn_emp_demo_struct AS
SELECT * FROM xxdn_emp WHERE 1=0;

ALTER TABLE xxdn_emp_demo 
ADD  email VARCHAR2(50);

ALTER TABLE xxdn_emp_demo
MODIFY emp_name VARCHAR2(200);

ALTER TABLE xxdn_emp_demo
DROP COLUMN email;

DROP TABLE xxdn_emp_demo;

DESC xxdn_emp;
DESC xxdn_dept;
SELECT * FROM sal_grade;
SELECT * FROM xxdn_emp;
SELECT * FROM xxdn_dept;

COMMIT;


--================================
-- 20 Apr 2026
--================================

--DATA DICTIONARY - Metadata about database
--        Answers: - what tables exist
--                   what columns are in table
--                   what constraints are applied
--                   who own what

--       Table - stores data
--       Data Dictionary - stores info about tables


--View	        Meaning
--USER_TABLES	your tables
--ALL_TABLES	accessible tables
--DBA_TABLES	all tables (admin only)


--Using Data Dictionary Views :
--List All Tables

SELECT table_name
FROM user_tables;

SELECT column_name, data_type
FROM user_tab_columns
WHERE table_name = 'XXDN_EMP';
--Table name must be in UPPERCASE

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'XXDN_EMP';

--** constraint_type
--Code	Meaning
--P	    Primary key
--R	    Foreign key
--U	    Unique
--C	    Check

SELECT object_name, object_type
FROM user_objects;

SELECT column_name, constraint_name
FROM user_cons_columns
WHERE table_name = 'XXDN_EMP';


--Common Queries

--1] List all tables
SELECT table_name FROM user_tables;

--2. Describe table (alternative to DESC)
SELECT column_name, data_type, nullable
FROM user_tab_columns
WHERE table_name ='XXDN_EMP';

--3. Find primary key
SELECT constraint_name
FROM user_constraints
WHERE table_name = 'XXDN_EMP'
AND constraint_type = 'P';

--4. Find foreign key
SELECT constraint_name
FROM user_constraints
WHERE table_name = 'XXDN_EMP'
AND constraint_type = 'R';

--5. Find columns under constraint
SELECT column_name
FROM user_cons_columns
WHERE constraint_name = 'FK_DEPT';

SELECT * FROM user_tables;

SELECT * FROM user_tab_columns;

SELECT DISTINCT table_name
FROM user_tab_columns
WHERE table_name = 'XXDN_EMP';

SELECT *
FROM user_tab_columns
WHERE table_name = 'XXDN_EMP';

--practice problems

SELECT table_name FROM user_tables;

SELECT column_name
FROM user_tab_columns
WHERE table_name = 'XXDN_EMP';

SELECT constraint_name
FROM user_constraints
WHERE table_name = 'XXDN_EMP'
AND constraint_type = 'P';

SELECT constraint_name
FROM user_constraints
WHERE table_name = 'XXDN_EMP'
AND constraint_type = 'R';

SELECT column_name
FROM user_cons_columns
WHERE constraint_name = 'FK_DEPT';

--VIEW (in data dictionary)
--   means saved SQL query
--   Table = stores data
--   View = shows data (no storage)


CREATE VIEW xxdn_emp_view AS 
SELECT emp_name, salary
FROM xxdn_emp;

--Joining views after creation of 2 views

CREATE VIEW xxdn_emp_v AS
SELECT emp_id, emp_name, dept_no FROM xxdn_emp;

CREATE VIEW xxdn_dept_v AS 
SELECT dept_no, dept_name FROM xxdn_dept;

SELECT e.emp_name, d.dept_name
FROM xxdn_emp_v e
JOIN xxdn_dept_v d
ON e.dept_no = d.dept_no;

--practice problems

CREATE VIEW xxdn_e AS
SELECT emp_name, salary FROM xxdn_emp;

CREATE VIEW xxdn_d AS
SELECT dept_name FROM xxdn_dept;

CREATE OR REPLACE VIEW xxdn_d AS
SELECT dept_name, dept_no
FROM xxdn_dept;

CREATE OR REPLACE VIEW xxdn_e AS
SELECT emp_name, salary, dept_no
FROM xxdn_emp;

SELECT e.emp_name, d.dept_name
FROM xxdn_e e
JOIN xxdn_d d
ON e.dept_no = d.dept_no;

--Sequences : auto-number generator      
--         Purpose: Generate unique values (mostly for primary keys)

--Instead of manually writing emp_id = 1,2,3...
--→ database generates automatically

CREATE TABLE xxdn_empl(
     emp_id NUMBER PRIMARY KEY,
     emp_name VARCHAR2(50),
     salary NUMBER
     );
     
CREATE SEQUENCE xxdn_empl_seq
START WITH 1
INCREMENT BY 1;

INSERT INTO xxdn_empl(emp_id, emp_name, salary)
VALUES (xxdn_empl_seq.NEXTVAL, 'MANISH',6600);

--INSERT INTO xxdn_empl(emp_id, emp_name, salary)
--VALUES (xxdn_empl_seq.CURRVAL, 'RAM', 5000);

SELECT xxdn_empl.seq.CURRVAL FROM dual;

DESC xxdn_empl;
SELECT * FROM xxdn_empl;


CREATE TABLE xxdn_employee(
     emp_id NUMBER PRIMARY KEY,
     emp_name VARCHAR2(50),
     salary NUMBER
     );


CREATE SEQUENCE xxdn_employee_seq
START WITH 2
INCREMENT BY 1;

INSERT INTO xxdn_employee(emp_id, emp_name, salary)
VALUES (xxdn_employee_seq.NEXTVAL, 'RAM',5000);

INSERT INTO xxdn_employee(emp_id, emp_name, salary)
VALUES (xxdn_employee_seq.NEXTVAL, 'SHYAM', 10000);

INSERT INTO xxdn_employee (emp_id, emp_name, salary)
VALUES (xxdn_employee_seq.NEXTVAL, 'VIRAT', 3000);

UPDATE xxdn_employee
SET emp_id = 1
WHERE emp_name = 'RAM';

SELECT * FROM xxdn_employee;

SELECT xxdn_employee_seq.CURRVAL FROM dual;


--SYNONYMS - shortcut name for a table/object
--           alias for tables
-- Purpose : Avoid writing long names
--Object = any database component you create to store or manage data

SELECT * FROM xxdn_employee;

CREATE SYNONYM em FOR xxdn_employee;

SELECT * FROM em;

     --Types : 1) Private   - only you
     --        2) Public    - everyone
     
-- INDEX - structure that makes search faster
--        Purpose : Improve query performance

-- 🔥 Real Thinking
--Without index → full table scan  
--With index → direct search


CREATE INDEX xxdn_emp_name_idx
ON xxdn_emp(emp_name);

SELECT *
FROM xxdn_emp
WHERE emp_name = 'KING';

-- Faster if index exists

--IMPORTANT : 
-- WHERE condition - Use index
-- JOIN condition  - Use index

--IMP : Dont over use : too many indexes - slows insert/update

--Indexes are speed booster for queries

--practice problems

CREATE TABLE xxdn(
  emp_id NUMBER,
  emp_name VARCHAR2(50)
  );

CREATE SEQUENCE xxdn_seq
START WITH 1
INCREMENT BY 1;

BEGIN
    INSERT INTO xxdn (emp_id, emp_name)
    VALUES (xxdn_seq.NEXTVAL,'A');
    INSERT INTO xxdn (emp_id, emp_name)
    VALUES (xxdn_seq.NEXTVAL,'B');
END;
/COMMIT;
-- SIMPLE SQL way
INSERT INTO xxdn VALUES (xxdn_seq.NEXTVAL, 'A');
INSERT INTO xxdn VALUES (xxdn_seq.NEXTVAL, 'B');

CREATE SYNONYM x FOR xxdn;

SELECT * FROM x;

CREATE INDEX emp_name_idx
ON xxdn(emp_name);

--SELECT * FROM dual;
--
--SELECT * FROM xxdn;
--
--TRUNCATE TABLE xxdn;
--
--DROP SEQUENCE xxdn_seq;


-- CREATING VIEWS - SAVED SELECT QUERY

CREATE VIEW emp_view AS 
SELECT emp_id, emp_name
FROM xxdn;

SELECT * FROM xxdn_student;

CREATE SEQUENCE xxdn_student_seq
START WITH 1
INCREMENT BY 1;

DESC xxdn_student;

INSERT INTO xxdn_student VALUES (xxdn_student_seq.NEXTVAL,'X',50);
INSERT INTO xxdn_student VALUES (xxdn_student_seq.NEXTVAL,'Y',30);

CREATE SYNONYM st FOR xxdn_student;

SELECT * FROM st;

CREATE VIEW st_view AS
SELECT name, marks
FROM st;

SELECT * FROM st_view;

-- TYPES OF VIEWS :
--   1)SIMPLE VIEW - based on 1 table
--   2)COMPLEX VIEW - uses joins/functions

--MODIFY VIEW

--CREATE OR REPLACE VIEW view_name AS ....

--DROP VIEW 

DROP VIEW st_view;

-- MANAGING SCHEMA OBJECTS
-- Constraints - rules on table columns
--      purpose - to ensure correct and valid data to enter into database

--ADD/REMOVE/ENABLE/DISABLE constraints

ALTER TABLE xxdn_emp
ADD CONSTRAINT pk_emp PRIMARY KEY (emp_id);

DESC xxdn_student;

SELECT constraint_name
FROM user_constraints
WHERE table_name = 'XXDN_STUDENT'
AND constraint_type = 'P';

--ADD CONSTRAINT

ALTER TABLE xxdn_student
ADD CONSTRAINT pk_st PRIMARY KEY (id);

--IF ALREADY EXISTS - RENAME CONSTRAINT
ALTER TABLE xxdn_student
RENAME CONSTRAINT SYS_C00353697 TO pk_st;

--DROP CONSTRAINT

ALTER TABLE xxdn_student
DROP CONSTRAINT pk_st;

--DISABLE CONSTRAINT
-- Allows invalid data temporarily
ALTER TABLE xxdn_student
DISABLE CONSTRAINT fk_dept;

--ENABLE constraint
ALTER TABLE xxdn_emp
ENABLE CONSTRAINT fkr_dept;

-- TEMPORARY TABLES : data exists only for session or transaction

CREATE GLOBAL TEMPORARY TABLE temp_emp(
   emp_id NUMBER,
   emp_name VARCHAR2(50)
   )
   ON COMMIT DELETE ROWS;
   
-- Insert data - visinle only to you
-- Other users - cannot see

INSERT INTO temp_emp VALUES (1,'TEMP');

SELECT * FROM temp_emp;

COMMIT;

--Temporary table = short-term storage


--EXTERNAL TABLES :table that reads data from file (CSV, text)
--            Data is NOT inside database  
--            It is outside (file)

--CREATE TABLE ext_emp (
--  emp_id NUMBER,
--  emp_name VARCHAR2(50)
--)
--ORGANIZATION EXTERNAL
--(
--  TYPE ORACLE_LOADER
--  DEFAULT DIRECTORY my_dir
--  ACCESS PARAMETERS (...)
--  LOCATION ('emp.csv')
--);


--External table = file treated as table

SELECT * FROM xxdn;

--practice problems

ALTER TABLE xxdn
ADD CONSTRAINT pk_emp PRIMARY KEY (emp_id);

CREATE GLOBAL TEMPORARY TABLE temp_emp(
 emp_id NUMBER,
 emp_name VARCHAR2(50)
 )
 ON COMMIT DELETE ROWS;
 
 SELECT constraint_name
 FROM user_constraints
 WHERE table_name = 'XXDN';
 
 SELECT * FROM user_constraints;
 
 ALTER TABLE xxdn
 DISABLE CONSTRAINT fk_dept;
 
 --External Table - Fetch data from out side sources like csv or text file 
 --                 not from the database


--SUBQUERY AS A SOURCE
--             Use Subquery like a table
--         Purpose : when you need intermediate result

SELECT *
FROM (
     SELECT emp_name, salary
     FROM xxdn_emp
     WHERE salary > 5000
     )temp;


--MULTIPLE-COLUMN SUBQUERY
--   Means : Subquery returns more than one column
-- Purpose : Compare multiple columns together

SELECT *
FROM xxdn_emp
WHERE (dept_no, salary) IN (
      SELECT dept_no, MAX(salary)
      FROM xxdn_emp
      GROUP BY dept_no
      );
      
      --means : get highest salary employee in each dept


--SCALAR SUBQUERY
-- Means : Subquery returns one value, used inside SELECT
-- Purpose : Add extra column dynamically

SELECT emp_name, salary, (
    SELECT AVG(salary) FROM xxdn_emp) AS avg_salary
FROM xxdn_emp;

-- Meaning
-- Shows:
--employee salary
--overall avg salary

--CORRELATED SUBQUERY
-- Means : Subquery runs for each row
-- Purpose : Row-by-row comparison

SELECT emp_name, salary
FROM xxdn_emp e
WHERE salary > (
     SELECT AVG(salary)
     FROM xxdn_emp
     WHERE dept_no = e.dept_no
     );
     
--    Means 
--    Employee > their dept average


--WITH CLAUSE (VERY IMPORTANT)

-- Defn: create temporary named subquery
-- Purpose : Make query readable + reusable

WITH high_sal AS (
    SELECT * FROM xxdn_emp WHERE salary > 5000
    )
    SELECT * FROM high_sal;
    
WITH dept_avg AS (
   SELECT dept_no, AVG(salary) avg_sal
   FROM xxdn_emp
   GROUP BY dept_no
   )
   SELECT e.emp_name, e.salary
   FROM xxdn_emp e
   JOIN dept_avg d 
   ON e.dept_no = d.dept_no
   WHERE e.salary > d.avg_sal;

--WITH = name your subquery and reuse it

-- FINAL SUMMARY
--Topic	                   One Line

--Subquery as source	   subquery = table
--Multi-column subquery	   compare multiple columns
--Scalar subquery	       single value in SELECT
--Correlated subquery	   runs per row
--WITH clause	           named subquery


--practice problems

SELECT *
FROM (
     SELECT emp_name, salary
     FROM xxdn_emp
     WHERE salary > 5000
     )
     temp;
     
SELECT *
FROM xxdn_emp
WHERE (dept_no,salary) IN (
      SELECT dept_no, MAX(salary)
      FROM xxdn_emp
      GROUP BY dept_no
      );

SELECT emp_name,
       salary,
       (SELECT AVG(salary) FROM xxdn_emp) AS avg_salary
FROM xxdn_emp;

SELECT emp_name, salary
FROM xxdn_emp e
WHERE salary > (
    SELECT AVG(salary)
    FROM xxdn_emp
    WHERE dept_no = e.dept_no
);

WITH dept_avg AS (
SELECT dept_no, AVG(salary) AS avg_sal
FROM xxdn_emp
GROUP BY dept_no
)
SELECT e.emp_name, e.salary
FROM xxdn_emp e
JOIN dept_avg d
ON e.dept_no = d.dept_no
WHERE e.salary > d.avg_sal;

--USING SUBQUERIES TO MANIPULATE DATA
-- Defn: Use subqueries inside INSERT / UPDATE / DELETE
-- Purpose : Perform data changes based on dynamic conditions

--1)UPDATE USING SUBQUERY

--Increase salary based on department average

UPDATE xxdn_emp e
SET e.salary = e.salary + 1000
WHERE e.salary < (
    SELECT AVG(ee.salary)
    FROM xxdn_emp ee
    WHERE ee.dept_no = e.dept_no
);
--ERROR need to resolve

--Means : Update only employees below dept average

--DELETE USING SUBQUERY

DELETE FROM xxdn_emp
WHERE salary = (
    SELECT MIN(salary)
    FROM xxdn_emp
);

--Delete employees with lowest salary


--INSERT USING SUBQUERY (VERY IMPORTANT)
-- Defn: Insert data from another query
--Purpose : Copy/transform data



--====================
-- SQL Practice 
--====================

--SELECT emp_name, salary
--FROM emp;
--
--SELECT emp_name, salary, salary*1.10 as incremented_salary 
--FROM emp;
--
--SELECT DISTINCT dept_no
--FROM emp;
--
--SELECT *
--FROM emp
--WHERE salary > 3000;
--
--SELECT *
--FROM emp
--ORDER BY salary DESC;
--
--SELECT *
--FROM emp
--ORDER BY salary DESC
--FETCH FIRST 5 ROWS ONLY;
--
--SELECT UPPER(emp_name) AS Capital_Name
--FROM emp;
--
--SELECT ROUND(salary, -2)
--FROM emp;
--
--SELECT MONTHS_BETWEEN(date1, date2)
--FROM dual;
----EX: SELECT MONTHS_BETWEEN(SYSDATE, DATE '2025-04-19')
----    FROM dual;
--
--SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY')
--FROM dual;
--
--SELECT NVL(salary,0)
--FROM emp;
--
--SELECT emp_name,
--CASE
--    WHEN salary > 7000 THEN 'High_salary'
--    WHEN salary <=7000 AND salary > 4000 THEN 'Mid-level_salary'
--    ELSE 'Low_salary'
--END
--FROM emp;
--
--
--SELECT AVG(salary) AS Average_salary
--FROM emp;
--
--SELECT dept_no, SUM(salary)
--FROM emp
--GROUP BY dept_no;
--
--SELECT dept_no
--FROM emp
--GROUP BY dept_no
--HAVING AVG(salary) > 2000;
--
--SELECT e.emp_name, d.dept_name
--FROM emp e
--INNER JOIN dept d
--ON e.dept_no = d.dept_no;
--
--SELECT e.emp_name, d.dept_name
--FROM emp e
--LEFT JOIN dept d
--ON e.dept_no = d.dept_no;
--
--SELECT e.emp_name, m.emp_name AS manager
--FROM emp e
--JOIN emp m
--ON e.manager_id = m.emp_id;
--
--SELECT emp_name
--FROM emp
--WHERE salary >(
--     SELECT AVG(salary)
--     FROM emp
--);
--
--SELECT *
--FROM emp
--WHERE dept_no IN (
--     SELECT dept_no
--     FROM emp
--     WHERE emp_name = 'KING'
--     );
--     
--SELECT dept_no as dept FROM emp 
--UNION
--SELECT dept_no FROM dept;
--
--SELECT dept_no as dept FROM emp
--INTERSECT
--SELECT dept_no FROM dept;
--
--INSERT INTO emp (emp_id, emp_name, salary, dept_no)
--VALUES (1, 'John', 5000, 10);
--
--UPDATE emp
--SET salary = salary*1.20
--WHERE dept_no = 10;
--
--DELETE FROM emp
--WHERE emp_id = 1;
--
--CREATE TABLE emp (
--  emp_id NUMBER,
--  emp_name VARCHAR2(50),
--  salary NUMBER,
--  dept_no NUMBER
--  );
--  
--ALTER TABLE emp
--ADD age NUMBER;
--
--
--DROP TABLE emp;
--
--CREATE VIEW emp_view AS
--SELECT emp_name, salary FROM emp;
--
--CREATE SEQUENCE emp_seq
--START WITH 1 INCREMENT BY 1;
--
--CREATE INDEX idx_emp_name
--ON emp(emp_name);
--
--SELECT emp_name
--FROM emp e1
--WHERE salary > (
--   SELECT AVG(salary)
--   FROM emp e2
--   WHERE e1.dept_no = e2.dept_no
--);
--
--GRANT SELECT ON emp TO user1;
--
--REVOKE SELECT ON emp FROM user1;
--
--SELECT SYSTIMESTAMP FROM dual;


SELECT dept_no, MAX(salary)
FROM xxdn_emp
GROUP BY dept_no
HAVING MAX(salary)>5000;

--IN
--dept_no IN (SELECT dept_no FROM dept)

--EXISTS
--WHERE EXISTS(SELECT 1 FROM dept_d WHERE d.dept_no = e.dept_no)

SELECT dept_no, SUM(salary)
FROM xxdn_emp
GROUP BY dept_no;

--Every column in SELECT must be : 
--     Either aggregated OR included in GROUP BY

SELECT dept_no, SUM(salary) AS sum
FROM xxdn_emp
GROUP BY dept_no
HAVING SUM(salary) > 10000;


--Single row subquery

SELECT *
FROM xxdn_emp
WHERE salary > (
      SELECT AVG(salary) FROM xxdn_emp
      );
      
-- compare with =,>,<

--MULTIROW SUBQUERY

--returns multiple values

SELECT *
FROM xxdn_emp
WHERE dept_no IN (
    SELECT dept_no FROM xxdn_dept
    );
    
    --use IN, ANY , ALL
    
    
--Correlated subquery

-- runs once per row of outer query

SELECT *
FROM xxdn_emp e
WHERE salary > (
     SELECT AVG(salary)
     FROM xxdn_emp
     WHERE dept_no = e.dept_no
     );
     
--     Meaning:
--For each employee
--calculate avg salary of THEIR dept
--then compare
--
--✔ dynamic, row-by-row
--❌ slower

--SCALER SUBQUERY

--returns exaclty one value +  used in SELECT

SELECT emp_name,
       (SELECT AVG(salary) FROM xxdn_emp) AS avg_sal
FROM xxdn_emp;

--acts like a column


--INLINE VIEW (SUBQUERY IN FROM)

--acts like a temporary table

SELECT *
FROM (
   SELECT dept_no, AVG(salary) avg_sal
   FROM xxdn_emp
   GROUP BY dept_no
   )t
   WHERE avg_sal > 5000;
   
   
--DATE FUNCTIONS
   
--SYSDATE
SELECT SYSDATE FROM dual;

--ADD_MONTHS

SELECT ADD_MONTHS(SYSDATE,3) FROM dual;

--MONTHS_BETWEEN

SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2025-04-22','YYYY-MM-DD')) FROM dual;

SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('01-01-2025','DD-MM-YYYY')) 
FROM dual;


--NEXT_DAY

SELECT NEXT_DAY(SYSDATE,'SUNDAY') FROM dual;

--LAST_DAY

SELECT LAST_DAY(SYSDATE) FROM dual;

----VIEWS
    -- CREATE
CREATE VIEW emp_v AS
SELECT emp_name FROM xxdn_emp;

    --REPLACE
CREATE OR REPLACE VIEW emp_v AS
SELECT emp_name, emp_id FROM xxdn_emp;

    --USE
SELECT * FROM emp_v;


--INDEX

CREATE INDEX emp_idx2
ON xxdn_emp(salary);

-- DATA DICTIONARY

--Tables List
SELECT table_name FROM user_tables;

--Columns
SELECT column_name FROM user_tab_columns
WHERE table_name = 'XXDN_EMP';

--CONSTRAINTS
SELECT * FROM user_constraints;

--SYNONYMS

CREATE SYNONYM e1 FOR xxdn_emp;

--TEMPORARY TABLE

CREATE GLOBAL TEMPORARY TABLE temp_emp(
   salary NUMBER
)
ON COMMIT DELETE ROWS;

--EXTERNAL TABLE
  --cannot just run
  GRANT CREATE ANY DIRECTORY TO test_user;
  GRANT CREATE USER TO test_user;
  CREATE USER test_user IDENTIFIED BY test123;
  
  --step 1 - create directory
  
  
  CREATE OR REPLACE DIRECTORY ext_dir AS 'D:\SQL\emp.csv';
  
  
  --step 2 - grant access
  
--  GRANT READ, WRITE ON DIRECTORY ext_dir TO 

--Check existing users
SELECT username FROM all_users;

SELECT * FROM ext_table;

--FLASHBACK

SELECT *
FROM xxdn_emp
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE);

--TRACKING CHANGES

   --COLUMN
   ALTER TABLE xxdn_emp ADD last_updated TIMESTAMP;
   
   --TRIGGER
--   :NEW.last_updated := SYSTIMESTAMP;

--SEQUENCE

CREATE SEQUENCE emp_seqnce;
--INSERT INTO xxdn_emp VALUES (emp_seqnce.NEXTVAL,...);

--CONSTRAINT MANAGEMENT

ALTER TABLE xxdn_emp ADD CONSTRAINT pk PRIMARY KEY (emp_id);

ALTER TABLE xxdn_emp DROP CONSTRAINT pk;

--USER ACCESS

--GRANT
GRANT SELECT ON xxdn_emp TO user1;

--ROLE 
CREATE ROLE r1;
GRANT SELECT TO r1;

--REVOKE
REVOKE SELECT ON xxdn_emp FROM user1;

--TIME ZONE FUNCTIONS
 --current time
SELECT CURRENT_TIMESTAMP FROM dual;

 --interval
SELECT SYSDATE + INTERVAL '5' DAY FROM dual;


