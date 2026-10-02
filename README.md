# 📊 Executive Financial Analytics & Variance Dashboard

An end-to-end financial analytics solution built using **SQL Server (SSMS)**, **Power BI**, and **DAX** to analyze budget variances across Revenue, COGS, and OpEx for FY2025.

---

## 🎯 Key Business Insight Uncovered
- Identified a massive **+430.07% budget overrun** in the **Travel & Entertainment** account under Operating Expenses (OpEx).
- Overall company variance stood at **-60.50%**, highlighting critical areas for cost control and re-budgeting.

---

## 🛠️ Tech Stack & Skills
- **Database Architecture:** SQL Server (SSMS) - Star Schema Design
- **Business Intelligence:** Power BI Desktop
- **Data Modeling:** Explicit DAX Measures & Relationships
- **UI/UX Design:** Executive Dashboard Formatting, Dynamic Slicers & Visual Hierarchy

---

## 📐 Data Architecture (Star Schema)
The reporting layer is built on a Star Schema model linking three core tables via `GLCode`:
- **`ChartofAccount`** (Dimension Table: Categories, Sub-categories, Account Names)
- **`Actuals2025`** (Fact Table: Actual Financial Transactions)
- **`Budget2025`** (Fact Table: Allocated Budget Amounts)

---

## 🧮 DAX Measures
Explicit DAX logic was used to build dynamic indicators:

```dax
Total Actual = SUM(Actuals2025[ActualAmount])
Total Budget = SUM(Budget2025[BudgetAmount])
Variance % = DIVIDE([Total Actual] - [Total Budget], [Total Budget], 0)
