CREATE TABLE bankdb (
    id                     float,
    address_state          varchar,
    application_type       varchar,
    emp_length             varchar,
    emp_title              varchar,
    grade                  varchar,
    home_ownership         varchar,
    issue_date             date,
    last_credit_pull_date  date,  
    last_payment_date      date,  
    loan_status            varchar,
    next_payment_date      date, 
    member_id              float,
    purpose                varchar,
    sub_grade              varchar,
    term                   varchar,	
    verification_status    varchar,
    annual_income          float,
    dti                    float,
    installment            float,
    int_rate               float,
    loan_amount            float,
    total_acc              float,
    total_payment          float
);

SET datestyle = 'DMY';  --sets date based data types to dd-mm-yyyy format--
COPY bankdb FROM '/Library/PostgreSQL/17/External DB/RawDB.csv'
DELIMITER ','
CSV HEADER;