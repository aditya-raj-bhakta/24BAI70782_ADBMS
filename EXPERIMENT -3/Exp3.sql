--A.
CREATE TABLE Employee
(
    EID INT PRIMARY KEY,
    DEPT VARCHAR(10),
    SCORES DECIMAL(5,2)
);

INSERT INTO Employee (EID, DEPT, SCORES)
VALUES
(1, 'D1', 1.00),
(2, 'D1', 5.28),
(3, 'D1', 4.00),
(4, 'D2', 8.00),
(5, 'D1', 2.50),
(6, 'D2', 7.00),
(7, 'D3', 9.00),
(8, 'D4', 10.20);


--SOLUTION (A)
UPDATE EMPLOYEE AS E 
SET SCORES = 
(
SELECT MAX(SCORES)
FROM EMPLOYEE 
WHERE DEPT = E.DEPT
);





--B:

CREATE TABLE SalesPerson
(
    seller_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission INT
);

CREATE TABLE Company
(
    com_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders
(
    order_id INT PRIMARY KEY,
    order_date DATE,
    com_id INT,
    seller_id INT,
    amount INT,
    FOREIGN KEY (com_id)
        REFERENCES Company(com_id),
    FOREIGN KEY (seller_id)
        REFERENCES SalesPerson(seller_id)
);

INSERT INTO SalesPerson
VALUES
(1,'John','New York',15),
(2,'Amy','Los Angeles',13),
(3,'Mark','Chicago',12),
(4,'Pam','Boston',15);

INSERT INTO Company
VALUES
(1,'RED','Boston'),
(2,'ORANGE','New York'),
(3,'YELLOW','Boston'),
(4,'GREEN','Austin');+

INSERT INTO Orders
VALUES
(1,'2024-01-10',1,1,1200),
(2,'2024-01-12',2,1,800),
(3,'2024-01-15',3,2,2500),
(4,'2024-01-18',1,3,1500),
(5,'2024-01-22',4,2,700),
(6,'2024-01-25',2,3,2000),
(7,'2024-01-28',3,4,3000),
(8,'2024-01-30',4,4,200);


--SOLUTION (B)
SELECT SELLER_ID 
FROM ORDERS
GROUP BY SELLER_ID
HAVING SUM(AMOUNT) = 

(
SELECT MAX(MAX_AMT)
FROM
(
SELECT SELLER_ID, SUM(AMOUNT) AS MAX_AMT
FROM ORDERS
GROUP BY SELLER_ID
)
)





--C.


CREATE TABLE Department
(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO Department (id, name)
VALUES
(1, 'IT'),
(2, 'Sales');



CREATE TABLE Employee
(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId)
    REFERENCES Department(id)
);

INSERT INTO Employee (id, name, salary, departmentId)
VALUES
(1, 'Joe',   85000, 1),
(2, 'Henry', 80000, 2),
(3, 'Sam',   60000, 2),
(4, 'Max',   90000, 1),
(5, 'Janet', 69000, 1),
(6, 'Randy', 85000, 1),
(7, 'Will',  70000, 1);




--SOLUTION (C)

SELECT
	D.NAME AS DEPARTMENT, 
	E.NAME AS EMPLOYEE,
	E.SALARY AS SALARY
FROM 
EMPLOYEE AS E
JOIN 
DEPARTMENT AS D 
ON 
E.departmentId = D.ID 
WHERE 
(
	SELECT COUNT(DISTINCT E2.SALARY)
	FROM EMPLOYEE AS E2
	WHERE E2.departmentId = E.departmentId
	AND 
	E2.SALARY > E.SALARY
) < 3
ORDER BY D.NAME;
