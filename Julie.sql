--ket hop CASE WHEN voi COUNT, GORUP BY
-- https://datalemur.com/questions/matching-skills
SELECT candidate_id ,
COUNT(CASE WHEN skill IN ( 'Python', 'Tableau', 'PostgreSQL') then skill
END ) 
FROM candidates
GROUP BY candidate_id
