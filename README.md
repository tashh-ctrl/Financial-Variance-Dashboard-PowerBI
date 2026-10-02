# 📊 Executive Financial Analytics & Variance Dashboard

An end-to-end financial analytics solution built using **SQL Server (SSMS)**, **Power BI**, and **DAX** to analyze budget variances across Revenue, COGS, and OpEx for FY2025.

---

## 🎯 Key Business Insights Uncovered
- Identified a critical **+430.07% budget overrun** in the **Travel & Entertainment** account under Operating Expenses (OpEx).
- Analyzed cross-category metrics highlighting variance drivers across all general ledger line items.

---

## 🛠️ Tech Stack & Architecture
- **Database Architecture:** SQL Server (SSMS) — Star Schema (`ChartofAccount`, `Budget2025`, `Actuals2025`)
- **Business Intelligence:** Power BI Desktop
- **Data Modeling & Logic:** Explicit DAX Measures (`Total Actual`, `Total Budget`, `Variance %`)
- **UI/UX Design:** Dynamic Slicers, KPI Cards & Horizontal Bar Chart Layouts

---

## 🧮 Core DAX Measures
```dax
Total Actual = SUM(Actuals2025[Amount])
Total Budget = SUM(Budget2025[BudgetAmount])
Variance % = DIVIDE([Total Actual] - [Total Budget], [Total Budget], 0)
