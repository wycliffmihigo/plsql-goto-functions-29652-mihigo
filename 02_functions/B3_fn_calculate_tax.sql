-- B3: Monthly PAYE tax (simplified, progressive brackets, in RWF)
--   0       - 60,000   : 0%
--   60,001  - 100,000  : 10% of the part above 60,000
--   100,001 - 200,000  : 20% of the part above 100,000 (+4,000)
--   above 200,000      : 30% of the part above 200,000 (+24,000)
CREATE OR REPLACE FUNCTION fn_calculate_tax (
  p_monthly_salary IN NUMBER
) RETURN NUMBER
IS
  v_tax NUMBER;
BEGIN
  IF p_monthly_salary IS NULL OR p_monthly_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Salary must be a non-negative number.');
  END IF;

  IF p_monthly_salary <= 60000 THEN
    v_tax := 0;
  ELSIF p_monthly_salary <= 100000 THEN
    v_tax := (p_monthly_salary - 60000) * 0.10;
  ELSIF p_monthly_salary <= 200000 THEN
    v_tax := 4000 + (p_monthly_salary - 100000) * 0.20;
  ELSE
    v_tax := 24000 + (p_monthly_salary - 200000) * 0.30;
  END IF;

  RETURN ROUND(v_tax, 2);
END fn_calculate_tax;
/
