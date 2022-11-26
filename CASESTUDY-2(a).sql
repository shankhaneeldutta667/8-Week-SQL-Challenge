USE PROBLEMS;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" INTEGER,
  "registration_date" DATE
);
INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INTEGER,
  "customer_id" INTEGER,
  "pizza_id" INTEGER,
  "exclusions" VARCHAR(4),
  "extras" VARCHAR(4),
  "order_time" TIMESTAMP
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" INTEGER,
  "runner_id" INTEGER,
  "pickup_time" VARCHAR(19),
  "distance" VARCHAR(7),
  "duration" VARCHAR(10),
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" INTEGER,
  "pizza_name" TEXT
);
INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INTEGER,
  "toppings" TEXT
);
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" INTEGER,
  "topping_name" TEXT
);
INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');

SELECT * FROM customer_orders;
SELECT * FROM PIZZA_NAMES;
SELECT * FROM PIZZA_RECIPES;
SELECT * FROM PIZZA_TOPPINGS;
SELECT * FROM RUNNER_ORDERS WHERE CANCELLATION=NULL;
SELECT * FROM RUNNERS;


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);
INSERT INTO runner_orders

VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');
  
  
SELECT * FROM RUNNER_ORDERS;

SELECT * FROM CUSTOMER_ORDERS;

/*
CREATE TEMPORARY TABLE TEMP_CUSTOMER_ORDERS(
	SELECT ORDER_ID,
		   CUSTOMER_ID,
           PIZZA_ID,
    (CASE
		WHEN EXCLUSIONS ='null' THEN ' ' ELSE EXCLUSIONS END) AS EXCLUSIONS,
    (CASE 
		WHEN EXTRAS IS NULL THEN ' '
        WHEN EXTRAS LIKE '%null%' then ' ' END ) AS EXTRAS,
	ORDER_TIME FROM CUSTOMER_ORDERS);

*/
/*
	CREATE TEMPORARY TABLE TEMP_RUNNER_ORDERS(
		SELECT ORDER_ID,
			   RUNNER_ID,
			   (CASE
					WHEN PICKUP_TIME LIKE '%null%' THEN '0000-00-00 00:00:00' END) AS PICKUP_TIME,
				( CASE
					WHEN DISTANCE LIKE '%null%' THEN 0
                    WHEN DISTANCE LIKE '%km%' THEN TRIM('km' FROM DISTANCE)
                    WHEN DISTANCE LIKE '% km%' THEN TRIM(' km' FROM DISTANCE) ELSE DISTANCE  END) AS DISTANCE,
                (CASE
					WHEN DURATION LIKE '%null%' THEN ' '
                    WHEN DURATION LIKE '% minutes%' THEN TRIM(' minutes'FROM DURATION)
                    WHEN DURATION LIKE '% minute%' THEN TRIM(' minute' FROM DURATION)
					WHEN DURATION LIKE '%minutes%' THEN TRIM('minutes' FROM DURATION)
					WHEN DURATION LIKE '% mins%' THEN TRIM(' mins' FROM DURATION)
					WHEN DURATION LIKE '%mins%' THEN TRIM('mins' FROM DURATION) END
				) AS DURATION,
                CASE(    
						WHEN CANCELLATION LIKE '%null%' THEN ' '
						WHEN DURATION IS NULL THEN ' '
						END) AS CANCELLATION
                        
			FROM RUNNER_ORDERS); 

*/
-- CLEANING TABLE RUNNER_ORDERS BY CREATING A TEMPORARY TABLE 

CREATE TEMPORARY TABLE TEMP_RUNNER_ORDERS(
SELECT  ORDER_ID,
		RUNNER_ID,
        (CASE 
        WHEN PICKUP_TIME LIKE '%null%' THEN '0000-00-00 00:00:00' ELSE PICKUP_TIME END) AS PICKUP_TIME,
		(CASE
        WHEN DISTANCE LIKE '%null%' THEN 0
        WHEN DISTANCE LIKE '%km%' THEN TRIM('km' FROM DISTANCE) ELSE DISTANCE END) AS DISTANCE,
        
        
        (CASE
		WHEN DURATION LIKE '%null%' THEN 0
        WHEN DURATION LIKE '% minutes%' THEN TRIM(' minutes' FROM DURATION)
		WHEN DURATION LIKE '%mins%' THEN TRIM('mins' FROM DURATION)
        WHEN DURATION LIKE '% mins%' THEN TRIM(' mins' FROM DURATION)
        WHEN DURATION LIKE '% minute%' THEN TRIM(' minute' FROM DURATION)
        WHEN DURATION LIKE '%minutes%' THEN TRIM('minutes' FROM DURATION) ELSE DURATION END) AS DURATION,
        
        
        (CASE
        WHEN  CANCELLATION IS NULL OR CANCELLATION LIKE '%null%' THEN ' ' ELSE CANCELLATION END) 
        AS CANCELLATION
		
        FROM RUNNER_ORDERS);

SELECT * FROM RUNNER_ORDERS;
SELECT * FROM TEMP_RUNNER_ORDERS;
DROP TABLE TEMP_RUNNER_ORDERS;

-- CLEANING CUSTOMER_ORDERS TABLE BY CREATING A TEMPORARY TABLE TEMP_CUSTOMER_ORDERS

SELECT * FROM CUSTOMER_ORDERS;
CREATE TEMPORARY TABLE TEMP_CUSTOMER_ORDERS(
	SELECT ORDER_ID,
		   CUSTOMER_ID,
           PIZZA_ID,
           (CASE WHEN EXCLUSIONS LIKE '%null%' THEN ' ' ELSE EXCLUSIONS END) AS EXCLUSIONS,
           (CASE WHEN EXTRAS LIKE '%null%' THEN ' '
				 WHEN EXTRAS IS NULL THEN ' ' ELSE EXTRAS END) AS EXTRAS,
			ORDER_TIME FROM CUSTOMER_ORDERS);

SELECT * FROM CUSTOMER_ORDERS;
SELECT * FROM TEMP_CUSTOMER_ORDERS;
DROP TABLE TEMP_CUSTOMER_ORDERS;

SELECT * FROM RUNNER_ORDERS;
SELECT * FROM TEMP_RUNNER_ORDERS;

ALTER TABLE temp_runner_orders
MODIFY COLUMN pickup_time DATETIME,
MODIFY COLUMN distance FLOAT,
MODIFY COLUMN duration INT;

--                                                 PIZZA METRICS

-- 1.  How many pizzas were ordered?
SELECT * FROM TEMP_CUSTOMER_ORDERS;

SELECT COUNT(PIZZA_ID) AS N_PIZZA FROM TEMP_CUSTOMER_ORDERS;
-- 14

-- 2.  How many unique customer orders were made?
SELECT COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS FROM TEMP_CUSTOMER_ORDERS;
-- 5

-- 3.  How many successful orders were delivered by each runner?
SELECT * FROM TEMP_RUNNER_ORDERS ORDER BY RUNNER_ID;

SELECT ORDER_ID, RUNNER_ID, COUNT(ORDER_ID) AS SUCCESSFUL_ORDERS
FROM TEMP_RUNNER_ORDERS WHERE TEMP_RUNNER_ORDERS.CANCELLATION
NOT IN ('Customer Cancellation','Restaurant Cancellation')
GROUP BY RUNNER_ID;

-- 4.  How many of each type of pizza was delivered?

SELECT * FROM TEMP_CUSTOMER_ORDERS ORDER BY PIZZA_ID;
SELECT * FROM TEMP_RUNNER_ORDERS;

SELECT TCO.PIZZA_ID,COUNT(TRO.ORDER_ID) AS DELIVERED_ORDERS
		FROM TEMP_CUSTOMER_ORDERS TCO LEFT JOIN TEMP_RUNNER_ORDERS TRO ON
        TCO.ORDER_ID=TRO.ORDER_ID WHERE TRO.CANCELLATION NOT IN
        ('Restaurant Cancellation','Customer Cancellation')
        GROUP BY TCO.PIZZA_ID;

-- 5. How many Vegetarian and Meatlovers were ordered by each customer?

SELECT * FROM TEMP_CUSTOMER_ORDERS ORDER BY PIZZA_ID;

SELECT TCO.PIZZA_ID, PN.PIZZA_NAME, COUNT(TCO.ORDER_ID) AS N_ORDERS
FROM TEMP_CUSTOMER_ORDERS TCO LEFT JOIN PIZZA_NAMES PN ON TCO.PIZZA_ID=PN.PIZZA_ID
GROUP BY TCO.PIZZA_ID ORDER BY N_ORDERS;
/*
1	Meatlovers	10
2	Vegetarian	4
*/

-- 6.  What was the maximum number of pizzas delivered in a single order?

SELECT * FROM TEMP_RUNNER_ORDERS;
SELECT * FROM TEMP_CUSTOMER_ORDERS;


SELECT TRO.ORDER_ID,
COUNT(TCO.PIZZA_ID) AS N_PIZZA_ORDERS
FROM TEMP_CUSTOMER_ORDERS TCO LEFT JOIN TEMP_RUNNER_ORDERS TRO 
ON TCO.ORDER_ID=TRO.ORDER_ID
WHERE TRO.CANCELLATION NOT IN('Restaurant Cancellation','Customer Cancellation')
GROUP BY TRO.ORDER_ID;
/*
		1		1
		2		1
		3		2
		4		3
		5		1
		7		1
		8		1
		10		2
*/

-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

USE PROBLEMS;
SELECT * FROM PIZZA_NAMES;
SELECT * FROM PIZZA_RECIPES;
SELECT * FROM PIZZA_TOPPINGS;
SELECT * FROM TEMP_CUSTOMER_ORDERS ORDER BY CUSTOMER_ID;
SELECT * FROM TEMP_RUNNER_ORDERS;

SELECT TCO.CUSTOMER_ID,COUNT(TRO.ORDER_ID) AS DELIVERED_ORDERS FROM
TEMP_CUSTOMER_ORDERS TCO LEFT JOIN TEMP_RUNNER_ORDERS TRO
ON TCO.ORDER_ID=TRO.ORDER_ID WHERE 
TCO.EXTRAS <>' ' OR TCO.EXCLUSIONS <> ' ' AND
TRO.CANCELLATION 
NOT IN ('Restaurant Cancellation','Customer Cancellation') 
GROUP BY TCO.CUSTOMER_ID;

-- What was the volume of orders for each day of the week?