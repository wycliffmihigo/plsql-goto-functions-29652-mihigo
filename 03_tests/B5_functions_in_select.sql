SET LINESIZE 200
SET PAGESIZE 50
COLUMN full_name FORMAT A22
COLUMN department FORMAT A24

-- 1) Functions in SELECT and ORDER BY
SELECT e.emp_id,
       e.first_name || ' ' || e.last_name        AS full_name,
       fn_dept_name(e.dept_id)                   AS department,
       e.monthly_salary,
       fn_annual_salary(e.emp_id)                AS annual_salary,
       fn_years_of_service(e.emp_id)             AS years_service,
       fn_calculate_tax(e.monthly_salary)        AS monthly_tax,
       e.monthly_salary - fn_calculate_tax(e.monthly_salary) AS net_salary
FROM   employees e
ORDER  BY fn_annual_salary(e.emp_id) DESC;

-- 2) Functions in WHERE
SELECT emp_id, first_name, last_name,
       fn_years_of_service(emp_id)        AS years_service,
       fn_calculate_tax(monthly_salary)   AS monthly_tax
FROM   employees
WHERE  fn_years_of_service(emp_id) >= 5
AND    fn_calculate_tax(monthly_salary) > 20000;
