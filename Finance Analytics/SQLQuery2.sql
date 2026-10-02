-- ========================================================
-- FINANCIAL ANALYTICS & VARIANCE REPORTING - CLEANED PRODUCTION SCRIPT
-- ========================================================

-- 1. FORCE DROP EXISTING TABLES WITH FOREIGN KEYS FIRST
IF OBJECT_ID('Actuals2025', 'U') IS NOT NULL DROP TABLE Actuals2025;
IF OBJECT_ID('Budget2025', 'U') IS NOT NULL DROP TABLE Budget2025;
IF OBJECT_ID('ChartofAccount', 'U') IS NOT NULL DROP TABLE ChartofAccount;
GO

-- 2. DIMENSION TABLE: Chart of Accounts
CREATE TABLE ChartofAccount (
    GLCode INT PRIMARY KEY,
    AccountName VARCHAR(100),
    Category VARCHAR(50),
    SubCategory VARCHAR(50)
);
GO

-- 3. FACT TABLE: Budget 2025
CREATE TABLE Budget2025 (
    BTID INT PRIMARY KEY IDENTITY(1,1),
    PeriodDate DATE,
    GLCode INT FOREIGN KEY REFERENCES ChartofAccount(GLCode),
    BudgetAmount DECIMAL(18,2)
);
GO

-- 4. FACT TABLE: Actuals 2025
CREATE TABLE Actuals2025 (
    ATID INT PRIMARY KEY IDENTITY(1,1),
    ATDATE DATE,
    GLCode INT FOREIGN KEY REFERENCES ChartofAccount(GLCode),
    Amount DECIMAL(18,2)
);
GO

-- ========================================================
-- 5. DATA INSERTION
-- ========================================================

-- Insert Dimensions
INSERT INTO ChartofAccount (GLCode, AccountName, Category, SubCategory) VALUES
(101, 'Product Sales', 'Revenue', 'Operating Revenue'),
(102, 'SaaS Subscriptions', 'Revenue', 'Operating Revenue'),
(201, 'Employee Salaries & Perks', 'OpEx', 'Payroll'),
(202, 'Consulting Services', 'OpEx', 'Professional Services'),
(203, 'Cloud Infrastructure (AWS/Azure)', 'OpEx', 'IT & Tech'),
(204, 'Digital Marketing & Ads', 'OpEx', 'Marketing'),
(205, 'Office Rent & Utilities', 'OpEx', 'Facilities'),
(206, 'Third-Party Software Licenses', 'OpEx', 'IT & Tech'),
(207, 'Travel & Entertainment', 'OpEx', 'General Admin');

-- Insert Budget Entries
INSERT INTO Budget2025 (PeriodDate, GLCode, BudgetAmount) VALUES
('2025-01-01', 101, 2400000.00),
('2025-01-01', 102, 1450000.00),
('2025-01-01', 201, 1320000.00),
('2025-01-01', 202, 450000.00),
('2025-01-01', 203, 400000.00),
('2025-01-01', 204, 350000.00),
('2025-01-01', 205, 280000.00),
('2025-01-01', 206, 200000.00),
('2025-01-01', 207, 113192.60);

-- Insert Actual Transaction Entries
INSERT INTO Actuals2025 (ATDATE, GLCode, Amount) VALUES
('2025-03-31', 101, 3070000.00),
('2025-03-31', 102, 1990000.00),
('2025-03-31', 201, 1830000.00),
('2025-03-31', 202, 720000.00),
('2025-03-31', 203, 610000.00),
('2025-03-31', 204, 490000.00),
('2025-03-31', 205, 400000.00),
('2025-03-31', 206, 290000.00),
('2025-03-31', 207, 600000.00);
GO

-- ========================================================
-- 6. EXECUTION PROOF: ANALYTICAL VARIANCE QUERY
-- ========================================================

SELECT 
    c.Category,
    c.AccountName,
    SUM(b.BudgetAmount) AS Total_Budget,
    SUM(a.Amount) AS Total_Actual,
    (SUM(a.Amount) - SUM(b.BudgetAmount)) AS Variance_Amount,
    ROUND(((SUM(a.Amount) - SUM(b.BudgetAmount)) / SUM(b.BudgetAmount)) * 100, 2) AS Variance_Percentage
FROM ChartofAccount c
JOIN Budget2025 b ON c.GLCode = b.GLCode
JOIN Actuals2025 a ON c.GLCode = a.GLCode
GROUP BY c.Category, c.AccountName
ORDER BY Variance_Percentage DESC;