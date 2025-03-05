---------------------------------------FOR DASHBOARD : 1 ---------------------------------------------------

/* run this query to see complete DB */
select * from bankdb;


/*Finding total Number of Applications */
create view total_loan_application as
select count(id) from bankdb;

select * from total_loan_application;


/* finding MTD (month to Date): for December 2021 */
create view MTD_december as
SELECT COUNT(id) AS "MTD Total Month Applications"
FROM bankdb
where issue_date between '2021-12-01' and  '2021-12-31' ;

select * from MTD_december;



/* Total Payment recovered in month of November and December */
select sum(loan_amount) as "December Total Funded Amount" from bankdb
where extract (month from issue_date) = '12' and extract (year from issue_date) = '2021'; --for December

select sum(loan_amount) as "November Total Funded Amount" from bankdb
where extract (month from issue_date) = '11' and extract(year from issue_date) = '2021'; --for November



/* Total Funded Amount in month of November and December */
select sum(total_payment) as "December Total Payment Received" from bankdb
where extract (month from issue_date) ='12' and extract (year from issue_date) = '2021'; --for December

select sum(total_payment) as "November Total Payment Received" from bankdb
where extract (month from issue_date) ='11' and extract (year from issue_date) ='2021'; --for November



/* Average interset rate for month of November and December */
select round((100.0 * Avg(int_rate))::numeric,4) as "Decemeber Average Interest Rate" from bankdb 
where extract(month from issue_date) = '12' and extract (year from issue_date) ='2021'; --for December

select round((100.0 * avg(int_rate))::numeric,4) as "November Average Interest Rate" from bankdb
where extract (month from issue_date) ='11' and extract(year from issue_date) ='2021'; --for November



/*
										  IMPORTANT NOTE
: int_rate is assigned as float data type & in Postgres ROUND() function do not work with float data type.
: to solve this issue we use syntax 
ROUND(inputvalue :: numeric, decimal places)
*/



/* Debt to Interest Ratio for month of November and December */
select round(avg(dti)::numeric,4) *100 as "average debt to interest Ratio for December" from bankdb
where extract(month from issue_date) = '12' and extract(year from issue_date) = '2021';  --for December

select round(avg(dti)::numeric,4) *100 as "average debt to interest Ratio for November" from bankdb
where extract(month from issue_date) = '11' and extract(year from issue_date) = '2021'; --for November

--very high or very low DTI is not good for customer.


                                  
								  
								     /*GOOD LOAN APPLICATIONS*/

/*Good Loan Application Percentage */
select 
(100.0 * sum(case when loan_status in ('Fully Paid', 'Current') then 1 else 0 end) / count(id) ) 
as "Percentage of Good Loan Application"
from bankdb;


/*Total Number of Good Loan Applications */
select count(id) as "Total Number of Good Loan Applications"
from bankdb where loan_status in ( 'Fully Paid' , 'Current' );


/*Good Loan Funded Amount */
select sum(loan_amount) as "Good Loan Funded Amount"
from bankdb where loan_status in ( 'Fully Paid' , 'Current' ); 


/*Good Loan Total Received Amount*/
select sum(total_payment) as "Good Loan Total Received Amount" 
from bankdb where loan_status in ( 'Fully Paid' , 'Current' );


                                        
										
										/*BAD LOAN ANALYSIS */

/*Bad Loan Application Percentage */
select 
(100.0 * sum( case when loan_status  = 'Charged Off' then 1 else 0 end ) / (count(id))) 
as "Bad Loan Application Percentage"
from bankdb;


/*Total Number of Bad Loan Applications */
select count(id) as "Total Number of Bad Loan Applications"
from bankdb where loan_status = 'Charged Off';


/*Good Loan Funded Amount */
select sum(loan_amount) as "bad Loan Funded Amount"
from bankdb where loan_status = 'Charged Off'; 


/*Good Loan Total Received Amount*/
select sum(total_payment) as "Good Loan Total Received Amount" 
from bankdb where loan_status = 'Charged Off';



                                      /*LOAN STATUS GRID VIEW */
create view loan_status_grid_view as
select
loan_status as "Loan Status",
count(id) as "Total Loan Applications",
sum(loan_amount) as "Total Funded Amount",
sum(total_payment) as "Total Amount Received",
avg(int_rate * 100) as "Averge Interest Rate",
avg(dti * 100) as "Average Debt to Interest Ratio"
from bankdb group by loan_status;

select * from loan_status_grid_view;



------------------------------------------FOR DASHBOARD : 2 ------------------------------------------------

/* run this query to see complete DB */
select * from bankdb;



/*Monthly Trends by Issue Date*/
Create view Monthly_trends as
select 
extract(month from issue_date) as "Month",
count(id) as "Total Loan Applications", 
sum(loan_amount) as "Total funded amount",
sum(total_payment) as "Total Payment Received"
from bankdb
group by "Month" Order by "Month";

select * from Monthly_trends;



/*Regional Analysis by State */
Create view Analysis_by_Region as
select 
address_state as "State",
count(id) as "Total Loan Applications", 
sum(loan_amount) as "Total funded amount",
sum(total_payment) as "Total Payment Received"
from bankdb
group by "State" Order by "State";

select * from Analysis_by_Region;



/*Loan Term Analysis */
Create view loan_term_analysis as
select 
term as "Loan Term",
count(id) as "Total Loan Applications", 
sum(loan_amount) as "Total funded amount",
sum(total_payment) as "Total Payment Received"
from bankdb
group by "Loan Term" Order by "Loan Term";

select * from loan_term_analysis;



/*Employee Length Analysis*/
Create view employee_length_analysis as
select 
emp_length as "Employee Length",
count(id) as "Total Loan Applications", 
sum(loan_amount) as "Total funded amount",
sum(total_payment) as "Total Payment Received"
from bankdb
group by emp_length Order by emp_length;

select * from employee_length_analysis;



/*Loan Purpose Breakdown*/
create view loan_purpose_breakdown as
select 
purpose as "Loan Purpose",
count(id) as "Total Loan Applications",
sum(loan_amount) as "Total funded amount",
sum(total_payment) as "Total Payment Received"
from bankdb
group by purpose order by purpose;

select * from loan_purpose_breakdown;



/*Home Ownership Analysis*/
create view home_ownership_analysis as
select 
home_ownership as "Home Ownership Status",
count(id) as "Total Loan Applications",
sum(loan_amount) as "Total funded amount",
sum(total_payment) as "Total Payment Received"
from bankdb
group by home_ownership order by home_ownership;

select * from home_ownership_analysis;


---END---