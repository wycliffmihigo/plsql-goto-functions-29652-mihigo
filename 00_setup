-- Re-runnable: drop old tables if they exist
BEGIN
  FOR t IN (SELECT column_value AS tname
            FROM TABLE(sys.odcivarchar2list('PAYROLL','EMPLOYEES','DEPARTMENTS'))) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE ' || t.tname || ' CASCADE CONSTRAINTS PURGE';
    EXCEPTION WHEN OTHERS THEN NULL;
    END;
  END LOOP;
END;
/

CREATE TABLE departments (
  dept_id    NUMBER(4)     PRIMARY KEY,
  dept_name  VARCHAR2(50)  NOT NULL,
  location   VARCHAR2(50)
);

CREATE TABLE employees (
  emp_id          NUMBER(6)     PRIMARY KEY,
  first_name      VARCHAR2(40)  NOT NULL,
  last_name       VARCHAR2(40)  NOT NULL,
  dept_id         NUMBER(4)     REFERENCES departments(dept_id),
  hire_date       DATE          NOT NULL,
  monthly_salary  NUMBER(12,2)  NOT NULL CHECK (monthly_salary >= 0),
  status          VARCHAR2(10)  DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE','INACTIVE'))
);

CREATE TABLE payroll (
  payroll_id    NUMBER(8)     PRIMARY KEY,
  emp_id        NUMBER(6)     NOT NULL REFERENCES employees(emp_id),
  pay_month     DATE          NOT NULL,
  gross_salary  NUMBER(12,2)  NOT NULL,
  tax_amount    NUMBER(12,2)  NOT NULL,
  net_salary    NUMBER(12,2)  NOT NULL
);

INSERT INTO departments VALUES (10, 'Information Technology', 'Kigali');
INSERT INTO departments VALUES (20, 'Finance',                 'Kigali');
INSERT INTO departments VALUES (30, 'Human Resources',         'Huye');
INSERT INTO departments VALUES (40, 'Operations',              'Musanze');

INSERT INTO employees VALUES (1, 'Aline',   'Uwase',        10, DATE '2019-03-15', 850000, 'ACTIVE');
INSERT INTO employees VALUES (2, 'Eric',    'Habimana',     10, DATE '2021-07-01', 600000, 'ACTIVE');
INSERT INTO employees VALUES (3, 'Grace',   'Mukamana',     20, DATE '2018-01-10', 950000, 'ACTIVE');
INSERT INTO employees VALUES (4, 'Jean',    'Niyonzima',    20, DATE '2023-05-20', 250000, 'ACTIVE');
INSERT INTO employees VALUES (5, 'Diane',   'Ingabire',     30, DATE '2022-09-12', 180000, 'ACTIVE');
INSERT INTO employees VALUES (6, 'Patrick', 'Nsengiyumva',  30, DATE '2020-11-02',  90000, 'ACTIVE');
INSERT INTO employees VALUES (7, 'Sandrine','Uwimana',      40, DATE '2024-02-19',  55000, 'ACTIVE');
INSERT INTO employees VALUES (8, 'Claude',  'Mugisha',      40, DATE '2017-06-30', 400000, 'INACTIVE');

-- Rows 4, 8 and 9 are deliberately WRONG (used later to test the validator)
INSERT INTO payroll VALUES (1, 1, DATE '2026-09-01', 850000, 219000, 631000);
INSERT INTO payroll VALUES (2, 2, DATE '2026-09-01', 600000, 144000, 456000);
INSERT INTO payroll VALUES (3, 3, DATE '2026-09-01', 950000, 249000, 701000);
INSERT INTO payroll VALUES (4, 4, DATE '2026-09-01', 250000,  30000, 220000);
INSERT INTO payroll VALUES (5, 5, DATE '2026-09-01', 180000,  20000, 160000);
INSERT INTO payroll VALUES (6, 6, DATE '2026-09-01',  90000,   3000,  87000);
INSERT INTO payroll VALUES (7, 7, DATE '2026-09-01',  55000,      0,  55000);
INSERT INTO payroll VALUES (8, 8, DATE '2026-09-01', 400000,  84000, 316000);
INSERT INTO payroll VALUES (9, 5, DATE '2026-08-01', 180000,  20000, 150000);

COMMIT;

SELECT 'departments' AS tbl, COUNT(*) AS rows_loaded FROM departments
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'payroll',   COUNT(*) FROM payroll;
