SELECT *
FROM PorfolioProject..InternationalDebt;

------------------------------------------------------------Debt Indicator---------------------------------------------------------
SELECT DISTINCT indicator_code AS debt_indicator 
FROM PorfolioProject..InternationalDebt
WHERE indicator_code = indicator_code
ORDER BY debt_indicator; 

-----------------------------------------------------------Calculating Total -------------------------------------------------------
SELECT (SUM(Debt_2021)/1000000,1) AS total_debt 
FROM PorfolioProject..InternationalDebt;

-----------------------------------------------------------Calculating Top 5 Countries Maximum Debt --------------------------------

SELECT TOP 5 Country_name, MAX(Debt_2021) AS highest_countries_debt
FROM PorfolioProject..InternationalDebt
WHERE indicator_code = indicator_code
GROUP BY Country_name
ORDER BY "highest_countries_debt" DESC;

-----------------------------------------------------------Calculating Bottom 5 Countries Minimum Debt -----------------------------

SELECT TOP 5 Country_name, MIN(Debt_2021) AS lowest_countries_debt
FROM PorfolioProject..InternationalDebt
WHERE Debt_2021 IS NOT NULL
GROUP BY Country_name
ORDER BY "lowest_countries_debt" ASC;


------------------------------------Calculating the differences between two countries' national debt, highest and lowest --------------

SELECT (Max(Debt_2021)) - (MIN(Debt_2021)) AS difference_debt_amount
FROM PorfolioProject..InternationalDebt;



