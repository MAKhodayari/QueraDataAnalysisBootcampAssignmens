-- Section1

SELECT
	id AS 'order_id' 
FROM
	orders 
WHERE
	`status` = 'warehouse' 
ORDER BY
	id DESC

-- Section2

SELECT
	id AS 'customer_id',
	`name` AS 'customer_name' 
FROM
	customers 
WHERE
	id NOT IN ( SELECT c.id FROM orders o JOIN customers c WHERE o.customer_id = c.id ) 
ORDER BY
	`name` ASC

-- Section3

SELECT
	o.created_at AS 'date',
	FORMAT( AVG( o.`status` = 'canceled' ) * 100, 2 ) AS 'cancellation_rate' 
FROM
	orders o JOIN customers c ON o.customer_id = c.id 
WHERE
	( c.is_blocked = 0 OR c.is_blocked IS NULL ) 
GROUP BY
	o.created_at
