--ket hop CASE WHEN voi COUNT, GORUP BY
-- https://datalemur.com/questions/matching-skills
SELECT candidate_id ,
COUNT(CASE WHEN skill IN ( 'Python', 'Tableau', 'PostgreSQL') then skill
END ) 
FROM candidates
GROUP BY candidate_id

--cu phap vieet hoa ten chu cai đầu
SELECT user_id 
  , CONCAT( UPPER (LEFT( LOWER (name),1)) , RIGHT( LOWER (name),LENGTH (name)-1)) AS name
FROM Users
ORDER BY user_id;


---su khac nhau cua 2 cu phap sau (https://datalemur.com/questions/laptop-mobile-viewership)
SELECT  
SUM(CASE WHEN  device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type IN ( 'tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership

SELECT  
SUM(CASE WHEN  device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type IN ( 'tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership
GROUP BY device_type
