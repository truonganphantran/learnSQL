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


---BÀI NÀY HỌC GROUP BY VỚI PAVOT: https://datalemur.com/questions/time-spent-snaps
  
SELECT
age_bucket
   ,ROUND(SUM(CASE when activity_type = 'open' THEN time_spent END)*100/ SUM(CASE when activity_type IN ( 'send','open') THEN time_spent END),2 )AS open_perc
  ,ROUND (SUM(CASE when activity_type = 'send' THEN time_spent END)*100/SUM(CASE when activity_type IN ( 'send','open') THEN time_spent END),2) AS send_perc
FROM age_breakdown
INNER JOIN activities
ON age_breakdown.user_id = activities.user_id
GROUP BY age_bucket;
--> truy vấn thứ nhất chỉ có nhóm tuổi đc GROUP BY: truy vấn này đúng rồi vì khi thực hiện nó chỉ gom nhóm tuổi thôi
-- xong nó mới lên SELECT rồi xét xem là case nào trong SEND với OPEN, rồi lặp lại như vậy trong cùng 1 nhóm tuổi
SELECT
age_bucket
   ,ROUND(SUM(CASE when activity_type = 'open' THEN time_spent END)*100/ SUM(CASE when activity_type IN ( 'send','open') THEN time_spent END),2 )AS open_perc
  ,ROUND (SUM(CASE when activity_type = 'send' THEN time_spent END)*100/SUM(CASE when activity_type IN ( 'send','open') THEN time_spent END),2) AS send_perc
FROM age_breakdown
INNER JOIN activities
ON age_breakdown.user_id = activities.user_id
GROUP BY age_bucket, activity;
--> truy vấn này group by 2 nhóm, vì GROUP BY xong nó mới SELECT nên những người chung cả về nhóm tuổi và SEND hoặc OPEN 
--thì nó mới nhận, cho nên nếu có SEND, thì OPEN null và ngược lại



---SELF JOIN cần ngẫm: https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/?envType=study-plan-v2&envId=top-sql-50
https://drive.google.com/drive/u/1/folders/1in2sXXdtTy0Gw7P42ZUDHDif_z-ZvZ1p
SELECT  
      emp.employee_id
      , emp.name
      ,COUNT(CASE WHEN report_.reports_to IS NOT NULL THEN emp.employee_id END) AS reports_count 
      , ROUND (AVG(CASE WHEN report_.reports_to IS NOT NULL THEN report_.age END), 0) AS average_age
      FROM EMPLOYEES AS emp
INNER JOIN EMPLOYEES AS report_
ON emp.employee_id = report_.reports_to
GROUP BY employee_id;
