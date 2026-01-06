create database bankloans;

use bankloans;

CREATE TABLE bankloan_data (
  `State Abbr` VARCHAR(20),
  `Account ID` VARCHAR(22),
  `Age` VARCHAR(15),
  `BH No` INT,
  `BH Name` VARCHAR(34),
  `Bank Name` VARCHAR(17),
  `Branch Name` VARCHAR(28),
  `Caste` VARCHAR(18),
  `Center Id` INT,
  `City` VARCHAR(28),
  `Client id` INT,
  `Client Name` VARCHAR(25),
  `Close Client` VARCHAR(13),
  `Closed Date.1` VARCHAR(20),
  `Closed time` DATETIME,
  `Credif Officer Name` VARCHAR(39),
  `Dateof Birth` VARCHAR(20),
  `Disb By` VARCHAR(39),
  `Disbursement Date` VARCHAR(20),
  `Disbursement Date (Years)` VARCHAR(17),
  `Gender ID` VARCHAR(16),
  `Home Ownership` VARCHAR(18),
  `Loan Status` VARCHAR(28),
  `Loan Transferdate` VARCHAR(12),
  `NextMeetingDate` varchar(20),
  `Product Code` VARCHAR(13),
  `Grade` VARCHAR(11),
  `Sub Grade` VARCHAR(12),
  `Product Id` VARCHAR(16),
  `Purpose Category` VARCHAR(35),
  `Region Name` VARCHAR(21),
  `Religion` VARCHAR(19),
  `Verification Status` VARCHAR(25),
  `State Name` VARCHAR(26),
  `Tranfer Logic` VARCHAR(26),
  `Is Delinquent Loan` VARCHAR(11),
  `Is Default Loan` VARCHAR(11),
  `Age _T` INT,
  `Delinq 2 Yrs` INT,
  `Application Type` VARCHAR(20),
  `Loan Amount` INT,
  `Funded Amount` INT,
  `Funded Amount Inv` DOUBLE,
  `Term` VARCHAR(19),
  `Int Rate` DOUBLE,
  `Total Pymnt` DOUBLE,
  `Total Pymnt inv` DOUBLE,
  `Total Rec Prncp` DOUBLE,
  `Total Fees` DOUBLE,
  `Total Rrec int` DOUBLE,
  `Total Rec Late fee` DOUBLE,
  `Recoveries` DOUBLE,
  `Collection Recovery fee` DOUBLE
);
ALTER TABLE bankloan_data MODIFY `Closed time` VARCHAR(20);
ALTER TABLE bankloan_data MODIFY `NextMeetingDate` VARCHAR(20);
ALTER TABLE bankloan_data MODIFY `BH No` INT NULL;
ALTER TABLE bankloan_data 
  MODIFY `BH No` VARCHAR(20),
  MODIFY `NextMeetingDate` VARCHAR(20),
  MODIFY `Closed time` VARCHAR(20);


select * from bankloan_data;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bank Analytics csv.csv'
INTO TABLE bankloan_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
  `State Abbr`,
  `Account ID`,
  `Age`,
  `BH No`,
  `BH Name`,
  `Bank Name`,
  `Branch Name`,
  `Caste`,
  `Center Id`,
  `City`,
  `Client id`,
  `Client Name`,
  `Close Client`,
  `Closed Date.1`,
  `Closed time`,
  `Credif Officer Name`,
  `Dateof Birth`,
  `Disb By`,
  `Disbursement Date`,
  `Disbursement Date (Years)`,
  `Gender ID`,
  `Home Ownership`,
  `Loan Status`,
  `Loan Transferdate`,
  `NextMeetingDate`,
  `Product Code`,
  `Grade`,
  `Sub Grade`,
  `Product Id`,
  `Purpose Category`,
  `Region Name`,
  `Religion`,
  `Verification Status`,
  `State Name`,
  `Tranfer Logic`,
  `Is Delinquent Loan`,
  `Is Default Loan`,
  `Age _T`,
  `Delinq 2 Yrs`,
  `Application Type`,
  `Loan Amount`,
  `Funded Amount`,
  `Funded Amount Inv`,
  `Term`,
  `Int Rate`,
  `Total Pymnt`,
  `Total Pymnt inv`,
  `Total Rec Prncp`,
  `Total Fees`,
  `Total Rrec int`,
  `Total Rec Late fee`,
  `Recoveries`,
  `Collection Recovery fee`
);
SELECT COUNT(*) FROM bankloan_data;
select * from bankloan_data;

-- -------------------
-- Total Loan Amount Funded

SELECT SUM(`Funded Amount`) AS Total_Loan_Funded
FROM bankloan_data;

-- --------------------
-- Total Loans (Count)

SELECT COUNT(*) AS Total_Loans
FROM bankloan_data;

-- -----------------
-- Total Collection (Principal + Interest)

SELECT SUM(`Total Pymnt`) AS Total_Collection
FROM bankloan_data;

-- --------------- 
-- Total Interest Earned

SELECT SUM(`Total Rrec int`) AS Total_Interest
FROM bankloan_data;

-- ---------------
-- Branch-Wise Performance (Interest, Fees, Total)

SELECT 
  `Branch Name`,
  SUM(`Total Rrec int`) AS Interest_Revenue,
  SUM(`Total Fees`) AS Fee_Revenue,
  SUM(`Total Rrec int` + `Total Fees`) AS Total_Revenue
FROM bankloan_data
GROUP BY `Branch Name`
ORDER BY Total_Revenue DESC;

-- ------- --- --- --- --
-- State-Wise Loan Distribution

SELECT 
  `State Name`,
  SUM(`Funded Amount`) AS Total_Loan_Amount,
  COUNT(*) AS Loan_Count
FROM bankloan_data
GROUP BY `State Name`
ORDER BY Total_Loan_Amount DESC;

-- ----------------
-- Religion-Wise Loan

SELECT 
  `Religion`,
  SUM(`Funded Amount`) AS Total_Loan_Amount,
  COUNT(*) AS Loan_Count
FROM bankloan_data
GROUP BY `Religion`
ORDER BY Total_Loan_Amount DESC;

-- ---------------
-- Age Group-Wise Loan

SELECT 
  CASE
    WHEN `Age _T` < 25 THEN 'Below 25'
    WHEN `Age _T` BETWEEN 25 AND 35 THEN '25-35'
    WHEN `Age _T` BETWEEN 36 AND 45 THEN '36-45'
    WHEN `Age _T` BETWEEN 46 AND 60 THEN '46-60'
    ELSE 'Above 60'
  END AS Age_Group,
  COUNT(*) AS Loan_Count,
  SUM(`Funded Amount`) AS Total_Loan_Amount
FROM bankloan_data
GROUP BY Age_Group
ORDER BY Total_Loan_Amount DESC;

-- ------------- -- --
-- Disbursement Trend (by year)

SELECT 
  YEAR(STR_TO_DATE(`Disbursement Date`, '%m/%d/%Y')) AS Year,
  SUM(`Funded Amount`) AS Total_Loan_Amount
FROM bankloan_data
GROUP BY Year
ORDER BY Year;




