-- A1: Number Classifier using GOTO
SET SERVEROUTPUT ON;

DECLARE
  v_num NUMBER := 7;
BEGIN
  IF v_num < 0 THEN
    GOTO negative_number;
  ELSIF v_num = 0 THEN
    GOTO zero_number;
  ELSIF MOD(v_num, 2) = 0 THEN
    GOTO even_number;
  ELSE
    GOTO odd_number;
  END IF;

  <<negative_number>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is a NEGATIVE number.');
  GOTO end_program;

  <<zero_number>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is ZERO.');
  GOTO end_program;

  <<even_number>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is a POSITIVE EVEN number.');
  GOTO end_program;

  <<odd_number>>
  DBMS_OUTPUT.PUT_LINE(v_num || ' is a POSITIVE ODD number.');

  <<end_program>>
  DBMS_OUTPUT.PUT_LINE('Classification complete.');
END;
/
