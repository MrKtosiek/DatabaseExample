USE population_db;
GO

SELECT e.Type, AVG(CAST(employee_count AS FLOAT)) AS AvgEmployeeCount, AVG(p.Salary) AS AvgSalary
FROM (
	SELECT
		c.Id AS CompanyId,
		e.Type,
		COUNT(DISTINCT e.Employee) AS employee_count
	FROM Company c
	JOIN Employment e ON c.Id = e.Company
	GROUP BY c.Id, e.Type
) AS CompanyStats
JOIN Employment e ON CompanyStats.CompanyId = e.Company AND CompanyStats.Type = e.Type
JOIN Person p ON p.Id = e.Employee
GROUP BY e.Type;
