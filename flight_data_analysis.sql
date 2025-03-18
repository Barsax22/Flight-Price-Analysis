SELECT *
FROM flight_data;

-- Deleting empty rows because we cannot update them - 1848 rows
DELETE FROM flight_data
WHERE Departure IS NULL
OR Destination = ''
OR Airline = ''
OR Price = ''
OR `Departure Time` = ''
OR `Arrival Time` = ''
OR Stops = ''
OR Duration = '';

-- Checking if there are any NULL values or empty values left
SELECT 
    SUM(CASE WHEN Date IS NULL OR Date = '' THEN 1 ELSE 0 END) AS missing_flight_date,
    SUM(CASE WHEN Departure IS NULL OR Departure = '' THEN 1 ELSE 0 END) AS missing_departure,
    SUM(CASE WHEN Destination IS NULL OR Destination = '' THEN 1 ELSE 0 END) AS missing_destination,
    SUM(CASE WHEN Airline IS NULL OR Airline = '' THEN 1 ELSE 0 END) AS missing_airline,
    SUM(CASE WHEN Price IS NULL OR Price = '' THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN `Departure Time` IS NULL OR `Departure Time` = '' THEN 1 ELSE 0 END) AS missing_departure_time,
    SUM(CASE WHEN `Arrival Time` IS NULL OR `Arrival Time` = '' THEN 1 ELSE 0 END) AS missing_arrival_time,
    SUM(CASE WHEN Stops IS NULL OR Stops = '' THEN 1 ELSE 0 END) AS missing_stops,
    SUM(CASE WHEN Duration IS NULL OR Duration = '' THEN 1 ELSE 0 END) AS missing_duration,
    SUM(CASE WHEN `Flight Type` IS NULL OR `Flight Type` = '' THEN 1 ELSE 0 END) AS missing_flight_type
FROM flight_data;

-- Check duplicates with ROW_NUMBER
SELECT *, 
       ROW_NUMBER() OVER (
           PARTITION BY Date, Departure, Destination, Airline, Price, 
                        `Departure Time`, `Arrival Time`, Stops, Duration, `Flight Type`
           ORDER BY Date
       ) AS row_num
FROM flight_data;

-- Returns only the duplicates
SELECT * 
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY Date, Departure, Destination, Airline, Price, 
                            `Departure Time`, `Arrival Time`, Stops, Duration, `Flight Type`
               ORDER BY Date
           ) AS row_num
    FROM flight_data
) AS subquery
WHERE row_num > 1;

-- Create a new table without the duplicates
CREATE TABLE temp_flight_data AS
SELECT * FROM (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY Date, Departure, Destination, Airline, Price, 
                            `Departure Time`, `Arrival Time`, Stops, Duration, `Flight Type`
               ORDER BY Date
           ) AS row_num
    FROM flight_data
) AS subquery
WHERE row_num = 1; -- if it was greater than 1 its the duplicates

DROP TABLE flight_data; -- deleting the current table with all duplicates inside

ALTER TABLE temp_flight_data 
RENAME TO flight_data; -- renaming the new table

SELECT * FROM flight_data;

-- Deleting the column row_num after removing duplicates
ALTER TABLE flight_data 
DROP COLUMN row_num;

-- Checking the column types
DESC flight_data;

-- Updating the column types
ALTER TABLE flight_data
MODIFY COLUMN Date DATE,
MODIFY COLUMN Departure VARCHAR(255),
MODIFY COLUMN Destination VARCHAR(255),
MODIFY COLUMN Airline VARCHAR(255),
MODIFY COLUMN Price INT,
MODIFY COLUMN `Departure Time` TIME,
MODIFY COLUMN `Arrival Time` TIME,
MODIFY COLUMN Stops VARCHAR(50),
MODIFY COLUMN Duration VARCHAR(50),
MODIFY COLUMN `Flight Type` VARCHAR(100);

-- Search for the wrong format
SELECT `Arrival Time`
FROM flight_data
WHERE `Arrival Time` NOT REGEXP '^[0-9]{2}:[0-9]{2}$';

-- Update the wrong format
UPDATE flight_data
SET `Arrival Time` = SUBSTRING_INDEX(`Arrival Time`, '+', 1)
WHERE `Arrival Time` LIKE '%+%';

-- In Airline column there are mixed airlines combined by ','
SELECT *
FROM flight_data
WHERE Airline LIKE '%Wizz%';

CREATE TABLE flight_data_split AS 
SELECT 
    Date, Departure, Destination, 
    SUBSTRING_INDEX(Airline, ',', 1) AS Airline, -- First airline
    Price, `Departure Time`, `Arrival Time`, Stops, Duration, `Flight Type`
FROM flight_data

UNION ALL 

SELECT 
    Date, Departure, Destination, 
    TRIM(SUBSTRING_INDEX(Airline, ',', -1)) AS Airline, -- Second airline
    Price, `Departure Time`, `Arrival Time`, Stops, Duration, `Flight Type`
FROM flight_data
WHERE Airline LIKE '%,%'; -- rows within 2 airline seperated by comma


-- Deleting everything from flight_data table
DELETE FROM flight_data;

-- Updating flight_data table with the flight_data_split values
INSERT INTO flight_data 
SELECT * FROM flight_data_split;

-- Deleting flight_data_split table
DROP TABLE flight_data_split;


-- Analyzing Data --

-- The most popular Airline
SELECT Airline, COUNT(*) AS num_flights 
FROM flight_data 
GROUP BY Airline 
ORDER BY num_flights DESC 
LIMIT 10;

-- The price (in ILS) change due to different dates in December
SELECT Date, ROUND(AVG(Price),2) AS avg_price
FROM flight_data
GROUP BY Date
ORDER BY Date;

-- The most expensive Airline (price by ILS)
SELECT Airline, ROUND(AVG(Price),2) AS avg_price
FROM flight_data
GROUP BY Airline
ORDER BY AVG(Price) DESC
LIMIT 1;

-- The most cheap Airline (price by ILS)
SELECT Airline, ROUND(AVG(Price),2) AS avg_price
FROM flight_data
GROUP BY Airline
ORDER BY AVG(Price) ASC
LIMIT 1;

-- The price range for flights
SELECT MIN(Price) AS min_price, MAX(Price) AS max_price, AVG(Price) AS avg_price
FROM flight_data;

-- Count each stop option
SELECT Stops, COUNT(*) AS num_flights
FROM flight_data
GROUP BY Stops;

-- Which date had the most flights
SELECT Date, COUNT(*) AS num_flights
FROM flight_data
GROUP BY Date
ORDER BY num_flights DESC
LIMIT 1;

-- Top 5 cheap dates to fly
SELECT Date, ROUND(AVG(Price), 2) AS avg_price
FROM flight_data
GROUP BY Date
ORDER BY avg_price ASC
LIMIT 5;

-- Top 5 expensive dates to fly
SELECT Date, ROUND(AVG(Price), 2) AS avg_price
FROM flight_data
GROUP BY Date
ORDER BY avg_price DESC
LIMIT 5;

-- The airline with the most flights
SELECT Airline, COUNT(*) AS num_flights
FROM flight_data
GROUP BY Airline
ORDER BY num_flights DESC
LIMIT 1;






SELECT COUNT(*) AS row_count FROM flight_data;









