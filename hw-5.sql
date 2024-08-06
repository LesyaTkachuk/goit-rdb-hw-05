use mydb;

-- nested queries 
SELECT *, (SELECT customer_id FROM orders 
WHERE order_details.order_id=id ) as customer_id FROM order_details;


SELECT * FROM order_details od
JOIN orders o ON od.order_id=o.id
WHERE order_id IN (SELECT id  FROM orders WHERE shipper_id =3);

SELECT order_id, AVG(quantity) AS avg_quantity 
FROM (SELECT * FROM order_details WHERE quantity>10) as temp_table
GROUP BY order_id;

WITH temp AS (SELECT * FROM order_details WHERE quantity>10)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

-- function creation
DROP FUNCTION IF EXISTS DivideQuantity;

DELIMITER //

CREATE FUNCTION DivideQuantity(quantity FLOAT, number FLOAT) 
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result = quantity / number;
    RETURN result;
END //

DELIMITER ;

SELECT id, DivideQuantity(quantity, 2) as half_quantity FROM order_details;
