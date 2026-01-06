-- Project: Credit and Debit Analytics SQL
-- Group: 6


--  View the Dataset
SELECT 
    *
FROM
    `debit and credit banking_data`
LIMIT 100;

--  Understand Table Structure
DESCRIBE `debit and credit banking_data`;


-- 1️ Total Credit Amount 
SELECT 
    CONCAT(ROUND(SUM(Amount) / 1000000, 2), 'M') AS Total_Credit_Amount_Million
FROM `debit and credit banking_data`
WHERE `Transaction Type` = 'Credit';


-- 2️ Total Debit Amount 
SELECT 
    CONCAT(ROUND(SUM(Amount) / 1000000, 2), 'M') AS Total_Debit_Amount_Million
FROM `debit and credit banking_data`
WHERE `Transaction Type` = 'Debit';


-- 3️ Credit-to-Debit Ratio
SELECT 
    ROUND(
        SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) /
        SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END),
    2) AS Credit_to_Debit_Ratio
FROM `debit and credit banking_data`;


-- 4️ Net Transaction Amount 
SELECT 
    ROUND(ABS(
        SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) -
        SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END)
    ), 2) AS Net_Transaction_Amount
FROM `debit and credit banking_data`;

-- In Million 
SELECT 
    CONCAT(ROUND((
        SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END) -
        SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END)
    ) / 1000000, 2), 'M') AS Net_Transaction_Amount_Million
FROM `debit and credit banking_data`;


-- 5️ Average Account Balance
SELECT 
    ROUND(AVG(Balance), 2) AS Avg_Account_Balance
FROM `debit and credit banking_data`;


-- 6️ Average Transaction Value
SELECT 
    ROUND(AVG(Amount), 2) AS Avg_Transaction_Value
FROM `debit and credit banking_data`;

-- 7️ Bank-wise Total Transaction Amount 
SELECT 
    `Bank Name`,
    CONCAT(ROUND(SUM(Amount) / 1000000, 2), 'M') AS Total_Transaction_Amount_Million
FROM `debit and credit banking_data`
GROUP BY `Bank Name`
ORDER BY Total_Transaction_Amount_Million DESC;


-- 8️ Branch-wise Total Transaction Amount 
SELECT 
    `Branch`,
    CONCAT(ROUND(SUM(Amount) / 1000000, 2), 'M') AS Total_Transaction_Amount_Million
FROM `debit and credit banking_data`
GROUP BY `Branch`
ORDER BY Total_Transaction_Amount_Million DESC;

-- 9️ Branch-wise Transaction Amount per Bank
SELECT 
    `Branch`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'Kotak Mahindra Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `Kotak Mahindra Bank`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'Punjab National Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `Punjab National Bank`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'ICICI Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `ICICI Bank`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'Axis Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `Axis Bank`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'State Bank of India' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `State Bank of India`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'HDFC Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `HDFC Bank`
FROM `debit and credit banking_data`
GROUP BY `Branch`
ORDER BY 
    (SUM(Amount)) DESC;



-- 10 Transaction Method Summary
SELECT 
    `Transaction Method`,
    COUNT(*) AS Total_Transactions
FROM `debit and credit banking_data`
GROUP BY `Transaction Method`
ORDER BY Total_Transactions DESC;


-- 11 Account Activity Ratio (Customer-wise)
SELECT 
    `Customer ID`,
    COUNT(*) AS Total_Transactions,
    ROUND(MAX(Balance), 2) AS Current_Balance,
    ROUND(COUNT(*) / MAX(Balance), 2) AS Account_Activity_Ratio
FROM `debit and credit banking_data`
GROUP BY `Customer ID`;


-- 1️2 High-Risk Transaction Flag (Transaction Over 100000)
SELECT 
    *,
    CASE 
        WHEN Amount > 100000 THEN 'High-Risk'
        ELSE 'Normal'
    END AS Risk_Flag
FROM `debit and credit banking_data`;


-- 1️3 Monthly Transaction Amounts per Bank
    
    SELECT 
    DATE_FORMAT(STR_TO_DATE(`Transaction Date`, '%d/%m/%y'), '%Y-%m') AS Month,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'Kotak Mahindra Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `Kotak Mahindra Bank`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'Punjab National Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `Punjab National Bank`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'ICICI Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `ICICI Bank`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'Axis Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `Axis Bank`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'State Bank of India' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `State Bank of India`,
    CONCAT(ROUND(SUM(CASE WHEN `Bank Name` = 'HDFC Bank' THEN Amount ELSE 0 END) / 1000000, 2), 'M') AS `HDFC Bank`
FROM `debit and credit banking_data`
GROUP BY DATE_FORMAT(STR_TO_DATE(`Transaction Date`, '%d/%m/%y'), '%Y-%m')
ORDER BY DATE_FORMAT(STR_TO_DATE(`Transaction Date`, '%d/%m/%y'), '%Y-%m');
