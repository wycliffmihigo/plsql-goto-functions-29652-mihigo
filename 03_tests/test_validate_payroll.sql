SET LINESIZE 200
COLUMN result FORMAT A70

SELECT payroll_id, emp_id, TO_CHAR(pay_month,'YYYY-MM') AS pay_month,
       fn_validate_payroll(payroll_id) AS result
FROM   payroll
ORDER  BY payroll_id;

SELECT fn_validate_payroll(999) AS result FROM dual;
