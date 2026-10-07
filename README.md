# PL/SQL GOTO Statements and Functions: Payroll System

**Course:** Database Development with PL/SQL (INSY 8311)
**Student:** MIHIGO WYCLIFF | **ID:** 29652
**Assignment:** Individual Assignment III

## Project Idea
A small Payroll Management System for a company in Rwanda. It stores departments, employees and monthly
payroll records. The GOTO programs classify numbers and review salaries. The functions compute annual salary,
years of service, monthly PAYE tax and department names, and validate payroll records.

## Database Design
| Table | Purpose | Key columns |
|---|---|---|
| departments | Company departments | dept_id (PK), dept_name, location |
| employees | Staff | emp_id (PK), dept_id (FK), hire_date, monthly_salary, status |
| payroll | Monthly pay records | payroll_id (PK), emp_id (FK), gross_salary, tax_amount, net_salary |

## Task Index
| Task | File | Description |
|---|---|---|
| A1 | 01_goto/A1_number_classifier.sql | Classifies a number using GOTO |
| A2 | 01_goto/A2_salary_review.sql | Salary raise by band using GOTO |
| A3 | 01_goto/A3_illegal_goto.sql | Illegal GOTO into an IF block, and the fix |
| A4 | 01_goto/A4_rewrite_no_goto.sql | A2 rewritten with IF/ELSIF |
| B1 | 02_functions/B1_fn_annual_salary.sql | Monthly salary x 12 |
| B2 | 02_functions/B2_fn_years_of_service.sql | Completed years since hire |
| B3 | 02_functions/B3_fn_calculate_tax.sql | Progressive monthly PAYE tax |
| B4 | 02_functions/B4_fn_dept_name.sql | Department name lookup |
| B5 | 03_tests/B5_functions_in_select.sql | Functions used in SQL queries |
| C1 | 02_functions/C1_fn_validate_payroll.sql | Payroll validator |
| C2 | docs/REFLECTION.md | Reflection |

## Tax Brackets (B3, simplified, monthly, RWF)
| Salary | Rate |
|---|---|
| 0 to 60,000 | 0% |
| 60,001 to 100,000 | 10% |
| 100,001 to 200,000 | 20% |
| Above 200,000 | 30% |

## How to Run
1. Run `00_setup/create_tables.sql`.
2. Run the functions in `02_functions/` (B1, B2, B3, B4, then C1).
3. Run the programs in `01_goto/`.
4. Run the test files in `03_tests/`.
5. Compare results with the screenshots in `screenshots/`.

## Screenshots
| File | Shows |
|---|---|
| A1_output.png | Number classifier output |
| A2_output.png | Salary review output |
| A3_error_and_fix.png | Illegal GOTO error and the fixed version |
| A4_output.png | Rewrite without GOTO |
| B5_select_output.png | Functions used in SELECT |
| C1_output.png | Payroll validation results |

## Notes
- Tested on Oracle Database in SQL Developer, using a dedicated schema `payroll_user`.

