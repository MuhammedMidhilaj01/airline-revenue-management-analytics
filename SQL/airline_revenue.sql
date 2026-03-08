CREATE DATABASE airline_revenue;
USE airline_revenue;

### creating table
CREATE TABLE airline_data (
Date DATE,
Origin VARCHAR(50),
Destination VARCHAR(50),
Airline VARCHAR(50),
Fare_Class VARCHAR(20),
Booking_Channel VARCHAR(20),
Route VARCHAR(100),
Capacity INT,
Passengers INT,
Ticket_Price FLOAT,
Revenue FLOAT
);
### checking table structure
DESCRIBE airline_data;

### import data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/airline_revenue_dataset.csv'
INTO TABLE airline_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Date, Origin, Destination, Airline, Fare_Class, Booking_Channel, Route, Capacity, Passengers, Ticket_Price, Revenue);

### verifying data loaded

SELECT COUNT(*) FROM airline_data;
SELECT * 
FROM airline_data
LIMIT 10;

### total_revenue
SELECT round(SUM(Revenue)/1000000,2) AS Total_Revenue
FROM airline_data;
### shows 8820.57 Million total revenue generated across all routes

## top_revenue_routes
SELECT Route,
SUM(Revenue) AS Route_Revenue
FROM airline_data
GROUP BY Route
ORDER BY Route_Revenue DESC
LIMIT 10;

### these routes Hyderabad-Dubai,Hyderabad-Kuala Lumpur, Delhi-Bangkok,Chennai-Singapore,Kolkata-Bangkok these routes shows most profitable

### passenger demand route
SELECT Route,
SUM(Passengers) AS Total_Passengers
FROM airline_data
GROUP BY Route
ORDER BY Total_Passengers DESC
LIMIT 10;

## These routes have highest passenger demand.Chennai-Doha,Hyderabad-Dubai,Delhi-Singapore,Kolkata-London,Delhi-Bangkok

### average_ticket_price
SELECT Route,
AVG(Ticket_Price) AS Avg_Ticket_Price
FROM airline_data
GROUP BY Route
ORDER BY Avg_Ticket_Price DESC;

##Routes with highest ticket pricing

### monthly_revenue_trend
SELECT 
MONTH(Date) AS Month,
SUM(Revenue) AS Monthly_Revenue
FROM airline_data
GROUP BY Month
ORDER BY Month;

## Shows seasonal revenue patterns.

### load_factor
SELECT 
Route,
SUM(Passengers)/SUM(Capacity) AS Load_Factor
FROM airline_data
GROUP BY Route
ORDER BY Load_Factor DESC;

### Routes with highest seat utilization

### fair_class_revenue
SELECT 
Fare_Class,
SUM(Revenue) AS Revenue
FROM airline_data
GROUP BY Fare_Class;

## Compare Economy vs Business class revenue contribution.

