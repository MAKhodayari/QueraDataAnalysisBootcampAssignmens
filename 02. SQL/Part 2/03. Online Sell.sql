-- Section1

SELECT
	e.employeeNumber,
	CONCAT( e.firstName, ' ', e.lastName ) AS `Name`,
	COUNT( c.customerNumber ) AS CustomersCount 
FROM
	employees e JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber 
GROUP BY
	e.employeeNumber 
ORDER BY
	CustomersCount DESC,
	e.employeeNumber ASC

-- Section2

SELECT
	temp2.customerNumber 
FROM
	(
	SELECT
		temp.customerNumber,
		SUM( temp.fullPrice ) AS price 
	FROM
		(
		SELECT
			o.customerNumber,
			od.quantityOrdered,
			od.priceEach,
			od.quantityOrdered * od.priceEach AS fullPrice 
		FROM
			orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber 
		WHERE
			o.`status` != 'Cancelled' 
		) AS temp 
	GROUP BY
		temp.customerNumber 
	ORDER BY
		price DESC 
	LIMIT 5 
	) AS temp2

-- Section3

SELECT
	*,
	RANK() OVER ( PARTITION BY temp.productline ORDER BY temp.`value` DESC ) AS value_rank 
FROM
	(
	SELECT
		productLine AS productline,
		productName,
		( MSRP - buyPrice ) * quantityInStock AS `value`
	FROM
		products 
WHERE
	productLine IN ( SELECT DISTINCT productLine FROM productlines )) AS temp
