# checking data info and inconsistencies
# borrower data

select * from dados_mutuarios;

# id - should be primary key
# detecting duplicates
select (count(person_id) - count(distinct person_id)) as duplicates
from dados_mutuarios;
# there are 5 duplicates

# viewing duplicates  
select *, count(person_id) as count
from dados_mutuarios
group by person_id
having count > 1;
    
# there are some blank ids
delete from dados_mutuarios
where person_id = '';

# set person_id as primary key
alter table dados_mutuarios
add primary key(person_id);

# age (years)
select avg(person_age) as media, max(person_age) as max, min(person_age) as min
from dados_mutuarios;

# there is some people over 100 years trying to borrow some money,
# which does not seem right, we will probably delete them because we can not assume anything
# setting age as null for them
update dados_mutuarios
set person_age = null
where person_age > 100;

# home ownership - rent, own, mortgage, other
select distinct person_home_ownership
from dados_mutuarios;

# there are 331 people with blank info in home ownership but not as null
select count(person_id) as n
from dados_mutuarios
where person_home_ownership not regexp '[Rent|Own|Mortgage|Other]';

# we will only update it as Null for consistencies
update dados_mutuarios
set person_home_ownership = null
where person_home_ownership not regexp '[Rent|Own|Mortgage|Other]';

# person experience work (years)
select avg(person_emp_length) as media, max(person_emp_length) as max, min(person_emp_length) as min
from dados_mutuarios;

# there are some people with over 100 years of experience
# we should check the difference between the age and years of xp for inconsistences 
# this difference will provide the starting working age of the person
select distinct person_age - person_emp_length as starting_age
from dados_mutuarios
where person_age - person_emp_length < 18;

# setting the cases of negative starting age as null
update dados_mutuarios
set person_emp_length = null
where person_age - person_emp_length < 0;

# checking data types
select distinct person_emp_length
from dados_mutuarios;

alter table dados_mutuarios
modify person_emp_length int;

# translate home_ownership column
alter table dados_mutuarios
add person_home_ownership_pt varchar(12);

update dados_mutuarios
set person_home_ownership_pt = (
	CASE 
		WHEN person_home_ownership = 'Rent' THEN 'Alugada'
        WHEN person_home_ownership = 'Own' THEN 'Própria'
        WHEN person_home_ownership = 'Mortgage' THEN 'Hipotecada'
        WHEN person_home_ownership = 'Other' THEN 'Outros casos'
        ELSE null
	END
);

select * from dados_mutuarios;