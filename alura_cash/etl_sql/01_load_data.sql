create database alura_cash;

# load data from original db
create table dados_mutuarios(
	person_id varchar(16),
	person_age int,
    person_income int,
    person_home_ownership varchar(8),
    person_emp_length double
);

insert into dados_mutuarios
select * 
from analise_risco.dados_mutuarios;

create table emprestimos (
	loan_id varchar(16),
    loan_intent varchar(32),
    loan_grade varchar(1),
    loan_amnt int,
    loan_int_rate double,
    loan_status int,
    loan_percent_income double
);

insert into emprestimos
select *
from analise_risco.emprestimos;

create table historicos_banco (
	cb_id varchar(16),
    cb_person_default_on_file varchar(1),
    cb_person_cred_hist_length int
);

insert into historicos_banco
select *
from analise_risco.historicos_banco;

create table id (
	person_id text,
    loan_id text,
    cb_id text
);

insert into id
select *
from analise_risco.id;

# verifying thatall the columns were filled
select *
from dados_mutuarios;

select *
from emprestimos;

select *
from historicos_banco;

select *
from id;