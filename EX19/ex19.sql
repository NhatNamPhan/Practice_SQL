--DROP TABLE IF EXISTS employees_ex19;

CREATE TABLE employees_ex19 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees_ex19 VALUES
(1, 'CEO', NULL),
(2, 'CTO', 1),
(3, 'CFO', 1),
(4, 'Dev Manager', 2),
(5, 'Developer A', 4),
(6, 'Developer B', 4),
(7, 'Accountant', 3);


SELECT * FROM employees_ex19;


1. Show the full organization hierarchy, including each employee’s level in the hierarchy (CEO = level 1).
WITH RECURSIVE org_hierarchy AS (
	SELECT 
		employee_id,
		employee_name,
		manager_id, 
		1 AS level
	FROM employees_ex19
	WHERE manager_id IS NULL
	UNION ALL
	SELECT
		e.employee_id,
		e.employee_name,
		e.manager_id,
		oh.level + 1
	FROM employees_ex19 e
	INNER JOIN org_hierarchy oh ON oh.employee_id = e.manager_id
)
SELECT
	employee_id,
	employee_name,
	manager_id,
	level
FROM org_hierarchy
ORDER BY level, employee_id;

2. List all subordinates of the CTO, including both direct and indirect subordinates.
WITH RECURSIVE org_hierarchy_CTO AS (
	SELECT 
		employee_id,
		employee_name,
		manager_id, 
		1 AS level
	FROM employees_ex19
	WHERE employee_name = 'CTO'
	UNION ALL
	SELECT
		e.employee_id,
		e.employee_name,
		e.manager_id,
		oh.level + 1
	FROM employees_ex19 e
	INNER JOIN org_hierarchy_CTO oh ON oh.employee_id = e.manager_id
)
SELECT
	employee_id,
	employee_name,
	manager_id,
	level
FROM org_hierarchy_CTO
ORDER BY level, employee_id;

3. Show the management chain for Developer A, starting from Developer A up to the CEO.
WITH RECURSIVE managerment_chain AS (
	SELECT 
		employee_id,
		employee_name,
		manager_id, 
		1 AS level
	FROM employees_ex19
	WHERE employee_name = 'Developer A'
	UNION ALL
	SELECT
		e.employee_id,
		e.employee_name,
		e.manager_id,
		mc.level + 1
	FROM employees_ex19 e
	INNER JOIN managerment_chain mc ON mc.manager_id = e.employee_id
)
SELECT
	employee_id,
	employee_name,
	manager_id,
	level
FROM managerment_chain
ORDER BY level;

4. Count how many employees report under each manager, including indirect subordinates.
WITH RECURSIVE all_subordinates AS (
	SELECT 
		employee_id AS manager_id,
		employee_name AS manager_name,
		employee_id AS subordinate_id
	FROM employees_ex19
	UNION ALL
	SELECT
		asub.manager_id,
		asub.manager_name,
		e.employee_id
	FROM employees_ex19 e
	INNER JOIN all_subordinates asub ON asub.subordinate_id = e.manager_id
)
SELECT 
	manager_id,
	manager_name,
	COUNT(*) - 1 AS total_subordinates  
FROM all_subordinates
WHERE manager_id IN (SELECT DISTINCT manager_id FROM employees_ex19 WHERE manager_id IS NOT NULL)
GROUP BY manager_id, manager_name
ORDER BY manager_id;

5. Display the organization hierarchy as a readable path
(example: CEO > CTO > Dev Manager > Developer A).
WITH RECURSIVE hierarchy_path AS (
	SELECT 
		employee_id,
		employee_name,
		manager_id,
		CAST(employee_name AS VARCHAR(500)) AS path,
		1 AS level
	FROM employees_ex19
	WHERE manager_id IS NULL
	UNION ALL
	SELECT 
		e.employee_id,
		e.employee_name,
		e.manager_id,
		CAST(hp.path || ' > ' || e.employee_name AS VARCHAR(500)) AS path,
		hp.level + 1
	FROM employees_ex19 e
	INNER JOIN hierarchy_path hp ON e.manager_id = hp.employee_id
)
SELECT 
	employee_id,
	employee_name,
	path AS hierarchy_path,
	level
FROM hierarchy_path
ORDER BY level, employee_id;
