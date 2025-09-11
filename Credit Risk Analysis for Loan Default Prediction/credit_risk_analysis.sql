# create a copy of raw dataset
CREATE TABLE credit_risk.credit_data_cleaned AS
SELECT * FROM credit_risk.ccredit_risk_analysis;

# Check for Missing Values
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN LIMIT_BAL IS NULL THEN 1 ELSE 0 END) AS missing_limit_bal,
    SUM(CASE WHEN SEX IS NULL THEN 1 ELSE 0 END) AS missing_sex,
    SUM(CASE WHEN EDUCATION IS NULL THEN 1 ELSE 0 END) AS missing_education,
    SUM(CASE WHEN MARRIAGE IS NULL THEN 1 ELSE 0 END) AS missing_marriage,
    SUM(CASE WHEN AGE IS NULL THEN 1 ELSE 0 END) AS missing_age
FROM credit_risk.credit_data_cleaned;

# Set Defaults for Non-Critical Variables
# setting the unknown education to a default value
update credit_risk.credit_data_cleaned
set EDUCATION = 4
where EDUCATION in (0,5,6);

#setting the unknown marriage to a default value
update credit_risk.credit_data_cleaned
set MARRIAGE = 3
where MARRIAGE not in (1,2,3);

# Fix Incorrect Data Entries
# Fix AGE Outliers (Example: AGE < 18 or AGE > 100 are invalid)
DELETE FROM credit_risk.credit_data_cleaned
WHERE AGE < 18 OR AGE > 100;

#Fix SEX Values
update credit_risk.credit_data_cleaned
set SEX = 2
where SEX not in (1,2);

# Remove Duplicate Records
DELETE FROM credit_risk.credit_data_cleaned
WHERE ID NOT IN (
    SELECT MIN(ID)
    FROM credit_risk.credit_data_cleaned
    GROUP BY ID
);

# Replace EDUCATION Column with Descriptive Text
Alter table credit_risk.credit_data_cleaned
ADD column education_desc varchar(50);

update credit_risk.credit_data_cleaned
set education_desc = case
	when EDUCATION = 1 then 'Graduate School'
    when EDUCATION = 2 then 'University'
    when EDUCATION = 3 then 'High School'
    when EDUCATION = 4 then 'Others'
    else 'Unknown'
    end;

# Replace Sex and Marriage Column with Descriptive Text
Alter table credit_risk.credit_data_cleaned
add column sex_desc varchar(50),
add column marriage_desc varchar(50);

update credit_risk.credit_data_cleaned
set sex_desc = case 
    when SEX = 1 then 'Male'
    when SEX = 2 then 'Female'
    else 'Unknown'
    end;
    
update credit_risk.credit_data_cleaned
set marriage_desc = case
    when MARRIAGE = 1 then 'Married'
    when MARRIAGE = 2 then 'Single'
    when MARRIAGE = 3 then 'Others'
    else ' Unknown'
    end;

# Replace default_pay_next_payment Column with Descriptive Text
Alter table credit_risk.credit_data_cleaned
add column default_pay_next_payment varchar(50);

update credit_risk.credit_data_cleaned
set default_pay_next_payment = case
	when `default.payment.next.month` = 1 then 'Yes'
    when `default.payment.next.month` = 0 then 'No'
    else 'Unknown'
    end;

# Add age_bucket Column
ALTER TABLE credit_risk.credit_data_cleaned
ADD COLUMN age_bucket VARCHAR(20);

UPDATE credit_risk.credit_data_cleaned
SET age_bucket = CASE
    WHEN AGE < 30 THEN '<30'
    WHEN AGE BETWEEN 30 AND 45 THEN '30-45'
    WHEN AGE BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
END;


# Calculate Total Bill Amount and Total Payment
Alter table credit_risk.credit_data_cleaned
add column total_bill_amt numeric,
add column total_pay_amt numeric;

update credit_risk.credit_data_cleaned
set 
total_bill_amt = BILL_AMT1+BILL_AMT2+BILL_AMT3+BILL_AMT4+BILL_AMT5+BILL_AMT6,
total_pay_amt = PAY_AMT1+PAY_AMT2+PAY_AMT3+PAY_AMT4+PAY_AMT5+PAY_AMT6;

# Calculate Average Delay
Alter table credit_risk.credit_data_cleaned	
add column avg_pay_delay numeric;

update credit_risk.credit_data_cleaned
set avg_pay_delay = (PAY_AMT1+PAY_AMT2+PAY_AMT3+PAY_AMT4+PAY_AMT5+PAY_AMT6)/6;
 
# data analysis or modeling
# Distribution of Loan Amount (LIMIT_BAL)
SELECT 
    LIMIT_BAL,
    COUNT(*) AS frequency
FROM credit_risk.credit_data_cleaned
GROUP BY LIMIT_BAL
ORDER BY frequency desc;

# Distribution of Income (Assuming column exists like INCOME)
SELECT
    AGE,
    COUNT(*) AS frequency
FROM credit_risk.credit_data_cleaned
GROUP BY AGE
ORDER BY frequency desc;

# Credit History (Average Pay Delay)
SELECT 
    avg_pay_delay,
    COUNT(*) AS frequency
FROM credit_risk.credit_data_cleaned
GROUP BY avg_pay_delay
ORDER BY frequency desc;

# Correlation with Default Status
SELECT 
    default_pay_next_payment,
    AVG(LIMIT_BAL) AS avg_limit_bal,
    AVG(avg_pay_delay) AS avg_pay_delay,
    AVG(total_bill_amt) AS avg_bill_amt,
    AVG(total_pay_amt) AS avg_pay_amt
FROM credit_risk.credit_data_cleaned
GROUP BY default_pay_next_payment;

# Default Rate by Age Bucket
SELECT 
    age_bucket,
    COUNT(ID) AS total_customers,
    SUM(`default.payment.next.month`) AS total_defaults,
    (SUM(`default.payment.next.month`)/COUNT(*)*100) AS default_rate
FROM credit_risk.credit_data_cleaned
GROUP BY age_bucket
ORDER BY age_bucket;

# Default Rate by Education Level
SELECT 
    education_desc,
    COUNT(*) AS total_customers,
    SUM(`default.payment.next.month`) AS total_defaults,
    (SUM(`default.payment.next.month`)/COUNT(*)*100) AS default_rate
FROM credit_risk.credit_data_cleaned
GROUP BY education_desc
ORDER BY total_defaults DESC;

# Correlation between LIMIT_BAL and avg_pay_delay vs. default_payment
SELECT 
    (AVG(LIMIT_BAL * avg_pay_delay) - AVG(LIMIT_BAL) * AVG(avg_pay_delay)) /
    (STDDEV_POP(LIMIT_BAL) * STDDEV_POP(avg_pay_delay)) AS corr_limit_paydelay
FROM credit_risk.credit_data_cleaned;

# Identify High-Risk Customer Segments
SELECT 
    age_bucket,
    education_desc,
    marriage_desc,
    AVG(avg_pay_delay) AS avg_delay,
    AVG(LIMIT_BAL) AS avg_credit_limit,
    AVG(`default.payment.next.month`) AS default_rate
FROM credit_risk.credit_data_cleaned
GROUP BY age_bucket, education_desc, marriage_desc
HAVING AVG(`default.payment.next.month`) > 0.4  -- Example threshold for high risk
ORDER BY default_rate DESC;











