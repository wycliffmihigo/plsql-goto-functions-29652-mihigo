-- A3: Illegal GOTO and Fix
-- A GOTO can never jump INTO an IF, LOOP, CASE or sub-block.
SET SERVEROUTPUT ON;

-- PART 1: ILLEGAL (will NOT compile: PLS-00375)
DECLARE
  v_salary NUMBER := 500000;
BEGIN
  GOTO inside_if;

  IF v_salary > 100000 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Reached the label inside the IF block');
  END IF;
END;
/

-- PART 2: FIXED (label moved to the enclosing block)
DECLARE
  v_salary NUMBER := 500000;
BEGIN
  IF v_salary > 100000 THEN
    GOTO high_salary;
  END IF;

  DBMS_OUTPUT.PUT_LINE('Salary is not high.');
  GOTO finish;

  <<high_salary>>
  DBMS_OUTPUT.PUT_LINE('Reached the label correctly: salary is high.');

  <<finish>>
  DBMS_OUTPUT.PUT_LINE('Done.');
END;
/
