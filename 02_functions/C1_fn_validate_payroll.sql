CREATE OR REPLACE FUNCTION fn_validate_payroll (
  p_payroll_id IN payroll.payroll_id%TYPE
) RETURN VARCHAR2
IS
  v_pay payroll%ROWTYPE;
  v_emp employees%ROWTYPE;
  v_msg VARCHAR2(200) := 'VALID';
BEGIN
  SELECT * INTO v_pay FROM payroll   WHERE payroll_id = p_payroll_id;
  SELECT * INTO v_emp FROM employees WHERE emp_id     = v_pay.emp_id;

  -- Check 1: employee must be ACTIVE
  IF v_emp.status <> 'ACTIVE' THEN
    v_msg := 'INVALID: employee ' || v_emp.emp_id || ' is not ACTIVE';
    GOTO validation_done;
  END IF;

  -- Check 2: employee must belong to a real department
  IF fn_dept_name(v_emp.dept_id) = 'Unknown Department' THEN
    v_msg := 'INVALID: employee has no valid department';
    GOTO validation_done;
  END IF;

  -- Check 3: gross must equal the employee's monthly salary
  IF v_pay.gross_salary <> v_emp.monthly_salary THEN
    v_msg := 'INVALID: gross ' || v_pay.gross_salary ||
             ' differs from salary ' || v_emp.monthly_salary;
    GOTO validation_done;
  END IF;

  -- Check 4: tax must match fn_calculate_tax
  IF v_pay.tax_amount <> fn_calculate_tax(v_pay.gross_salary) THEN
    v_msg := 'INVALID: tax ' || v_pay.tax_amount ||
             ' should be ' || fn_calculate_tax(v_pay.gross_salary);
    GOTO validation_done;
  END IF;

  -- Check 5: net = gross - tax
  IF v_pay.net_salary <> v_pay.gross_salary - v_pay.tax_amount THEN
    v_msg := 'INVALID: net ' || v_pay.net_salary ||
             ' should be ' || (v_pay.gross_salary - v_pay.tax_amount);
    GOTO validation_done;
  END IF;

  <<validation_done>>
  RETURN v_msg;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'INVALID: payroll or employee record not found';
  WHEN OTHERS THEN
    RETURN 'ERROR: ' || SQLERRM;
END fn_validate_payroll;
/




