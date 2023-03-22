# Mahendra_portofolio

CREATE DATABASE CALLCENTER : latihan.callcenter


-- Prior the analysis, I normally check missing value and formating the value to make sure all the data is full and avoid errors during analysis.
-- Converting date Format / Convering Call_timestamp coloum from sring into date format mm/dd/yyy
SET SQL_SAFE_UPDATES = 0;
UPDATE latihan.callcenter SET call_timestamp = str_to_date(call_timestamp, "%m/%d/%Y");
SET SQL_SAFE_UPDATES = 1;

-- Converting blank value into NULL
UPDATE latihan.callcenter SET csat_score = NULL WHERE csat_score = 0;

-- Checking how many row / I only LIMIT the row to 4955 from the actual row 32941.Its take so long for me to upload the whole data to MYSQL so I decided to use 4955.
SELECT COUNT(*) AS row_num FROM latihan.callcenter;
-- Checking how many coloumn
SELECT COUNT(*) AS cols_num FROM information_schema.columns WHERE table_name = 'callcenter'; 

-- Checking the DISTINCT value of some coloumns
SELECT DISTINCT sentiment FROM latihan.callcenter;
SELECT DISTINCT reason FROM latihan.callcenter;
SELECT DISTINCT Channel FROM latihan.callcenter;
SELECT DISTINCT Response_time FROM latihan.callcenter;
SELECT DISTINCT Call_center FROM latihan.callcenter;


-- Finding the count and percentage of each DISTICNT values
SELECT sentiment, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM latihan.callcenter)) * 100, 1) AS percentage
FROM latihan.callcenter GROUP BY 1 ORDER BY 3 DESC;

SELECT reason, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM latihan.callcenter)) * 100, 1) AS percentage
FROM latihan.callcenter GROUP BY 1 ORDER BY 3 DESC;

SELECT Channel, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM latihan.callcenter)) * 100, 1) AS percentage
FROM latihan.callcenter GROUP BY 1 ORDER BY 3 DESC;

SELECT Response_time, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM latihan.callcenter)) * 100, 1) AS percentage
FROM latihan.callcenter GROUP BY 1 ORDER BY 3 DESC;

SELECT Call_center, count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM latihan.callcenter)) * 100, 1) AS percentage
FROM latihan.callcenter GROUP BY 1 ORDER BY 3 DESC;


-- Which Day is the most Call
SELECT DAYNAME(Call_timestamp) AS day_of_call, COUNT(*) num_of_call FROM latihan.callcenter GROUP BY 1 ORDER BY 2 DESC;


--- 1. DESCRIPTIVE STATISTICS ---
SELECT MIN(csat_score) AS Min_score, MAX(csat_score) AS Max_score, ROUND(AVG(csat_score),1) AS Avg_score
FROM latihan.callcenter WHERE csat_score != 0;

SELECT MIN(call_timestamp) AS Earliest_date, MAX(call_timestamp) AS most_recent 
FROM latihan.callcenter

SELECT MIN(call_duration_in_minutes) AS Min_call_duration, MAX(call_duration_in_minutes) AS Max_call_duration,  AVG(call_duration_in_minutes) AS Avg_call_duration
FROM latihan.callcenter;

SELECT call_center, response_time, COUNT(*) AS count
FROM latihan.callcenter GROUP BY 1,2 ORDER BY 1,3;

SELECT call_center, AVG(call_duration_in_minutes) 
FROM latihan.callcenter GROUP BY 1 ORDER BY 2 DESC;

SELECT channel, AVG(call_duration_in_minutes) 
FROM latihan.callcenter GROUP BY 1 ORDER BY 2 DESC;

SELECT state, COUNT(*)
FROM latihan.callcenter GROUP BY 1 ORDER BY 2;

SELECT state, reason, COUNT(*)
FROM latihan.callcenter GROUP BY 1,2 ORDER BY 1,2,3;

SELECT state, sentiment, COUNT(*)
FROM latihan.callcenter GROUP BY 1,2 ORDER BY 1,3;

SELECT sentiment, AVG(call_duration_in_minutes)
FROM latihan.callcenter GROUP BY 1 ORDER BY 2;

-- Want to know sentiment and its percentage from each channel
SELECT channel, sentiment,
    COUNT(*) AS count,
    COUNT(*) / (SELECT COUNT(*) 
        FROM latihan.callcenter AS t2
        WHERE t1.channel = t2.channel
    ) * 100 AS percentage
FROM latihan.callcenter AS t1
GROUP BY channel, sentiment 
ORDER BY channel;

-- Want to know sentiment and its percentage from each state
SELECT state, sentiment,
	COUNT(*) as count,
    COUNT(*) / (SELECT COUNT(*)
    FROM latihan.callcenter as T2
    WHERE t1.state = t2.state
	) * 100 as percentage
FROM latihan.callcenter AS T1
GROUP BY state, sentiment
ORDER By state;

-- Want to know response time and its percentage from each channel
SELECT channel, response_time,
	COUNT(*) as count,
    COUNT(*) / (SELECT COUNT(*)
    FROM latihan.callcenter as T2
    WHERE t1.response_time = t2.response_time
	) * 100 as percentage
FROM latihan.callcenter AS T1
GROUP BY channel, response_time
ORDER By channel;

-- Want to know AVERAGE call duraion of some values
-- A. CHANNEL
SELECT channel, AVG(call_duration_in_minutes) AS Avg_call_duration
FROM latihan.callcenter 
GROUP BY channel;
-- B. STATE
SELECT state, AVG(call_duration_in_minutes) AS Avg_call_duration
FROM latihan.callcenter 
GROUP BY state;
-- C. REASON
SELECT reason, AVG(call_duration_in_minutes) AS Avg_call_duration
FROM latihan.callcenter 
GROUP BY reason;



