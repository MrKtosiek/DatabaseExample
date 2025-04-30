USE population_db;
GO

CREATE TABLE Person (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Father INT NULL,
	Mother INT NULL,
	Spouse INT NULL,
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	BirthDate DATE NOT NULL CHECK (YEAR(BirthDate) >= 1900),
	Sex CHAR(1) NOT NULL CHECK (Sex IN ('M', 'F')),
	Salary MONEY NOT NULL CHECK (Salary >= 0),
	
	CONSTRAINT FK_Person_Father FOREIGN KEY (Father) REFERENCES Person(Id),
	CONSTRAINT FK_Person_Mother FOREIGN KEY (Mother) REFERENCES Person(Id),
	CONSTRAINT FK_Person_Spouse FOREIGN KEY (Spouse) REFERENCES Person(Id)
);

CREATE TABLE Company (
	Id INT PRIMARY KEY IDENTITY(1,1),
	President INT NOT NULL,
	Name VARCHAR(100) NOT NULL,
	
	CONSTRAINT FK_Company_President FOREIGN KEY (President) REFERENCES Person(Id)
);

CREATE TABLE Employment (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Employee INT NOT NULL,
	Company INT NOT NULL,
	Type VARCHAR(20) NOT NULL CHECK (Type IN ('zlecenie', 'o_prace')),
	
	CONSTRAINT FK_Employment_Employee FOREIGN KEY (Employee) REFERENCES Person(Id),
	CONSTRAINT FK_Employment_Company FOREIGN KEY (Company) REFERENCES Company(Id)
);



-- Example Data

INSERT INTO Person (FirstName, LastName, BirthDate, Sex, Salary)
VALUES
('Jan', 'Kowalski', '1965-05-10', 'M', 8000),		-- id = 1
('Anna', 'Kowalska', '1968-07-12', 'F', 7200),		-- id = 2
('Tomasz', 'Kowalski', '1990-03-15', 'M', 5500),	-- id = 3
('Maria', 'Nowak', '1992-09-20', 'F', 5300),		-- id = 4
('Zofia', 'Kowalska', '2015-06-01', 'F', 0),		-- id = 5

('Piotr', 'Zieliñski', '1970-08-10', 'M', 6000),	-- id = 6
('Magda', 'Zieliñska', '1973-02-20', 'F', 6100),	-- id = 7
('Karolina', 'Zieliñska', '1995-12-12', 'F', 4000),	-- id = 8
('£ukasz', 'Zieliñski', '1993-11-11', 'M', 4100),	-- id = 9
('Jagoda', 'Zieliñska', '2020-05-05', 'F', 0),		-- id = 10

('Adam', 'Nowak', '1940-02-20', 'M', 4000),			-- id = 11
('Ewa', 'Nowak', '1942-11-30', 'F', 3900);			-- id = 12

UPDATE Person SET Spouse = 2 WHERE Id = 1;
UPDATE Person SET Spouse = 1 WHERE Id = 2;

UPDATE Person SET Spouse = 4, Father = 1, Mother = 2 WHERE Id = 3;
UPDATE Person SET Spouse = 3, Father = 11, Mother = 12 WHERE Id = 4;

UPDATE Person SET Father = 3, Mother = 4 WHERE Id = 5;

UPDATE Person SET Spouse = 7 WHERE Id = 6;
UPDATE Person SET Spouse = 6, Father = 9 WHERE Id = 7;

UPDATE Person SET Father = 6, Mother = 7 WHERE Id = 8;
UPDATE Person SET Father = 6, Mother = 7 WHERE Id = 10;


INSERT INTO Company (Name, President)
VALUES
('TechCorp', 1),		-- id = 1
('BizSolutions', 11),	-- id = 2
('GreenTech', 6),		-- id = 3
('BuildIT', 9);			-- id = 4


INSERT INTO Employment (Employee, Company, Type)
VALUES
(2, 1, 'zlecenie'),		-- Anna w TechCorp
(3, 1, 'o_prace'),		-- Tomasz w TechCorp
(3, 2, 'zlecenie'),		-- Tomasz w BizSolutions
(4, 2, 'o_prace'),		-- Maria w BizSolutions
(7, 3, 'o_prace'),		-- Magda w GreenTech
(8, 2, 'zlecenie'),		-- Karolina w GreenTech
(9, 4, 'o_prace');		-- £ukasz w BuildIT
