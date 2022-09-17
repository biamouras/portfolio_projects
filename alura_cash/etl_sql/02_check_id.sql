# checking data info and inconsistencies
# ids
use alura_cash;
select * from id;

# converting columns to the same type of the original 
alter table id
modify column person_id varchar(16),
modify column loan_id varchar(16),
modify column cb_id varchar(16);

# all the ids must be in the other tables
select person_id
from id
where person_id not in (select person_id from dados_mutuarios);

select loan_id
from id
where loan_id not in (select loan_id from emprestimos);

select cb_id
from id
where cb_id not in (select cb_id from historicos_banco);

# creating the primary and foreign keys
alter table id
add (
	primary key(person_id, loan_id, cb_id),
	foreign key fk_person (person_id) references dados_mutuarios(person_id),
    foreign key fk_loan (loan_id) references emprestimos(loan_id),
    foreign key fk_cb (cb_id) references historicos_banco(cb_id)
);