  #Lets see the data look like to understend dataset

#Looking at that data I can use the next columns for my analysis
  # trip_seconds
  # trip_miles
  # pickup_community_area
  # dropoff_community_area
  # payment_type
  # company
  
  #First lets calculate the trip duration AVG,MAX,MIN value
SELECT
  ROUND(AVG(trip_seconds),2) AS AVG_trip,
  MAX(trip_seconds) AS Max_trip,
  MIN(trip_seconds) AS Min_trip
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`;
  
  #Second lets check the trip distance AVG,MAX,MIN value
SELECT
  ROUND(AVG(trip_miles),2) AS AVG_distance,
  MAX(trip_miles) AS Max_distance,
  MIN(trip_miles) AS Min_distance
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`;
  
  # Now lets see the most popular community area for pickup area
SELECT
  Community_name,
  number_of_rides
FROM (
  SELECT
    pickup_community_area AS community_area,
    COUNT(pickup_community_area) AS number_of_rides
  FROM
    `bigquery-public-data.chicago_taxi_trips.taxi_trips`
  WHERE
    pickup_community_area IS NOT NULL
  GROUP BY
    pickup_community_area) AS f
JOIN
  chicagocaps.CommunityNames.CommunityNames AS t
ON
  t.Community_number = f.community_area
ORDER BY f.number_of_rides DESC  ;

  
  # We will do the same with drop off area
SELECT
  Community_name,
  number_of_rides
FROM (
  SELECT
    dropoff_community_area AS community_area,
    COUNT(dropoff_community_area) AS number_of_rides
  FROM
    `bigquery-public-data.chicago_taxi_trips.taxi_trips`
  WHERE
    dropoff_community_area IS NOT NULL
  GROUP BY
    dropoff_community_area) AS f
JOIN
  chicagocaps.CommunityNames.CommunityNames AS t
ON
  t.Community_number = f.community_area
ORDER BY f.number_of_rides DESC ;
  
  # What data says about trip cost
SELECT
  ROUND(AVG(trip_total),2) AS AVG_cost,
  MAX(trip_total) AS Max_cost,
  MIN(trip_total) AS Min_cost
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`;
  
  # Also we can see the most popular payment types
SELECT
  payment_type,
  COUNT(payment_type) AS number_of_payments
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
GROUP BY
  payment_type
ORDER BY
  number_of_payments
LIMIT
  10;
  
  #At last I want to see the most popular taxi companys in Chicago
SELECT
  company,
  COUNT(company) AS number_of_rides
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE
  company IS NOT NULL
GROUP BY
  company
ORDER BY
  number_of_rides DESC
LIMIT
  10;