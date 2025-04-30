USE population_db;
GO

SELECT TOP 1 p.FirstName, p.LastName, COUNT(DISTINCT Grandchild.Id) AS FemaleGrandchildren
FROM Person p
JOIN Person Child ON Child.Father = p.Id OR Child.Mother = p.Id
JOIN Person Grandchild ON Grandchild.Father = Child.Id OR Grandchild.Mother = Child.Id
WHERE Grandchild.Sex = 'F'
GROUP BY p.Id, p.FirstName, p.LastName
ORDER BY FemaleGrandchildren DESC;
