SELECT * FROM eval_departments ORDER BY department_id;
SELECT * FROM eval_employees ORDER BY employee_id;
SELECT * FROM eval_emp ORDER BY employee_id;


DESC eval_departments;
DESC eval_employees;
DESC eval_emp;

--Q[1]
--SELECT employee_name,
--       department_id,
--       ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) rn
--FROM eval_emp;




--Q[2]
SELECT e.employee_name AS emp_earn_more_than_their_manager
FROM eval_employees e
JOIN eval_employees m
ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;



--Q[3]
SELECT department_id,COUNT(*) AS more_than_3_emp
FROM eval_employees
GROUP BY department_id
HAVING COUNT(*) > 3;



--Q[4]
SELECT *
FROM eval_employees
WHERE salary = (
     SELECT MAX(salary)
     FROM eval_employees
     WHERE salary < (SELECT MAX(salary)
          FROM eval_employees
          ));


--Q[5]
SELECT department_id
FROM eval_employees
GROUP BY department_id
HAVING AVG(salary) > (
      SELECT AVG(salary)
      FROM eval_employees
      );
      
      
--Q[6]
SELECT *
FROM eval_employees e
WHERE department_id IS NULL;







--Q[7]
SELECT d.department_id AS dept_with_no_emp
FROM eval_departments d
LEFT JOIN eval_employees e
ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

--Q[8]
SELECT e.employee_name, d.department_name, d.location
FROM eval_employees e
LEFT JOIN eval_departments d
ON e.department_id = d.department_id;




--Q[9]
SELECT e.employee_name
FROM eval_employees e
JOIN eval_employees m
ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;

--[10]
SELECT department_id, MAX(salary) max_sal, MIN(salary) min_sal
FROM eval_employees
GROUP BY department_id;


--Q[11]
SELECT employee_name, salary,
CASE
     WHEN salary > (SELECT AVG(salary) FROM eval_employees) THEN 'ABOVE AVG'
     ELSE 'BELOW AVG'
END AS Status
FROM eval_employees;

--Q[12]
    SELECT *
    FROM eval_employees
    WHERE employee_id NOT IN (
         SELECT DISTINCT manager_id
         FROM eval_employees
         WHERE manager_id IS NOT NULL
         );




--Q[13]
SELECT employee_name, department_id, COUNT(*)
FROM eval_employees
GROUP BY employee_name, department_id
HAVING COUNT(*) > 1;



--Q[14]
--DELETE FROM eval_emp e
--WHERE ROWID > (
--    SELECT MIN(ROWID)
--    FROM eval_emp
--    WHERE employee_name = e.employee_name
--    AND department_id = e.department_id
--);





--Q[15]
SELECT *
FROM eval_employees
WHERE salary IN (
    SELECT salary
    FROM eval_employees
    GROUP BY salary
    HAVING COUNT(*) > 1
);

--Q[16]
SELECT employee_name, SUBSTR(employee_name,1,3)
FROM eval_employees;





--Q[17]
SELECT employee_name, INSTR(employee_name,'A')
FROM eval_employees;


--Q[18]
SELECT employee_name,
NVL2(commission, 'Has Commission', 'No Commission')
FROM eval_employees;



--Q[19]
SELECT department_id, SUM(salary)
FROM eval_employees
GROUP BY department_id
HAVING SUM(salary) > 10000;

--Q[20]
SELECT TO_DATE('2024-01-15','YYYY-MM-DD')
FROM dual;



--Q[21]
SELECT employee_name,
       CASE
           WHEN salary >= 6000 THEN 'High'
           WHEN salary >= 3000 THEN 'Medium'
           ELSE 'Low'
       END AS category
FROM eval_employees;



--Q[22]
--SELECT employee_name,
--       DECODE(
--           SIGN(salary-6000), 1, 'High',
--           DECODE(
--               SIGN(salary-3000), 1, 'Medium',
--               'Low'
--           )
--       ) category
--FROM eval_emp;

--Q[23]
SELECT salary,
       FLOOR(salary),
       CEIL(salary)
FROM eval_employees;





--Q[24]
SELECT *
FROM eval_employees
WHERE salary = FLOOR(salary/1000)*1000;








--Q[25]
SELECT department_id,
       MIN(salary),
       MAX(salary),
       AVG(salary)
FROM eval_employees
GROUP BY department_id;





--Q[26]
CREATE TABLE emp_merge_target (
    employee_id   NUMBER PRIMARY KEY,
    employee_name VARCHAR2(50),
    salary        NUMBER
);

MERGE INTO emp_merge_target t
USING eval_emp e
ON (t.employee_id = e.employee_id)
WHEN MATCHED THEN
  UPDATE SET 
    t.salary = e.salary,
    t.employee_name = e.employee_name
WHEN NOT MATCHED THEN
  INSERT (employee_id, employee_name, salary)
  VALUES (e.employee_id, e.employee_name, e.salary);
  
  
  
  
  
  
  
  
--[27]
CREATE TABLE top5_employees AS
SELECT * FROM eval_employees WHERE 1=2;
  INSERT INTO top5_employees
SELECT *
FROM (
    SELECT *
    FROM eval_employees
    ORDER BY salary DESC
)
WHERE ROWNUM <= 5;

--Q[28]
UPDATE eval_employees e
SET salary = (
    SELECT AVG(salary)
    FROM eval_employees
    WHERE department_id = e.department_id
)
WHERE department_id IS NOT NULL;



--Q[29]
DELETE FROM eval_employees
WHERE department_id IS NULL;



--Q[30] Rollback (concept)
--   1)ROLLBACK; Undo uncommitted changes
--   2)Works only before COMMIT
--   3)Uses undo segments internally



--Q[31]
SELECT TO_CHAR(hire_date,'DD-MON-YYYY')
FROM eval_employees;


--Q[32]
WITH dept_avg AS (
    SELECT department_id, AVG(salary) avg_sal
    FROM eval_employees
    GROUP BY department_id
)
SELECT * FROM dept_avg;



--Q[33] WHERE vs HAVING
--WHERE → filters rows before grouping
--HAVING → filters after aggregation

--Example:

SELECT department_id, COUNT(*)
FROM eval_employees
WHERE salary > 2000
GROUP BY department_id
HAVING COUNT(*) > 2;



--Q[34] NOT IN with NULL
--If subquery returns NULL → entire result becomes empty
--Safe alternative for it:
--WHERE NOT EXISTS (...)




--Q[35]Palindrome names
SELECT employee_name
FROM eval_employees
WHERE employee_name = REVERSE(employee_name);