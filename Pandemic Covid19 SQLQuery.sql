SELECT *
FROM PorfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4



SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PorfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2



-- --------------------------------------------------------Total Cases vs Total Death ----------------------------------------------------------
-- --------------------------------------------The likelihood percent of dying if you contract Covid in your country -------------------------------



SELECT Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPecentage
FROM PorfolioProject..CovidDeaths
ORDER BY 1,2

-- --------------------------------------------The likelihood percent of dying if you contract Covid in the U.S -------------------------------

SELECT Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPecentage
FROM PorfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2


----------------------------------------------------------- Total Cases vs. Population in U.S -----------------------------------------------------
-- ------------------------------------------------Percentage of population that has Covid cases------------------------------------------------

SELECT Location, date, Population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PorfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

-- ---------------------------------------What country has the highest infection rate compare to population? -------------------------------------


SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PorfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY Location,Population
ORDER BY PercentPopulationInfected DESC


SELECT Location, Population, date, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PorfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE location IS NOT NULL
GROUP BY Location,Population, date
ORDER BY PercentPopulationInfected DESC



------------------------------------------------Countries with the highest death count per population-------------------------------------------------

SELECT Location, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PorfolioProject..CovidDeaths
--Where location like '%states%'
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC


--------------------------------------------------Breaking down by continent------------------------------------------------------------------

SELECT continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PorfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-------------------------------------------------- Continent with the highest death count per population ----------------------------------------

-- 2
SELECT continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PorfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


--------------------------------------------------------------Globle numbers-----------------------------------------------------------------

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(New_cases)*100 AS DeathPercentage
FROM PorfolioProject..CovidDeaths
--WHERE location like '%states'
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2



-------------------------------------------------------Covid Death and Vaccinations----Joining two tables------ --------------------

SELECT *
FROM PorfolioProject..CovidVaccinations


SELECT *
FROM PorfolioProject..CovidDeaths dea
JOIN PorfolioProject..CovidVaccinations vac
   ON dea.location = vac.location
   AND dea.date = vac.date

   -- ----------------------------------------------Total Population vs total vaccinnations ----------------------------------------------------
   -- -------------------------------------------Percentage of population that got vaccinated --------------------------------------------------

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
FROM PorfolioProject..CovidDeaths dea 
JOIN PorfolioProject..CovidVaccinations vac
   ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3



-----------------------------------------------------------RollingCount------------------------------------------------------------------------

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location, dea.date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PorfolioProject..CovidDeaths dea 
JOIN PorfolioProject..CovidVaccinations vac
   ON dea.location = vac.location
   AND dea.date = vac.date
 WHERE dea.continent IS NOT NULL
-- ORDER BY 2,3)
