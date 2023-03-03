create database India_Census2011;

use India_Census2011;

select * from India_Districts2011;

--create view for all the district data of Hindus in jammu Kashmir--\

create view Vw_Hindu_Population_JnK 
as
select A.State_name,a.District_name,a.Population,a.Hindus as TotalHIndu  
from India_Districts2011 as A where State_name = 'Jammu and Kashmir';

Select * from Vw_Hindu_Population_JnK;

--create procedure for data of population of in every district person having moped in any state --

Create proc Sp_data_of_MopedbyState @name varchar(50)
as begin
select  A.State_name, A.District_name,A.Population,A.Households_with_Scooter_Motorcycle_Moped From India_Districts2011 as A 
where A.State_name = @name;
end

exec Sp_data_of_MopedbyState 'Jharkhand';
exec Sp_data_of_MopedbyState 'Bihar';

--create procedure for district name with population having internet and computer by statename--

create proc Sp_DistrictData_ComputerANDInternet @name varchar(50)
as begin
select A.State_name,A.District_name,A.Households_with_Computer,A.Households_with_Internet,A.Population,A.Higher_Education,A.Literate from India_Districts2011 as A
where State_name = @name;
end

exec Sp_DistrictData_ComputerANDInternet Bihar;

--create procedure for gettting data of each district by state having least number of internet accessibility--

create proc Sp_Min_Internet_Accessibilty_districts @name varchar(50)
as begin
select A.State_name,District_name,A.Population,A.Households_with_Internet from India_Districts2011 as A 
where Households_with_Internet = (select min(Households_with_Internet) from India_Districts2011 where State_name = @name)
end

exec Sp_Min_Internet_Accessibilty_districts Bihar;
exec Sp_Min_Internet_Accessibilty_districts Jharkhand;
exec Sp_Min_Internet_Accessibilty_districts 'Uttar Pradesh';

--create a viirtual table consisting of disticts where literacy rate is minimum---

create proc SP_least_literacy_byState @name varchar(50)
as begin
select State_name,District_name,Population,Literate from India_Districts2011 
where Literate = (select min(Literate) from India_Districts2011 where State_name = @name ) 
and  State_name = @name
end

drop proc SP_least_literacy_byState

exec SP_least_literacy_byState 'Jharkhand'
exec SP_least_literacy_byState 'Bihar'


select * from India_Districts2011;

select A.State_Name,A.District_Name,a.Tehsil_Name,A.Area_Name,A.Rural_Urban,A.Total_Number_of_households
into Jharkhand_Housing_Data from india_census_housing2011 A
where A.State_Name = 'Jharkhand';

select * from Jharkhand_Housing_Data
where District_Name in (select Distinct District_Name from Jharkhand_Housing_Data);


