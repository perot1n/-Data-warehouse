
SELECT Warehouses.city, SUM(ProductTypes.price * Avaliability.quantity) AS total_value
FROM Warehouses
    INNER JOIN Avaliability ON Avaliability.id_warehouse = id.warehouse
    INNER JOIN ProductTypes ON ProductTypes.id = Avaliability.ProductTypes_id
WHERE Avaliability.date >= '2020-01-01' AND Avaliability.date <= '2020-03-31'
GROUP BY id.warehouse;



SELECT Warehouses.city, AVG(daily_total.total_value) AS average_daily_value
FROM Warehouses
    INNER JOIN (
  SELECT Avaliability.id_warehouse, SUM(ProductTypes.price * Avaliability.quantity) AS total_value
    FROM Avaliability
        INNER JOIN ProductTypes ON ProductTypes.id = Avaliability.id_warehouse
    WHERE Avaliability.date >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    GROUP BY Avaliability.id_warehouse, Avaliability.date
) AS daily_total ON daily_total.id_warehouse = id.warehouse
GROUP BY id.warehouse;



SELECT 
  city, 
  date, 
  (free_area / square) * 100 AS free_area_percentage, 
  DENSE_RANK() OVER (PARTITION BY date ORDER BY (free_area / square) ASC) AS rank
FROM 
  Warehouses 
  INNER JOIN Avaliability ON 1=1 
WHERE 
  date BETWEEN '2021-01-01' AND '2021-12-31'
ORDER BY 
  date ASC, 
  free_area_percentage ASC;



  SELECT 
  id, 
  city, 
  date, 
  (free_area / square) * 100 AS free_area_percentage
FROM 
  Warehouses 
WHERE 
  date BETWEEN '2021-01-01' AND '2021-06-30'
ORDER BY 
  date ASC;



  SELECT 
  id.warehouses AS id_warehouse, 
  Warehouses.city, 
  DATE_TRUNC('month', ProductTypes.date) AS month, 
  AVG(ProductTypes.price * ProductTypes.quantity) AS average_daily_value
FROM 
  warehouses 
JOIN 
  ProductTypes 
ON 
  id.warehouses = ProductTypes.id_warehouse 
WHERE 
  EXTRACT(YEAR FROM ProductTypes.date) = 2020 
GROUP BY 
  id.warehouses, warehouses.city, month
ORDER BY 
  id_warehouse, month ASC;


  SELECT region, AVG(price) AS average_daily_cost
FROM Region
WHERE year = 2020
GROUP BY region;


SELECT region, MONTH(date) as month, AVG(free_space_percentage) as avg_free_space_percentage
FROM  Warehouses
WHERE YEAR(date) = 2021
GROUP BY region, MONTH(date);