DECLARE @Table TABLE (d1 DATETIME, d2 DATETIME)
INSERT INTO @Table (d1, d2)
        SELECT '2017-09-01','2020-12-10' 
  UNION SELECT '2017-08-03','2019-01-09' 
  UNION SELECT '2022-12-12','2023-05-10' 
  UNION SELECT '2000-01-04','2001-07-05'  
  UNION SELECT '2001-06-01','2001-08-05' 

  SELECT 
       s1.d1,
       MIN(t1.d2) AS EndDate
FROM @Table s1 
INNER JOIN @Table t1 ON s1.d1 <= t1.d2
  AND NOT EXISTS(SELECT * FROM @Table t2 
                 WHERE t1.d2 >= t2.d1 AND t1.d2 < t2.d2) 
WHERE NOT EXISTS(SELECT * FROM @Table s2 
                 WHERE s1.d1 > s2.d1 AND s1.d1 <= s2.d2) 
GROUP BY s1.d1 
ORDER BY s1.d1