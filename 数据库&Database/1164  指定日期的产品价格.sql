SELECT  p1.product_id
       ,ifnull(p2.new_price,10) AS price
FROM
(
	SELECT  distinct product_id
	FROM products
) AS p1 -- 所有的产品 
LEFT JOIN
(
	SELECT  product_id
	       ,new_price
	FROM products
	WHERE (product_id, change_date) IN ( SELECT product_id, MAX(change_date) FROM products WHERE change_date <= '2019-08-16' GROUP BY product_id ) 
) AS p2 -- 在 2019-08-16 之前有过修改的产品和最新的价格 
ON p1.product_id = p2.product_id