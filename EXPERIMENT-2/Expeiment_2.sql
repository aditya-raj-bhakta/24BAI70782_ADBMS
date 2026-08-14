--A.

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    dept_id INT REFERENCES Departments(dept_id)
);

CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL
);

CREATE TABLE Marks (
    student_id INT REFERENCES Students(student_id),
    subject_id INT REFERENCES Subjects(subject_id),
    marks_scored INT NOT NULL,
    PRIMARY KEY (student_id, subject_id)
);


INSERT INTO Departments (dept_id, dept_name) VALUES 
(1, 'Computer Science'),
(2, 'Mathematics');

INSERT INTO Students (student_id, student_name, dept_id) VALUES 
(101, 'Alex', 1),
(102, 'Bella', 1),
(103, 'Charlie', 2);

INSERT INTO Subjects (subject_id, subject_name) VALUES 
(501, 'Data Structures'),
(502, 'Calculus');

INSERT INTO Marks (student_id, subject_id, marks_scored) VALUES 
(101, 501, 85),
(101, 502, 90),
(102, 501, 75),
(103, 502, 95);


--SOLUTION 
SELECT 
		D.DEPT_NAME	AS DEPARTMENT,
		AVG(M.MARK_SCORED) AS 'AVERAGE MARKS'
FROM 
DEPARTMENT AS D 
JOIN 
STUDENT AS S 
ON 
D.DEPT_ID = S.DEPT_ID 
JOIN 
MARKS AS M 
ON 
M.STUDENT_ID = S.STUDENT_ID
GROUP BY D.DEPT_NAME
ORDER BY 'AVERAGE MARKS' DESC;


-- --------------------------------------------------------------------

--B
CREATE TABLE A
(
    EmpID INT,
    Ename VARCHAR(50),
    Salary INT
);

-- Create Table B
CREATE TABLE B
(
    EmpID INT,
    Ename VARCHAR(50),
    Salary INT
);

INSERT INTO A (EmpID, Ename, Salary)
VALUES
(1, 'AA', 1000),
(2, 'BB', 300);

INSERT INTO B (EmpID, Ename, Salary)
VALUES
(2, 'BB', 400),
(3, 'CC', 100);

SELECT EMPID,
	   MIN(ENAME),
	   MIN(SALARY)
FROM (
	SELECT *FROM A 
	UNION ALL 
	SELECT *FROM B 
	) AS INTERMEDIATE_RESULT 
GROUP BY EMPID;

-- --------------------------------------------------------

--C. 
CREATE TABLE Department
(
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employee
(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY(department_id)
    REFERENCES Department(id)
);

INSERT INTO Department
VALUES
(1,'IT'),
(2,'SALES');

INSERT INTO Employee
VALUES
(1,'JOE',70000,1),
(2,'JIM',90000,1),
(3,'HENRY',80000,2),
(4,'SAM',60000,2),
(5,'MAX',90000,1);




SELECT E.NAME,
	   E.SALARY,
	   D.DEPT_NAME
FROM 
EMPLOYEE AS E 
JOIN 
DEPARTMENT AS D 
ON 							
E.department_id = D.ID
WHERE E.SALARY IN 
(
	SELECT MAX(E1.SALARY) 
	FROM EMPLOYEE AS E1
	WHERE E1.department_id = E.department_id
);
