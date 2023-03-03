select * from India_Districts2011

select India_Districts2011.District_name,India_Districts2011.State_name,India_Districts2011.Hindus,Muslims,Sikhs,Buddhists,Jains,Christians,Others_Religions,Population

into Population_religion_based

from India_Districts2011

select * from Population_religion_based

select State_name,District_name,Literate,Female_Literate,Male_Literate,Population,Graduate_Education,Illiterate_Education
into India_literacy
from India_Districts2011

select * from India_literacy;

create function fn_literate_Population_state
(@state as varchar(50))
returns table
as
return
select distinct state_name,District_name,Literate
from India_literacy where State_name = @state
go

select * from fn_literate_Population_state('Jharkhand')

Sp_literate_Population_state jharkhand

create trigger Tr_indiacensus
on india_districts2011
instead of insert
as begin 
rollback 
print 'You are not supposed to do that'
end 
