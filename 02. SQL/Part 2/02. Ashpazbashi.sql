-- Section1

UPDATE foods
SET recipe = REPLACE(recipe, '@hamid_ashpazbashi2', '@hamid_ashpazbashi')

-- Section2

SELECT
	f.id,
	f.`name`,
	COALESCE ( AVG( r.rate ), 0 ) AS rating,
	COUNT( r.rate ) AS rate_count 
FROM
	ratings r RIGHT JOIN foods f ON r.food_id = f.id 
GROUP BY
	f.id 
ORDER BY
	rating DESC,
	rate_count DESC,
	f.id DESC 
	LIMIT 10

-- Section3

SELECT
	f.id,
	f.`name`,
	f.recipe,
	COALESCE ( total_price, 0 ) AS total_price 
FROM
	(
	SELECT
		temp1.`name`,
		SUM( temp1.price_per_food ) AS total_price 
	FROM
		(
		SELECT
			f.`name`,
			fi.amount * i.price_per_unit AS price_per_food 
		FROM
			foods f JOIN food_ingredients fi ON f.id = fi.food_id JOIN ingredients i ON fi.ingredient_id = i.id 
		) AS temp1 
	GROUP BY
		temp1.`name` 
	) AS temp2
	RIGHT JOIN foods f ON temp2.`name` = f.`name` 
ORDER BY
	f.id

-- Section4

SELECT
	temp.food_id AS id 
FROM
	(
	SELECT
		fi.food_id,
		MIN( ui.amount - fi.amount ) AS required 
	FROM
		user_ingredients ui JOIN food_ingredients fi ON ui.ingredient_id = fi.ingredient_id JOIN users u ON ui.user_id = u.id 
	WHERE
		u.username = 'quera' 
	GROUP BY
		fi.food_id 
	) AS temp 
WHERE
	temp.required >= 0 
ORDER BY
	temp.food_id DESC
