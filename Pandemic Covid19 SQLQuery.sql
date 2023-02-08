Select*
From PorfolioProject..CovidDeaths
Where continent is not Null
order by 3,4



Select Location, date, total_cases, new_cases, total_deaths, population
From PorfolioProject..CovidDeaths
Where continent is not Null
order by 1,2



-- --------------------------------------------------------Total cases vs total death --------------------------------------------------
-- --------------------------------------------The likelihood percent of dying if you contract covid in your country -------------------------------



Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPecentage
From PorfolioProject..CovidDeaths
order by 1,2

-- --------------------------------------------The likelihood percent of dying if you contract covid in the U.S -------------------------------

Select Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPecentage
From PorfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2


----------------------------------------------------------- Total cases vs. population in U.S -----------------------------------------------------
-- ------------------------------------------------Percentage of population that has covid cases------------------------------------------------

Select Location, date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From PorfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2

-- ---------------------------------------What country has the highest infection rate compare to population? -------------------------------------


Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PorfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not Null
Group by Location,Population
order by PercentPopulationInfected desc


Select Location, Population, date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PorfolioProject..CovidDeaths
--Where location like '%states%'
Where location is not Null
Group by Location,Population, date
order by PercentPopulationInfected desc



------------------------------------------------Countries with the highest death count per population-------------------------------------------------

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PorfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not Null
Group by Location
order by TotalDeathCount desc


--------------------------------------------------Breaking down by continent------------------------------------------------------------------

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PorfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not Null
Group by continent
order by TotalDeathCount desc

-------------------------------------------------- Continent with the highest death count per population ----------------------------------------

-- 2
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PorfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not Null
Group by continent
order by TotalDeathCount desc


--------------------------------------------------------------Globle numbers-----------------------------------------------------------------

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From PorfolioProject..CovidDeaths
--Where location like '%states'
Where continent is not null
--group by date
order by 1,2



-------------------------------------------------------Covid death and vaccinations----Joining two tables------ --------------------

Select *
From PorfolioProject..CovidVaccinations


Select *
From PorfolioProject..CovidDeaths dea
Join PorfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date

   -- ----------------------------------------------Total Population vs total vaccinnations ----------------------------------------------------
   -- -------------------------------------------Percentage of population that got vaccinated --------------------------------------------------

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
From PorfolioProject..CovidDeaths dea 
Join PorfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
 where dea.continent is not null
 order by 2,3



-----------------------------------------------------------RollingCount------------------------------------------------------------------------

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PorfolioProject..CovidDeaths dea 
Join PorfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
 where dea.continent is not null
-- order by 2,3)
