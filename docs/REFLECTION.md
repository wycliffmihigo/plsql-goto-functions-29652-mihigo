# C2: Reflection

## 1. What is GOTO and when is it justified?

GOTO is a PL/SQL statement that makes the program jump directly to a label written as `<<label_name>>`
in the same block or an enclosing block. Instead of running line by line, execution continues from the
label. In this project I used it in A1 to jump to the correct classification message, in A2 to jump to the
correct raise percentage, and in `fn_validate_payroll` to jump to one single exit point when a check fails.

GOTO can be justified when there are many checks and I want to stop at the first failure and leave through
one exit point, as in the payroll validator. In most other cases structured code (IF, CASE, loops) is
better, because jumping around makes the program harder to read, test and change.

## 2. The illegal GOTO (A3)

In A3 I wrote a GOTO that jumped to a label inside an IF block. Oracle refused to compile it and gave the
error PLS-00375 (illegal GOTO statement). A GOTO can jump forward or backward within the same block, or
out to an enclosing block, but it can never jump into an IF, LOOP, CASE or inner block, or into an
exception handler. The jump would skip the condition that protects that code.

I fixed it by moving the label outside the IF block, to the same level as the GOTO statement. The jump
then goes to a label in the enclosing block, which is legal, and the program prints the expected message.

## 3. GOTO vs. structured code (A2 vs. A4)

A2 (with GOTO) and A4 (with IF / ELSIF / ELSE) give exactly the same output: for employee 4 (Jean
Niyonzima, salary 250,000) a 10% raise gives a proposed salary of 275,000.

The GOTO version is longer and I have to follow the labels to see what happens. The IF/ELSIF version
reads from top to bottom, so it is shorter, easier to understand, and easier to change if the salary
bands change. I prefer the structured version for this task. GOTO only felt useful for the single exit
point in the validator.

## 4. Functions

A function is a stored, named PL/SQL program that must return one value. Unlike an anonymous block, it is
saved in the database, can be reused many times, and can be called inside SQL statements. In B5 I used my
functions inside SELECT, WHERE and ORDER BY, for example `fn_calculate_tax(monthly_salary)` and
`fn_dept_name(dept_id)`. This showed me how functions let me reuse business logic (tax rules, years of
service) in queries without repeating the formulas.

I used exception handling in each function. B1, B2 and B4 handle `NO_DATA_FOUND`: B1 and B2 return NULL
when an employee does not exist, and B4 returns 'Unknown Department'. B3 raises a custom error
