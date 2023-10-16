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
