
---------------------------------------------------Find names of all employees who have sold over 50,000---------------------------------------

SELECT first_name, last_name AS employee_sold_over
FROM companyemployee AS a
INNER JOIN company_works_with AS b
ON a.emp_id = b.emp_id 
WHERE total_sales > 50000
ORDER BY first_name, last_name;

---------------------------------------------------Find all clients who handles by the branch that Eddie Cordek manages---------------------------------------

SELECT client_name, client_id
FROM companyclient AS a
INNER JOIN companybranch AS b
ON a.branch_id = b.branch_id
INNER JOIN companyemployee AS c
ON b.branch_id = c.branch_id
WHERE first_name = 'Eddie' AND last_name = 'Cordek'
;

---------------------------------------------------Find the names of employees who work with clients handled by the Maxwell ----------------------

SELECT first_name, last_name 
FROM companyemployee AS a 
INNER JOIN companyclient AS b
ON a.branch_id = b.branch_id
INNER JOIN companybranch AS c
ON b.branch_id = c.branch_id
WHERE branch_name = 'Maxwell'
;


---------------------------------------------------Find all the names of all clients who have spent more than 100,000 dollars --------------------
SELECT client_name
FROM companyclient AS a
INNER JOIN company_works_with AS b
ON a.client_id = b.client_id
WHERE total_sales > 100000;

