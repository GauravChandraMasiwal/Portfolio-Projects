select * from covid_report..coviddeaths
order by 3


select  location,date,total_cases,new_cases,total_deaths,population 
from dbo.coviddeaths
order by 1,2

--total_cases column is converted into float datatype
alter table dbo.coviddeaths alter column total_cases float  



--total cases vs total deaths
--this shows the likelihood of dying bcuz of covid
select  location,date,total_cases,total_deaths ,(total_deaths/population)*100 as total_death_percentage
from dbo.coviddeaths
where continent is not null and total_cases is not null and total_deaths is not null
order by 1,2

-- here,i have made a stored procedure with a variable location so that we can filter the above data as per location

--------------------------------------------------------------------------------------------------------------------------------
drop procedure if exists Death_Percentage
create procedure Death_Percentage 
@location nvarchar(255)
as 
drop table if exists #death_percentage
create table #death_percentage(
location nvarchar(255),date datetime,total_cases float,total_deaths float,death_percentage float
)
insert into #death_percentage
select  location,date,total_cases,total_deaths ,(total_deaths/total_cases)*100 as death_percentage
from dbo.coviddeaths
where location like @location
order by 1,2
select * from #death_percentage

--in order for the stored procedure to work properly ,you must first command the drop procedure line first,and then
--select the rest of code including select * from #table and then run the execute command 
exec Death_Percentage @location = '%India%'


--------------------------------------------------------------------------------------------------------------------------------

--looking at country with highest infection rate
select  location,population,max(total_cases)as HighestInfectionCount,max(total_cases/population)*100 as PercentPopulationInfection
from dbo.coviddeaths
where continent is not null --and total_cases is not null 
group by location,population
order by PercentPopulationInfection desc

--Showing the above table with respect to the date
select  location,date,population,max(total_cases)as HighestInfectionCount,max(total_cases/population)*100 as PercentPopulationInfection
from dbo.coviddeaths
where continent is not null --and total_cases is not null 
group by location,population,date
order by PercentPopulationInfection desc

--showing countries with highest death count per population
select  location,max(total_deaths)as TotalDeathCount,max(total_deaths/population)*100 as PercentPopulationDeaths
from dbo.coviddeaths
where continent is not null and total_deaths is not null 
group by location
order by PercentPopulationDeaths desc



--looking at country with highest fully vaccinated population percentage
select  location,max(population) as Population,max(people_fully_vaccinated)as PeopleFullyVaccinated,(max(people_fully_vaccinated)/max(population))*100 as PercentPopulationFullyVaccinated
from dbo.covidvaccination
where continent is not null
group by location,population
order by 4 desc


--LET'S BREAK THINGS DOWN BY CONTINENT
--showing the continent with highest deathcount per population

with cont_death(continent,location,Total_Population,TotalDeathCount)as
(select  continent,location,max(population)as Total_Population,max(total_deaths)as TotalDeathCount from dbo.coviddeaths
where continent is not null and total_deaths is not null 
group by continent,location)
select continent ,Sum(Total_Population) as TotalPopulation ,sum(TotalDeathCount) as TotalDeathCount,(sum(TotalDeathCount)/sum(Total_Population) )*100 as Total_Population_Death_Percentage
from cont_death group by continent order by 4 desc;


--showing the continent with highest FullyVaccination per population

with cont_vac(continent,location,Total_Population,TotalPeopleFullyVaccination)as
(select continent,location,max(population)as Total_Population,max(people_fully_vaccinated)as TotalPeopleFullyVaccination from dbo.covidvaccination
where continent is not null and people_fully_vaccinated is not null 
group by continent,location)
select continent ,Sum(Total_Population) as TotalPopulation ,sum(cast(TotalPeopleFullyVaccination as bigint)) as Total_People_Fully_Vaccination,(sum(cast(TotalPeopleFullyVaccination as bigint))/sum(Total_Population) )*100 as Total_Population_Vaccination_Percentage
from cont_vac group by continent order by 4 desc;

--GLOBAL NUMBERS i.e Total Cases ,Deaths & Death% of whole world as per a particular date 
select date,sum(new_cases) as TotalCases,sum(new_deaths) as TotalDeaths ,(sum(new_deaths)/sum(new_cases))*100 as death_percentage
from dbo.coviddeaths
where continent is not null and new_cases >0 and  new_cases is not null and new_deaths is not null
group by date
order by 1,2

--this gives the total data till now of whole world irrespective of location
select sum(new_cases) as TotalCases,sum(new_deaths) as TotalDeaths ,(sum(new_deaths)/sum(new_cases))*100 as death_percentage
from dbo.coviddeaths
where continent is not null and new_cases >0 and  new_cases is not null and new_deaths is not null

--------------------------------------------------------------------------------------------------------------------------------
--i am commenting this one as this takes too much time while executing 
--select sum(C.new_cases) as TotalCases,sum(C.new_deaths) as TotalDeaths ,
--(sum(C.new_deaths)/sum(C.new_cases))*100 as death_percentage,
--sum(convert(float,V.new_tests)) as TotalTests,sum(convert(float,V.new_people_vaccinated_smoothed)) as Total_People_Vaccinated ,
--(sum(convert(float,V.new_people_vaccinated_smoothed))/sum(convert(float,V.new_tests)))*100 as People_Vaccinated_PerTests_Percentage
--from dbo.coviddeaths as C
--full outer join dbo.covidvaccination as V
--on
--C.date = V.date and C.location = V.location
--where   C.continent is not null and V.continent is not null and C.new_cases >0 and  C.new_cases is not null and C.new_deaths is not null
--and C.location = 'India' and V.location = 'India'

-------------------------------------------------------------------------------------------------------------------------------

--looking at New Vaccinations added Date wise
select dea.continent , dea.location ,dea.date,dea.population,vac.new_vaccinations 
, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location , dea.date) 
as cumulative_vaccination
from dbo.coviddeaths dea join dbo.covidvaccination vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null 
order by 2,3


--looking at New Vaccinations added Date wise for India
select dea.continent , dea.location ,dea.date,dea.population,vac.new_vaccinations 
, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location , dea.date) 
as cumulative_vaccination
from dbo.coviddeaths dea join dbo.covidvaccination vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null and dea.location='India'
order by 2,3



--using cte to calculate the vaccination per population percentage

with PopvsVac(continent,location,date,population,new_vaccinations,cumulative_vaccination)
as
(select dea.continent , dea.location ,dea.date,dea.population,vac.new_vaccinations 
, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location , dea.date) 
as cumulative_vaccination 
from dbo.coviddeaths dea join dbo.covidvaccination vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null
)
select *,(cumulative_vaccination/population)*100 as VaccinationPerPopulationPercentage from PopvsVac



--Here i tried to recreate the above table but now using Temp table not Cte
-- Also I have filtered the data for india only,
drop table if exists #PercentPopulationVaccinated

create table #PercentPopulationVaccinated
(continent nvarchar(255),location nvarchar(255),date datetime,population int,new_vaccinations bigint,cumulative_vaccination numeric
)
insert into #PercentPopulationVaccinated
select dea.continent , dea.location ,dea.date,dea.population,vac.new_vaccinations 
, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location , dea.date) 
as cumulative_vaccination
from dbo.coviddeaths dea join dbo.covidvaccination vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null and vac.new_vaccinations is not null
order by 2,3


select *,(cumulative_vaccination/population)*100 as VaccinationPerPopulationPercentage from #PercentPopulationVaccinated
where location = 'India';

--creating views to store data for later visualisation
drop view if exists globalnumbers

create view globalnumbers as
select date,sum(new_cases) as TotalCases,sum(new_deaths) as TotalDeaths ,(sum(new_deaths)/sum(new_cases))*100 as death_percentage
from dbo.coviddeaths
where continent is not null and new_cases >0 and  new_cases is not null and new_deaths is not null
group by date



--looking at country with highest fully vaccinated population percentage

with GlobalVaccination(Population , PeopleFullyVaccinated) as
(select  max(population) as Population,max(people_fully_vaccinated)as PeopleFullyVaccinated
from dbo.covidvaccination
where continent is not null
group by location,population)
select sum(Population) as Total_Population , sum(cast(PeopleFullyVaccinated as bigint)) as Total_Population_Fully_vaccinated ,
(sum(cast(PeopleFullyVaccinated as bigint))/sum(Population))*100 as Population_Fully_Vaccinated_Percentage from GlobalVaccination
