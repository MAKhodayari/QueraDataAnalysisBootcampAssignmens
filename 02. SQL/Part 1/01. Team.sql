SELECT
	MAX( employees.salary ) AS 'max salary',
	MIN( employees.salary ) AS 'min salary',
	AVG( employees.salary ) AS 'avg salary' 
FROM
	employees