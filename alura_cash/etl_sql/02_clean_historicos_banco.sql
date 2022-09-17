# checking data info and inconsistencies
# bank history

use alura_cash;
select * from historicos_banco;

# id - should be primary key
# detecting duplicates
select (count(cb_id) - count(distinct cb_id)) as duplicates
from historicos_banco;
# there is no duplicates

alter table historicos_banco
add primary key(cb_id);

# identify categories different from expected in cb_person_default_on_file
select distinct cb_person_default_on_file
from historicos_banco
where cb_person_default_on_file not regexp '[Y|N]'; 

# there is some blank cells
# converting them to null
update historicos_banco
set cb_person_default_on_file = null
where cb_person_default_on_file not regexp '[Y|N]'; 

# identify outliers in cb_person_cred_hist_length
select avg(cb_person_cred_hist_length), min(cb_person_cred_hist_length), max(cb_person_cred_hist_length)
from historicos_banco;
# for now, there is no inconsistency,
# but it will be nice to check this info with the age of the client

# change datatype for default on file

# create new column as bit to set 1 for y and 0 for no
alter table historicos_banco
add default_on_file int;
update historicos_banco
set default_on_file = if(cb_person_default_on_file = 'Y', 1, 0);

select * from historicos_banco;
# then delete the old one and rename the new
alter table historicos_banco
drop column cb_person_default_on_file,
rename column default_on_file to cb_person_default_on_file;