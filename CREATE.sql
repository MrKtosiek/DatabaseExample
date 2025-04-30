USE population_db;
GO

CREATE TABLE Person (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Father INT NULL,
    Mother INT NULL,
    Spouse INT NULL UNIQUE,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    BirthDate DATE NOT NULL CHECK (YEAR(BirthDate) > 1900),
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
('Jan', 'Kowalski', '1965-05-10', 'M', 8000), -- id = 1
('Anna', 'Kowalska', '1968-07-12', 'F', 7200), -- id = 2
('Tomasz', 'Kowalski', '1990-03-15', 'M', 5500), -- id = 3
('Maria', 'Nowak', '1992-09-20', 'F', 5300), -- id = 4
('Zofia', 'Kowalska', '2015-06-01', 'F', 0), -- id = 5
('Adam', 'Nowak', '1940-02-20', 'M', 4000), -- id = 6
('Ewa', 'Nowak', '1942-11-30', 'F', 3900); -- id = 7

UPDATE Person SET Spouse = 2 WHERE Id = 1;
UPDATE Person SET Spouse = 1 WHERE Id = 2;

UPDATE Person SET Father = 1, Mother = 2, Spouse = 4 WHERE Id = 3;
UPDATE Person SET Father = 6, Mother = 7, Spouse = 3 WHERE Id = 4;

UPDATE Person SET Father = 3, Mother = 4 WHERE Id = 5;


INSERT INTO Company (Name, President)
VALUES
('TechCorp', 1), -- id = 1
('BizSolutions', 6); -- id = 2


INSERT INTO Employment (Employee, Company, Type)
VALUES
(1, 1, 'o_prace'),  -- Jan in TechCorp
(2, 1, 'zlecenie'), -- Anna in TechCorp
(3, 1, 'o_prace'),  -- Tomasz in TechCorp
(3, 2, 'zlecenie'), -- Tomasz in BizSolutions
(4, 2, 'o_prace'),  -- Maria in BizSolutions
(6, 2, 'o_prace');  -- Adam in BizSolutions
