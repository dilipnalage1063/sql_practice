SELECT * FROM xxdn_emp;
SELECT * FROM xxdn_dept;

--1. Highest salary per department

SELECT *
FROM xxdn_emp e
WHERE (dept_no, salary) IN (
     SELECT dept_no, MAX(salary)
     FROM xxdn_emp
     GROUP BY dept_no
     );
     
--OR
     
SELECT *
FROM xxdn_emp e
WHERE salary = (
    SELECT MAX(salary)
    FROM xxdn_emp
    WHERE dept_no = e.dept_no
    );
    
--2. Employees without department

SELECT *
FROM xxdn_emp e
LEFT JOIN xxdn_dept d
ON e.dept_no = d.dept_no
WHERE d.dept_no IS NULL;

--3. Second highest salary

SELECT *
FROM xxdn_emp
WHERE salary = (
     SELECT MAX(salary)
     FROM xxdn_emp
     WHERE salary < (
           SELECT MAX(salary)
           FROM xxdn_emp
           )
           );
           
--OR 

SELECT *
FROM xxdn_emp
ORDER BY salary DESC NULLS LAST
OFFSET 1 ROW FETCH NEXT 1 ROW ONLY;

--4. Employees above dept average

SELECT *
FROM xxdn_emp e
WHERE salary > (
    SELECT AVG(salary)
    FROM xxdn_emp
    WHERE dept_no = e.dept_no);
    

--Q1 — NOT assigned to department

SELECT *
FROM xxdn_emp e
LEFT JOIN xxdn_dept d
ON e.dept_no = d.dept_no
WHERE d.dept_no IS NULL;

--Q2 — Dept with highest total salary

SELECT dept_no
FROM xxdn_emp
GROUP BY dept_no
HAVING SUM(salary) = (
    SELECT MAX(SUM(salary))
    FROM xxdn_emp
    GROUP BY dept_no
    );
    
--Q3 — > avg AND < max
SELECT *
FROM xxdn_emp
WHERE salary > (SELECT AVG(salary) FROM xxdn_emp)
AND salary < (SELECT MAX(salary) FROM xxdn_emp);

--Q4 — Highest in dept (CORRELATED)

SELECT *
FROM xxdn_emp e
WHERE salary = (
     SELECT MAX(salary)
     FROM xxdn_emp
     WHERE dept_no = e.dept_no);
     
     
--Q5 — 3rd highest salary

SELECT *
FROM xxdn_emp
ORDER BY salary DESC NULLS LAST
OFFSET 2 ROWS FETCH NEXT 1 ROW ONLY;

--Q6 — Dept name + employee count

SELECT d.dept_name, COUNT(e.emp_id)
FROM xxdn_dept d
LEFT JOIN xxdn_emp e
ON d.dept_no = e.dept_no
GROUP BY d.dept_name;

--Q7)CASE CATEGORIZATION

SELECT emp_name,
CASE 
    WHEN salary > 8000 THEN 'HIGH'
    WHEN salary >=5000 THEN 'MEDIUM'
    ELSE 'LOW'
END AS sal_grade
FROM xxdn_emp;

--Q8 — EXISTS

SELECT *
FROM xxdn_emp e
WHERE EXISTS (
   SELECT 1
   FROM xxdn_dept d
   WHERE d.dept_no = e.dept_no
   );
   
   
--pattern drills

--PATTERN 1 — TOP N / RANKING 

SELECT *
FROM xxdn_emp
WHERE salary = (
   SELECT MAX(salary)
   FROM xxdn_emp);
   
SELECT *
FROM xxdn_emp
WHERE salary = (
    SELECT MAX(salary)
    FROM xxdn_emp
    WHERE salary < (
         SELECT MAX(salary)
         FROM xxdn_emp)
         );
-- or

SELECT *
FROM xxdn_emp
ORDER BY salary DESC NULLS LAST
OFFSET 1 ROW FETCH NEXT 1 ROW ONLY;

SELECT *
FROM xxdn_emp
ORDER BY salary DESC NULLS LAST
OFFSET 2 ROW FETCH NEXT 1 ROW ONLY;

--PATTERN 2 — GROUP BY (PER GROUP)

SELECT dept_no, SUM(salary)
FROM xxdn_emp
GROUP BY dept_no;

SELECT dept_no, MAX(salary)
FROM xxdn_emp
GROUP BY dept_no;

--PATTERN 3 — MISSING DATA (LEFT JOIN)

SELECT *
FROM xxdn_emp e
LEFT JOIN xxdn_dept d
ON e.dept_no = d.dept_no
WHERE d.dept_no IS NULL;

--PATTERN 4 — COMPARISON (SUBQUERY)

SELECT *
FROM xxdn_emp
WHERE salary > (
      SELECT AVG(salary)
      FROM xxdn_emp
      );
      
--PATTERN 5 — PER GROUP COMPARISON (CORRELATED)

SELECT *
FROM xxdn_emp e
WHERE salary > (
      SELECT AVG(salary)
      FROM xxdn_emp
      WHERE dept_no = e.dept_no);
      
      
      
--Questions

SELECT dept_no
FROM xxdn_emp
WHERE dept_no IN (
     SELECT MAX(SUM(salary))
     FROM xxdn_emp
     GROUP BY dept_no
     );
     
SELECT MAX(SUM(salary))
FROM xxdn_emp
GROUP BY dept_no;

SELECT e.emp_name, d.dept_name
FROM xxdn_emp e
LEFT JOIN xxdn_dept d
ON e.dept_no = d.dept_no
WHERE d.dept_no IS NULL;


SELECT * FROM eval_departments ORDER BY department_id;
SELECT * FROM eval_employees ORDER BY employee_id;
SELECT * FROM eval_emp ORDER BY employee_id;