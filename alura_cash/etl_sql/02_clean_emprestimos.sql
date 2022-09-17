# checking data info and inconsistencies
# loan data

use alura_cash;
select * from emprestimos;

# id - should be primary key
# detecting duplicates
select (count(loan_id) - count(distinct loan_id)) as duplicates
from emprestimos;
# there is no duplicates

# set loan_id as primary key
alter table emprestimos
add primary key(loan_id);

# identify categories different from expected in loan_intent
select distinct loan_intent
from emprestimos
where loan_intent not regexp '[Personal|Education|Medical|Venture|Homeimprovement|Debtconsolidation]'; 

# there are some blank values, i am substituting them to null
update emprestimos
set loan_intent = null
where loan_intent not regexp '[Personal|Education|Medical|Venture|Homeimprovement|Debtconsolidation]'; 

# identify categories different from expected in loan_grade
select distinct loan_grade
from emprestimos
where loan_grade not regexp '[A-G]'; 

# there are some blank values, i am substituting them to null
update emprestimos
set loan_grade = null
where loan_grade not regexp '[A-G]'; 

# identifying outliers in loan amount
select avg(loan_amnt), max(loan_amnt), min(loan_amnt)
from emprestimos;

# identifying outliers in interest rate
select avg(loan_int_rate), max(loan_int_rate), min(loan_int_rate)
from emprestimos;

# identifying outliers in probability of default
select avg(loan_status), max(loan_status), min(loan_status)
from emprestimos;
# ok, could not be above 1

# identifying outliers in loan percent income
select avg(loan_percent_income), max(loan_percent_income), min(loan_percent_income)
from emprestimos;
# ok, could not be above 1

# check columns types
select distinct loan_status
from emprestimos;

# translate column loan_intent to portuguese
alter table emprestimos
add loan_intent_pt varchar(20);

update emprestimos
set loan_intent_pt = (
	case 
		when loan_intent = 'Personal' then 'Pessoal'
		when loan_intent = 'Education' then 'Educativo'
        when loan_intent = 'Medical' then 'Médico'
        when loan_intent = 'Venture' then 'Empreendimento'
        when loan_intent = 'Homeimprovement' then 'Melhora do lar'
        when loan_intent = 'Debtconsolidation' then 'Pagamento de débitos'
        else null
	end
);

select* from emprestimos;