CREATE TABLE GDP_COUNTRY (
	Country VARCHAR(50),
	Region VARCHAR(50),
	Year DATE, 
	GDP_pp NUMERIC
)
----That's required to grab 'year' element from the 'year' named column in order to make it identical to another
----column at 'life_expectancy' table so that we can match the tables up.

SELECT *
FROM GDP_COUNTRY
ORDER BY GDP_PP DESC
------------------
SELECT*
FROM LIFE_EXPECTANCY
------------------
--We are creating new table from subquery for the proper format 
CREATE TABLE gdp as 
	SELECT a.country,a.region,CAST(a.year as int ),a.gdp_pp
	FROM (SELECT country,region,to_char(year,'YYYY') as year ,gdp_pp
	FROM GDP_COUNTRY) a

CREATE TABLE gdp_vs_life_expectancy as 
	SELECT g.country,g.year,g.gdp_pp,l.life_expectancy
	FROM GDP g INNER JOIN LIFE_EXPECTANCY l
		ON g.year=l.year AND g.country=l.country
	WHERE g.year = 2011

SELECT*
FROM gdp_vs_life_expectancy

COPY gdp_vs_life_expectancy TO 'C:\Users\ibrahim\Desktop\GDP_LAST.csv' DELIMITER ',' CSV HEADER;
