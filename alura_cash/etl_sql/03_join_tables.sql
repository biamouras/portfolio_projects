# join tables

use alura_cash;

SHOW VARIABLES LIKE "secure_file_priv" ;

select a.*, 
	b.person_age,b.person_income, b.person_home_ownership, b.person_home_ownership_pt, b.person_emp_length,
    c.loan_intent, c.loan_intent_pt, c.loan_grade, c.loan_amnt, c.loan_int_rate, c.loan_status, c.loan_percent_income,
    d.cb_person_cred_hist_length, d.cb_person_default_on_file
from id a,
	dados_mutuarios b,
    emprestimos c,
    historicos_banco d
where a.person_id = b.person_id 
	and a.loan_id = c.loan_id
    and a.cb_id = d.cb_id
into outfile 'D:/ProgramData/MySQL/MySQL Server 8.0/Uploads/alura_cash_20220905.csv';

