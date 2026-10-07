-- A4: Rewrite A2 WITHOUT GOTO (structured IF / ELSIF / ELSE)
SET SERVEROUTPUT ON;

DECLARE
  v_emp_id   employees.emp_id%TYPE := 4;
  v_name     VARCHAR2(100);
  v_salary   employees.monthly_salary%TYPE;
  v_pct      NUMBER;
  v_new_sal  NUMBER;
BEGIN
  SELECT first_name || ' ' || last_name, monthly_salary
  INTO   v_name, v_salary
  FROM   employees
  WHERE  emp_id = v_emp_id;

  IF v_salary < 300000 THEN
    v_pct := 10;
  ELSIF v_salary < 700000 THEN
    v_pct := 5;
  ELSE
    v_pct := 0;
  END IF;

  v_new_sal := v_salary + (v_salary * v_pct / 100);
  DBMS_OUTPUT.PUT_LINE('Employee      : ' || v_name);
  DBMS_OUTPUT.PUT_LINE('Current salary: ' || TO_CHAR(v_salary,  'FM999,999,999'));
  DBMS_OUTPUT.PUT_LINE('Raise         : ' || v_pct || '%');
  DBMS_OUTPUT.PUT_LINE('Proposed      : ' || TO_CHAR(v_new_sal, 'FM999,999,999'));
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No employee found with ID ' || v_emp_id);
END;
/
