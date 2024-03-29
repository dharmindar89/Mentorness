
-- ------------------------------------Database Creation--------------------------------
CREATE DATABASE IF NOT EXISTS hotel;
USE hotel;		#set hotel database as default database


-- -----------------------------------Table Creation------------------------------------
CREATE TABLE IF NOT EXISTS hotel_data(
			 Booking_ID VARCHAR(10) NOT NULL PRIMARY KEY,
             no_of_adults INT NOT NULL,
             no_of_children INT NOT NULL,
             no_of_weekend_nights INT NOT NULL,
             no_of_week_nights INT NOT NULL,
             type_of_meal_plan VARCHAR(15) NOT NULL,
             room_type_reserved VARCHAR(15) NOT NULL,
             lead_time INT NOT NULL,
             arrival_date DATE NOT NULL,
             market_segment_type VARCHAR(15) NOT NULL,
             avg_price_per_room DECIMAL(5,2) NOT NULL,
             booking_status VARCHAR(15) NOT NULL
            );
-- -------------------------------------------------------------------------------------

-- -----------------------------------My Task-------------------------------------------
-- 1. What is the total number of reservations in the dataset?
SELECT COUNT(Booking_ID) FROM hotel_data;			#700
-- There are total 700 reservations in the dataset.

-- 2. Which meal plan is the most popular among guests?
SELECT type_of_meal_plan, COUNT(type_of_meal_plan) AS meal_plan 
FROM hotel_data
GROUP BY type_of_meal_plan
ORDER BY meal_plan DESC;			#Meal plan 1: 527, Not Selected: 109, Meal Plan 2: 64
-- Meal plan 1 is the most popular as it is orderd by most guests i.e. 527.

-- 3. What is the average price per room for reservations involving children?
SELECT no_of_children, avg_price_per_room FROM hotel_data WHERE no_of_children>0;

-- 4. How many reservations were made for the year 20XX (replace XX with the desired year)?
SELECT COUNT(Booking_ID) AS Reservations_in_2018 FROM hotel_data WHERE YEAR(arrival_date)=2018;			#577
-- There are total 577 reservations made in 2018.

-- 5. What is the most commonly booked room type?
SELECT room_type_reserved, COUNT(room_type_reserved) AS total_reservations
FROM hotel_data 
GROUP BY room_type_reserved
ORDER BY total_reservations DESC;		#Room_Type 1: 534
-- Room_Type 1 is the most commonly booked room type.

-- 6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
SELECT COUNT(Booking_ID) AS Weekend_Reservations 
FROM hotel_data
WHERE no_of_weekend_nights>0;		#383
-- Total 383 reservations fall on a weekend.

-- 7. What is the highest and lowest lead time for reservations?
SELECT MIN(lead_time) AS Lowest_lead_time, Max(lead_time) AS Highest_lead_time 
FROM hotel_data;		#lowest: 0, highest: 443
-- The lowest lead time is 0 and highest lead time is 443.

-- 8. What is the most common market segment type for reservations?
SELECT market_segment_type, COUNT(market_segment_type) AS common_market_type
FROM hotel_data
GROUP BY market_segment_type
ORDER BY common_market_type DESC;		#Online: 518
-- The most common market segment type for reservations is Online market type.

-- 9. How many reservations have a booking status of "Confirmed"?
SELECT booking_status, COUNT(booking_status) AS Confirmed_bookings
FROM hotel_data WHERE booking_status='Confirmed';		#0 reservations
-- There are only two types of booking status, i.e. Canceled and Not_Canceled

-- 10. What is the total number of adults and children across all reservations?
SELECT SUM(no_of_adults+no_of_children) AS Total_guests
FROM hotel_data;		#adults+chidren: 1385
-- Total number of adults and children across all reservations is 1385

-- 11. What is the average number of weekend nights for reservations involving children?
SELECT ROUND(AVG(no_of_weekend_nights),1) AS AVG_Weekend_Nights
FROM hotel_data WHERE no_of_children>0;		#1
-- The average number of weekend nights for reservations involving children is 1.0

-- 12. How many reservations were made in each month of the year?
SELECT MONTHNAME(arrival_date) AS Month, COUNT(Booking_ID) AS Reservations
FROM hotel_data
GROUP BY Month
ORDER BY Reservations;		#October highest: 103, January lowest: 11
-- Jan:11, Feb:28, Jul:44, DEC:52, Mar:52, Nov:54, May:55, Apr:67, Aug:70, Sep:80, Jun:84, Oct:103

-- 13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?
SELECT Room_type_reserved, ROUND(AVG(no_of_week_nights+no_of_weekend_nights),2) AS AVG_Nights
FROM hotel_data
GROUP BY Room_type_reserved
ORDER BY AVG_Nights DESC;		#Room_Type 4 has highest average nights i.e. 3.80

-- 14. For reservations involving children, what is the most common room type, and what is the average price for that room type?
SELECT room_type_reserved, COUNT(room_type_reserved) AS Reservations, 
ROUND(AVG(avg_price_per_room),2) AS AVG_Price
FROM hotel_data
WHERE no_of_children>0
GROUP BY room_type_reserved
ORDER BY Reservations DESC;		#Room_Type 1 is most common room type

-- 15. Find the market segment type that generates the highest average price per room.
SELECT market_segment_type, ROUND(AVG(avg_price_per_room),2) AS AVG_Price
FROM hotel_data
GROUP BY market_segment_type
ORDER BY AVG_Price DESC;		#Online
-- The market segment type 'Online' generates the highest average price(112.46) per room

-- ------------------------------------ END --------------------------------------------