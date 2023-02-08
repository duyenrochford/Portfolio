
----------------------find names of all employees who have sold over 50,000---------------------------------------

select first_name, last_name as employee_sold_over
from companyemployee as a
inner join company_works_with as b
on a.emp_id = b.emp_id 
where total_sales > 50000
order by first_name, last_name;

----------------------find all clients who handles by the branch that Eddie Cordek manages---------------------------------------

select client_name, client_id
from companyclient as a
inner join companybranch as b
on a.branch_id = b.branch_id
inner join companyemployee as c
on b.branch_id = c.branch_id
where first_name = 'Eddie' AND last_name = 'Cordek'
;

----------------------------find the names of employees who work with clients handled by the Maxwell ----------------------

select first_name, last_name 
from companyemployee as a 
inner join companyclient as b
on a.branch_id = b.branch_id
inner join companybranch as c
on b.branch_id = c.branch_id
where branch_name = 'Maxwell'
;


-------------------------------find all the names of all clients who have spent more than 100,000 dollars --------------------
select client_name
from companyclient as a
inner join company_works_with as b
on a.client_id = b.client_id
where total_sales > 100000;

