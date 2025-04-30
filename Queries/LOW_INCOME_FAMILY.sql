USE population_db;
GO

WITH TwoGenFamily AS (
	-- Main couple
	SELECT 
		p.Id AS FamilyRootId,
		p.Id AS PersonId,
		p.Salary
	FROM Person p
	WHERE EXISTS (
		SELECT 1 FROM Person c WHERE c.Father = p.Id OR c.Mother = p.Id
	) -- the person has children
	
	UNION
	
	SELECT 
		p.Id AS FamilyRootId,
		s.Id AS PersonId,
		s.Salary
	FROM Person p
	JOIN Person s ON p.Spouse = s.Id
	WHERE EXISTS (
		SELECT 1 FROM Person c WHERE c.Father = p.Id OR c.Mother = p.Id
	) -- the spouse of this person has children
	
	-- Children and their spouses
	UNION
	
	SELECT 
		p.Id AS FamilyRootId,
		c.Id AS PersonId,
		c.Salary
	FROM Person p
	JOIN Person c ON c.Father = p.Id OR c.Mother = p.Id
	
	UNION
	
	SELECT 
		p.Id AS FamilyRootId,
		s.Id AS PersonId,
		s.Salary
	FROM Person p
	JOIN Person c ON c.Father = p.Id OR c.Mother = p.Id
	JOIN Person s ON s.Id = c.Spouse
)

SELECT TOP 1 per.FirstName, per.LastName
FROM (
	SELECT FamilyRootId, SUM(Salary) AS TotalSalary
	FROM TwoGenFamily
	GROUP BY FamilyRootId
) AS Fam
JOIN Person per ON per.Id = Fam.FamilyRootId
ORDER BY TotalSalary ASC;
