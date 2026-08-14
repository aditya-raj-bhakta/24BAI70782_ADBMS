
-- (A)
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    income INT
);

INSERT INTO Accounts (account_id, income) VALUES 
(3, 108939), 
(2, 12747),  
(8, 87709),  
(6, 91738),  
(7, 45169); 



SELECT
    'Low Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000


UNION ALL

SELECT
    'Average Salary' AS category,
    COUNT(*)
FROM Accounts
WHERE income BETWEEN 20000 AND 50000

UNION ALL

SELECT
    'High Salary' AS category,
    COUNT(*)
FROM Accounts
WHERE income > 50000;



--(B): 
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dept_id INT REFERENCES Departments(dept_id)
);

CREATE TABLE Salaries (
    emp_id INT PRIMARY KEY REFERENCES Employees(emp_id) ON DELETE CASCADE,
    salary INT NOT NULL
);


INSERT INTO Departments (dept_id, dept_name) VALUES 
(10, 'HR'), (20, 'IT'), (30, 'Sales');

INSERT INTO Employees (emp_id, name, dept_id) VALUES 
(1, 'Alice', 10), (2, 'Bob', 10), (3, 'Charlie', 20), (4, 'David', 20), (5, 'Emma', 30);

INSERT INTO Salaries (emp_id, salary) VALUES 
(1, 50000), (2, 25000), (3, 80000), (4, 40000), (5, 45000);


(i)
SELECT e.name, d.dept_name, s.salary
FROM Employees AS e
JOIN Departments AS d 
ON e.dept_id = d.dept_id
JOIN Salaries AS s 
ON e.emp_id = s.emp_id;

(ii)
UPDATE Salaries
SET salary = salary * 1.10
WHERE emp_id IN (
    SELECT e.emp_id 
	FROM Employees e 
    JOIN Departments d 
	ON 
	e.dept_id = d.dept_id 
	WHERE d.dept_name = 'HR'
);

(iii)
SELECT e.name, s.salary
FROM Employees AS e
JOIN Salaries AS s 
ON e.emp_id = s.emp_id
WHERE s.salary > (SELECT AVG(salary) FROM Salaries);


-- (C);
CREATE TABLE pizza_toppings (
    topping_name VARCHAR(50) PRIMARY KEY,
    ingredient_cost NUMERIC(4,2) NOT NULL
);


INSERT INTO pizza_toppings (topping_name, ingredient_cost) VALUES 
('Pepperoni', 0.50),
('Sausage', 0.70),
('Chicken', 0.55),
('Onions', 0.25),
('Extra Cheese', 0.40);
