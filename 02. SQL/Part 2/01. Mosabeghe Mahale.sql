-- Section1

SELECT
	temp.p_title,
	temp.c_title 
FROM
	(
	SELECT
		p.title AS p_title,
		c.title AS c_title,
		COUNT( p.title ) AS `count` 
	FROM
		problems p JOIN submissions s ON p.id = s.problem_id JOIN contests c ON p.contest_id = c.id 
	GROUP BY
		p.id 
	ORDER BY
		`count` DESC,
		p_title, c_title ASC 
	) AS temp

-- Section2

SELECT
	c.title AS title,
	COUNT( DISTINCT u.id ) AS amount 
FROM
	contests c JOIN problems p ON c.id = p.contest_id JOIN submissions s ON p.id = s.problem_id JOIN users u ON s.user_id = u.id 
GROUP BY
	c.id 
ORDER BY
	amount DESC,
	title ASC

-- Section3

SELECT
	temp.user_name AS `name`,
	SUM( temp.score ) AS score 
FROM
	(
	SELECT
		u.`name` AS user_name,
		MAX( s.score ) AS score 
	FROM
		contests c JOIN problems p ON c.id = p.contest_id JOIN submissions s ON p.id = s.problem_id JOIN users u ON s.user_id = u.id 
	WHERE
		c.title = 'mahale' 
	GROUP BY
		p.id,
		u.id 
	) AS temp 
GROUP BY
	`name` 
ORDER BY
	score DESC,
	`name` ASC

-- Section4

SELECT
	temp.user_name AS `name`,
	COALESCE ( SUM( temp.score ), 0 ) AS score 
FROM
	(
	SELECT
		u.`name` AS user_name,
		MAX( s.score ) AS score 
	FROM
		contests c JOIN problems p ON c.id = p.contest_id JOIN submissions s ON p.id = s.problem_id RIGHT JOIN users u ON s.user_id = u.id 
	GROUP BY
		p.id,
		u.id 
	) AS temp 
GROUP BY
	temp.user_name 
ORDER BY
	score DESC,
	user_name ASC

-- Section5

UPDATE contests
SET title = 'Mosabeghe Mahale'
WHERE title = 'mahale'

-- Section6

DELETE
FROM
	contests 
WHERE
	id NOT IN (
		SELECT DISTINCT
			p.contest_id 
		FROM
			problems p JOIN submissions s ON p.id = s.problem_id)
