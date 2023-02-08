
---------------------------------------------------Employee Table ----------------------------------------------------------------------

Create Table CompanyEmployee(
emp_id INT PRIMARY KEY,
first_name VARCHAR (40),
last_name VARCHAR (40),
birth_date DATE,
sex VARCHAR (1),
salary INT,
super_id INT,
branch_id INT
);

---------------------------------------------------Company Branch table and setting up foreign key----------------------------------------------------------------------


Create Table CompanyBranch(
branch_id INT PRIMARY KEY,
branch_name VARCHAR (40),
mgr_id INT,
mgr_start_date DATE, 
FOREIGN KEY(mgr_id) REFERENCES CompanyEmployee(emp_id) on delete set null
);

ALTER TABLE CompanyEmployee 
ADD FOREIGN KEY(branch_id)
REFERENCES CompanyBranch(branch_id) on delete set null;

ALTER TABLE CompanyEmployee 
ADD FOREIGN KEY(super_id)
REFERENCES CompanyEmployee(emp_id) on delete set null;

---------------------------------------------------Company Client table and setting up foreing key ----------------------------------------------------------------------

CREATE TABLE CompanyClient(
client_id INT PRIMARY KEY,
client_name VARCHAR (40),
branch_id INT, 
FOREIGN KEY(branch_id) REFERENCES CompanyClient(client_id) On delete cascade
);


ALTER TABLE CompanyClient DROP FOREIGN KEY companyclient_ibfk_1;
ALTER TABLE CompanyClient ADD FOREIGN KEY (branch_id) REFERENCES CompanyClient(client_id) On delete set null;


---------------------------------------------------Company Work With table and setting up foreing key ----------------------------------------------------------------------


CREATE TABLE Company_works_with (
emp_id INT,
client_id INT,
total_sales INT,
PRIMARY KEY(emp_id, client_id),
FOREIGN KEY(client_id) REFERENCES CompanyClient(client_id) on delete cascade 
);

---------------------------------------------------Company Branch Supplier table and setting up foreing key ----------------------------------------------------------------------

CREATE TABLE Company_branch_supplier(
branch_id INT,
supplier_name VARCHAR (40),
supply_type VARCHAR (40),
PRIMARY KEY(branch_id, supplier_name),
FOREIGN KEY(branch_id) REFERENCES CompanyBranch(branch_id) on delete cascade
);

SELECT* 
FROM Company_branch_supplier;

INSERT INTO CompanyEmployee Values (100, 'Ross', 'Meeker', '1967-11-17', 'M', 250000, null, null);
INSERT INTO CompanyBranch values(1, 'Corporate', 100, '2006-02-09' );

update CompanyEmployee
set branch_id = 1
where emp_id = 100;

---------------------------------------------------Populating Employee Table ----------------------------------------------------------------------

INSERT INTO CompanyEmployee values (101, 'Carrie', 'Rapp', '1961-05-11', 'F', 110000, 100, 1);
INSERT INTO CompanyEmployee values (102, 'Eddie', 'Cordek', '1964-03-15', 'M', 75000, 100, null); 
INSERT INTO CompanyBranch values (2, 'Maxwell', 102, '1992-04-06');

update CompanyEmployee
set branch_id = 2
where emp_id = 102;

INSERT INTO CompanyEmployee values (103, 'Laura', 'Rader', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO CompanyEmployee values (104, 'Amy', 'Kline', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO CompanyEmployee values (105, 'Scott', 'Swift', '1958-02-19', 'M', 69000, 102, 2);
INSERT INTO CompanyEmployee values (106, 'Josh', 'Peltier', '1969-09-05', 'M', 78000, 100, null);


INSERT INTO CompanyBranch values (3, 'Hudson', 106, '1998-02-13');

Update employee
set branch_id = 3
where emp_id =106;

INSERT INTO CompanyBranch values (3, 'Hudson', 106, '1998-02-13');

INSERT INTO CompanyEmployee values (107, 'Joey', 'Klair', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO CompanyEmployee values (108, 'James', 'Michael', '1978-10-01', 'M', 71000, 106, 3);

-------------------------------------------------- Populating Branch Supplier Table ---------------------------------------------------------------

INSERT INTO Company_Branch_Supplier values (2, 'Rockford Mill', 'Paper');
INSERT INTO Company_Branch_Supplier values (2, 'Dwell', 'Writing Utensils');
INSERT INTO Company_Branch_Supplier values (3, 'Queen Paper', 'Paper');
INSERT INTO Company_Branch_Supplier values (2, 'K.J. Forms & Labels', 'Customer Forms');
INSERT INTO Company_Branch_Supplier values (3, 'Dwell', 'Writing Utensils');
INSERT INTO Company_Branch_Supplier values (3, 'Rockford Mill', 'Paper');
INSERT INTO Company_Branch_Supplier values (3, 'Hudson Labels', 'Customer Forms');

----------------------------------------------------- Populating Company Client Table --------------------------------------------------------------
INSERT INTO CompanyClient values (400, 'Centennial Highschool', 2); 
INSERT INTO CompanyClient values (401, 'Calumet Country', 2); 
INSERT INTO CompanyClient values (402, 'FedEx', 3); 
INSERT INTO CompanyClient values (403, 'David Daly Law, LLC', 3); 
INSERT INTO CompanyClient values (404, 'Lipton Whitepages', 2); 
INSERT INTO CompanyClient values (405, 'Columbus Newspaper', 3); 
INSERT INTO CompanyClient values (406, 'FedEx', 2); 

---------------------------------------------------- Populating Company Client Table ---------------------------------------------------------------
INSERT INTO Company_works_with values (105, 400, 55000); 
INSERT INTO Company_works_with values (102, 401, 22500); 
INSERT INTO Company_works_with values (108, 402, 5000); 
INSERT INTO Company_works_with values (107, 403, 12000); 
INSERT INTO Company_works_with values (105, 404, 33000); 
INSERT INTO Company_works_with values (107, 405, 26000); 
INSERT INTO Company_works_with values (102, 406, 15000); 
INSERT INTO Company_works_with values (105, 406, 130000); 

Select * 
From CompanyClient;


