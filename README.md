# 📊 Sales Performance Dashboard

## Project Overview
An end-to-end sales analytics solution analyzing 3 years of transactional data across regions, products, and sales reps. Built to demonstrate MIS reporting, SQL analysis, Excel modeling, and Power BI dashboarding skills.

## 🎯 Business Problem
The sales team lacked visibility into regional performance, product profitability, and rep-level KPIs. This project delivers a self-service analytics layer for monthly executive reporting.

## 🔑 Key Insights
- **Northeast region** contributes 38% of total revenue but has the highest discount rate (18%)
- **Technology category** shows 32% YOY growth vs 8% for Furniture
- **Top 10 customers** account for 42% of total revenue — concentration risk
- Q4 consistently outperforms other quarters by 28% — seasonal trend confirmed
- 3 sales reps below target for 2 consecutive quarters — flagged for action

## 🛠️ Tools & Technologies
| Tool | Purpose |
|------|---------|
| SQL (MySQL/PostgreSQL) | Data extraction, transformation, KPI calculation |
| Excel | Pivot tables, KPI dashboard, Power Query ETL |
| Power BI | Interactive 3-page executive dashboard |
| Python (optional) | Data cleaning & generation |

## 📁 Folder Structure
```
sales-performance-dashboard/
│
├── data/
│   ├── sales_data.csv          # Raw transactional data (50K rows)
│   ├── customers.csv           # Customer master
│   ├── products.csv            # Product catalogue
│   └── data_dictionary.md      # Column definitions
│
├── sql/
│   ├── 01_create_tables.sql    # Schema setup
│   ├── 02_kpi_queries.sql      # Core KPI calculations
│   ├── 03_regional_analysis.sql
│   ├── 04_product_analysis.sql
│   ├── 05_rep_performance.sql
│   └── 06_yoy_growth.sql
│
├── excel/
│   └── Sales_Dashboard.xlsx    # Full Excel workbook (pivot + KPIs)
│
├── powerbi/
│   ├── Sales_Dashboard.pbix    # Power BI report file
│   ├── dax_measures.md         # All DAX measures documented
│   └── screenshots/            # Dashboard screenshots
│
├── reports/
│   └── Monthly_MIS_Report_Template.xlsx
│
└── docs/
    ├── methodology.md
    └── setup_instructions.md
```

## 📸 Dashboard Preview
*(Add Power BI screenshots here after publishing)*

## 🚀 How to Use
1. Download `data/sales_data.csv`
2. Run `sql/01_create_tables.sql` to set up schema
3. Run queries 02–06 for analysis
4. Open `excel/Sales_Dashboard.xlsx` — data already loaded
5. Open `powerbi/Sales_Dashboard.pbix` — connect to your data source

## 📞 Contact
**[Raju Vaddepalli]** | [linkedin.com/in/raju-vaddepalli] | [rajuvaddepalli1999@gmail.com]
