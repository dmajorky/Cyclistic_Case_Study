DBCC FREEPROCCACHE

DBCC DROPCLEANBUFFER

EXEC sp_help ['202205-divvy-tripdata$']
EXEC sp_help ['202201-divvy-tripdata$']

ALTER TABLE ['202201-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202201-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202202-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202202-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202203-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202203-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202204-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202204-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)



ALTER TABLE ['202205-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202205-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202206-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202206-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202207-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202207-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202108-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202108-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202109-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202109-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202110-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202110-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202111-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202111-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

ALTER TABLE ['202112-divvy-tripdata$']
ALTER COLUMN start_station_id nvarchar(255)
ALTER TABLE ['202112-divvy-tripdata$']
ALTER COLUMN end_station_id nvarchar(255)

--JOINED ALL TABLES WITH RELEVANT COLUMNS TOGETHER-- 
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual INTO yearly_data2
FROM
(
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202201-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202202-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202203-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202204-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202205-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202206-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202207-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202108-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202109-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202110-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202111-divvy-tripdata$']
UNION ALL
SELECT  ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM ['202112-divvy-tripdata$']) A

--CREATED TABLE WITH NULL VALUES REMOVED--
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
INTO null_cleared
FROM
(
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM yearly_data2
WHERE start_station_name IS NOT NULL AND end_station_name IS NOT NULL AND start_station_id IS NOT NULL AND end_station_id IS NOT NULL AND start_lng IS NOT NULL AND end_lat IS NOT NULL
AND end_lng IS NOT NULL) B

--CREATED TABLE THAT ADDS RIDE LENGTH, DAY OF WEEK, & MONTH COLUMNS--
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual, ride_length_minutes,
day_of_week, month
INTO ride_data4
FROM
(
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual,
DATEDIFF(MINUTE,started_at, ended_at) AS ride_length_minutes,
DATENAME(WEEKDAY, started_at) AS day_of_week,
DATENAME(MONTH, started_at) AS month
FROM null_cleared) C

-- FINDING AVG, MIN, MAX ride length--
SELECT AVG(ride_length_minutes) AS avg,
MIN(ride_length_minutes) AS min,
MAX(ride_length_minutes) AS max
FROM ride_data4
--AVG = 18 MIN = -129 MAX = 41629--

--FINDING RIDES WITH NEGATIVE RIDE TIMES--
SELECT COUNT(ride_length_minutes) AS negative_ride_times
FROM ride_data4
WHERE ride_length_minutes < 0
--46--

--FINDING RIDES THAT LASTED LONGER THAN 24 HOURS (1,440 minutes)--
SELECT COUNT(ride_length_minutes) AS rides_longer_than_24hours
FROM ride_data4
WHERE ride_length_minutes > 1440
--465--

--FILTERED OUT NEGATIVE RIDES & RIDES LASTING MORE THAN 24 HOURS--
SELECT AVG(ride_length_minutes) AS avg,
MIN(ride_length_minutes) AS min,
MAX(ride_length_minutes) AS max
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440
--AVG=18 MIN=1 MAX=1439--

--FINDING AVG RIDE LENGTH FOR MEMBERS & CASUAL RIDERS--
SELECT AVG(ride_length_minutes)
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
--AVG=12--
SELECT AVG(ride_length_minutes)
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
--AVG=25--

--AVG RIDE LENGTH FOR DAYS OF WEEK FOR MEMBER & CASUAL RIDERS--
SELECT day_of_week, AVG(ride_length_minutes) AS member_avg_ride_length
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
GROUP BY day_of_week
ORDER BY day_of_week
--MONDAY=12 TUESDAY=11 WEDNESDAY=12 THURSDAY=12 FRIDAY=12 SATURDAY=14 SUNDAY=14--
SELECT day_of_week, AVG(ride_length_minutes) AS casual_avg_ride_length
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
GROUP BY day_of_week
ORDER BY day_of_week
--MONDAY=26 TUESDAY=22 WEDNESDAY=22 THURSDAY=22 FRIDAY=24 SATURDAY=28 SUNDAY=29--

--AVG RIDE LENGTH BY MONTH FOR MEMBERS & CASUAL RIDERS--
SELECT month, AVG(ride_length_minutes) AS member_avg_ride_length
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
GROUP BY month
ORDER BY month
--JAN=10 FEB=10 MAR=11 APR=12 MAY=13 JUN=13 JUL=14 AUG=13 SEP=13 OCT=12 NOV=11 DEC=10--
SELECT month, AVG(ride_length_minutes) AS casual_avg_ride_length
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
GROUP BY month
ORDER BY month
--JAN=18 FEB=21 MAR=26 APR=27 MAY=27 JUN=25 JUL=26 AUG=27 SEP=26 OCT=24 NOV=21 DEC=20--

--TOTAL RIDES TAKEN BY MEMBERS & CASUAL RIDERS--
SELECT COUNT(member_casual) AS member_ride_total
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
--2,250,584--
SELECT COUNT(member_casual) AS casual_ride_total
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
--1,628,604--

--TOTAL RIDES TAKEN EACH DAY OF WEEK FOR MEMBERS & CASUAL RIDERS--
SELECT day_of_week, COUNT(*) AS rides_taken_by_members
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
GROUP BY day_of_week
ORDER BY day_of_week
--MON=310,969 TUE=342,678 WED=349,754 THU=346,042 FRI=299,693 SAT=285,726 SUN=270,722--
SELECT day_of_week, COUNT(*) AS rides_taken_by_casual_riders
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
GROUP BY day_of_week
ORDER BY day_of_week
--MON=194,381 TUE=169,637 WED=177,632 THU=200,083 FRI=221,066 SAT=344,993 SUN=30,812--

--TOTAL RIDES TAKEN EACH MONTH FOR MEMBERS & CASUAL RIDERS--
SELECT month, COUNT(*) AS rides_taken_by_members
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
GROUP BY month
ORDER BY month
--JAN=66,993 FEB=73,244 MAR=147,444 APR=76,006 MAY=279,201 JUN=324,629 JUL=90,279 AUG=329,889 SEP=325,227 OCT=286,046 NOV=76,616 DEC=130,110--
SELECT month, COUNT(*) AS rides_taken_by_casual_riders
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
GROUP BY month
ORDER BY month
--JAN=12,504 FEB=15,021 MAR=66,704 APR=44,610 MAY=218,312 JUN=289,512 JUL=86,052 AUG=339,497 SEP=291,289 OCT=188,067 NOV=32,218 DEC=44,818--

--TOTAL RIDES TAKEN ON EACH RIDE TYPE FOR MEMBERS & CASUAL RIDERS--
SELECT rideable_type, COUNT(*) AS member_rides
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
GROUP BY rideable_type
--electric_bike=603,027 classic_bike=1,602,557--
SELECT rideable_type, COUNT(*) AS casual_rides
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
GROUP BY rideable_type
--docked_bike=194,056 electric_bike=469,581 classic_bike=964,967--

--MOST POPULAR START STATIONS FOR MEMBERS & CASUAL RIDERS--
SELECT start_station_name, COUNT(*) AS member_rides
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
GROUP BY start_station_name
ORDER BY COUNT(*) DESC

SELECT start_station_name, COUNT(*) AS casual_rides
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
GROUP BY start_station_name
ORDER BY COUNT(*) DESC

--MOST POPULAR END STATIONS FOR MEMBERS & CASUAL RIDERS--
SELECT end_station_name, COUNT(*) AS member_rides
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'member'
GROUP BY end_station_name
ORDER BY COUNT(*) DESC

SELECT end_station_name, COUNT(*) AS casual_rides
FROM ride_data4
WHERE ride_length_minutes > 0 AND ride_length_minutes < 1440 AND member_casual = 'casual'
GROUP BY end_station_name
ORDER BY COUNT(*) DESC




