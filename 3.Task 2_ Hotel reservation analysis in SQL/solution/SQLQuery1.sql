/****** Script for SelectTopNRows command from SSMS  ******/
--search on how to use count *
--0- display the dataset

SELECT TOP (1000) [Booking_ID]
      ,[no_of_adults]
      ,[no_of_children]
      ,[no_of_weekend_nights]
      ,[no_of_week_nights]
      ,[type_of_meal_plan]
      ,[room_type_reserved]
      ,[lead_time]
      ,[arrival_date]
      ,[market_segment_type]
      ,[avg_price_per_room]
      ,[booking_status]
  FROM [mentronesshotel].[dbo].[Hotel Reservation Dataset]
--1- total number of reservations
select count(*) as [total number of reservations]
from [Hotel Reservation Dataset]
--2- which meal plan is most popular among guests
SELECT TOP 1 type_of_meal_plan, COUNT(*) AS mealPlancount
FROM [Hotel Reservation Dataset]
GROUP BY type_of_meal_plan
ORDER BY mealPlancount DESC
--3-average price per room for reservations involving children
select avg_price_per_room
from [Hotel Reservation Dataset]
where no_of_children>0
--4-How many reservations were made for the year 20XX (replace XX with the desired year)?  
SELECT year(CONVERT(DATE, arrival_date, 105)) as yearr, count(*) as countofreservationperyear
FROM [Hotel Reservation Dataset]
where year(CONVERT(DATE, arrival_date, 105))=2018
group by year(CONVERT(DATE, arrival_date, 105))
--5- what is the most commonly book type
select top 1 count(*) as #ofres, room_type_reserved
from [Hotel Reservation Dataset]
group by room_type_reserved
order by #ofres desc
--6- how many reservations fall on a weekend
select count(*) as numberofweekendreservations
from [Hotel Reservation Dataset]
where no_of_weekend_nights>0
--7-what is the highest and lowed lead time for reservation
select min(cast(lead_time as int)) as lowest, max(cast(lead_time as int)) as maximum
from [Hotel Reservation Dataset]
--8- what is the most common segement type for reservations
select top 1 market_segment_type, count(*) as #ofres
from [Hotel Reservation Dataset]
group by market_segment_type	
order by #ofres desc
--9- how many reservations have book status of confirmed
select distinct booking_status
from [Hotel Reservation Dataset]

SELECT COUNT(*) AS #ofres, booking_status
FROM [Hotel Reservation Dataset]
WHERE booking_status = 'not_canceled'-- or confirmed
GROUP BY booking_status;
--10-what is the total number of adults and children across all reservations 
select sum(cast(no_of_children as INT)) as totalNumberOfChilds , sum(cast(no_of_adults as int)) as totalNumberofAdults ,sum(cast(no_of_children as INT))+sum(cast(no_of_adults as INT)) as totalNumberofPeople
from [Hotel Reservation Dataset]
--11. What is the average number of weekend nights for reservations involving children?  
select avg(cast(no_of_weekend_nights as int)) as avgweeknights
from [Hotel Reservation Dataset]
where no_of_children>0

--12. How many reservations were made in each month of the year? 
select count(*) as [reservations per month],Datename(MONTH,convert(date,arrival_date,105)) as monthnames
from [Hotel Reservation Dataset]
group by Datename(MONTH,convert(date,arrival_date,105))
order by [reservations per month] desc
--13. What is the average number of nights (both weekend and weekday) spent by guests for each room type
select avg(cast(no_of_weekend_nights as int)+cast(no_of_week_nights as int)) as avgnights,room_type_reserved
from [Hotel Reservation Dataset]
group by room_type_reserved 
order by avgnights desc
--14. For reservations involving children, what is the most common room type, and what is the average price for that room type
select top 1  count(*) as #ofres , room_type_reserved, avg(Cast(avg_price_per_room as Float)) as avgpriceforthatroomtype
from [Hotel Reservation Dataset]
where no_of_children>0
group by room_type_reserved
order by #ofres desc
--15- Find the market segment type that generates the highest average price per room.  
select top 1 max(cast(avg_price_per_room as float)) as highestaveragepriceperroom , market_segment_type
from [Hotel Reservation Dataset]
group by market_segment_type
order by highestaveragepriceperroom desc