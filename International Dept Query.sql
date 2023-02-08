Select *
From PorfolioProject..InternationalDebt;

SELECT distinct indicator_code AS debt_indicator 
FROM PorfolioProject..InternationalDebt
WHERE indicator_code = indicator_code
ORDER BY debt_indicator; 


SELECT (SUM(Debt_2021)/1000000,1) AS total_debt 
FROM PorfolioProject..InternationalDebt;


SELECT TOP 5 Country_name, MAX(Debt_2021) AS highest_countries_debt
FROM PorfolioProject..InternationalDebt
WHERE indicator_code = indicator_code
GROUP BY Country_name
ORDER BY "highest_countries_debt" DESC;


SELECT TOP 5 Country_name, MIN(Debt_2021) AS lowest_countries_debt
FROM PorfolioProject..InternationalDebt
WHERE Debt_2021 IS NOT NULL
GROUP BY Country_name
ORDER BY "lowest_countries_debt" ASC;


