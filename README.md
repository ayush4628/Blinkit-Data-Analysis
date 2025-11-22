# 🛒 Blinkit Data Analytics (MySQL + Excel Dashboard)

A complete analytics project combining **MySQL-based data cleaning, modeling, and SQL insights** with an **Excel PivotTable dashboard** for interactive business reporting.  
This repository delivers both **structured database analysis** and **visual Excel-based insights** for Blinkit’s retail operations.

---

## 📌 Project Overview  
This project analyzes **Blinkit outlet, product, and sales performance** using two approaches:

1. **MySQL SQL Script** – Data cleaning, transformation, fact–dimension modeling, and analytical queries.  
2. **Excel Dashboard** – KPI summary, PivotTables, PivotCharts, Top 10 insights, and outlet/category analysis.

---

## 🛠️ Tech Stack  

- 🛢️ **MySQL Workbench** – Data modeling, table creation, ETL, SQL aggregations  
- 📊 **Microsoft Excel** – Dashboard design, PivotTables, charts  
- 🔣 **SQL** – Joins, grouping, window functions, aggregations  
- 📁 **File Formats** – `.sql`, `.xlsx`, `.csv`

---

## 📊 Data Source  

**Dataset:** Blinkit retail sales dataset  

**Includes:**  
- Item details (type, fat content, weight)  
- Outlet details (size, location tier, establishment year, type)  
- Ratings & sales metrics  
- SKU-level and outlet-level performance patterns  

---

## 🌟 Features / Highlights  

### **Business Problem**  
Blinkit operates across multiple outlet types, but managers lack a unified system to analyze:  
- High-performing outlets  
- Top product categories  
- Regional performance  
- SKU revenue contribution  

### **Goal of the Project**  
- Build a **clean SQL data model**  
- Generate **standardized KPIs**  
- Create a **visual Excel dashboard**  
- Provide insights for operational and strategic decisions  

---

## 🛢️ SQL Workflow Walkthrough  

### ✔ **1. Data Cleaning (MySQL)**  
- Renamed messy column names → snake_case  
- Fixed encoding issues  
- Converted numeric and date columns  
- Removed duplicates using `ANY_VALUE()`  
- Standardized schema for analytics  

### ✔ **2. Data Modeling (Star Schema)**  

#### **🔹 item_dim**  
Stores product-level attributes  

#### **🔹 outlet_dim**  
Stores outlet-level details such as type, size, location tier  

#### **🔹 sales_fact**  
Aggregated item × outlet performance:  
- Sales amount  
- Average rating  

#### **🔹 sales_summary**  
Stores summarized KPIs for reporting  

📄 Full SQL code file:  
**Blinkit Data Analysis sql.sql**

---

## 🔍 SQL Analytics Performed  

### ✔ Total Sales & Avg Rating  
### ✔ Top 10 Outlets  
### ✔ Top 10 Items  
### ✔ Sales by Outlet Type  
### ✔ Sales by City Tier  
### ✔ Supermarket Type 1 Performance  
### ✔ Tier-3 Outlet Performance  
### ✔ KPIs stored in summary table  

---

## 📈 Excel Dashboard Walkthrough  

### ✔ **KPIs (Header Cards)**  
- **Total Sales:** ₹997,159  
- **Average Rating:** 3.96  
- **Total SKUs:** 1,555  
- **Total Outlets:** 8  

### ✔ **PivotTables Used**  
- Top 10 Outlets by Sales  
- Top 10 Items by Sales  
- Sales by Outlet Type  
- Supermarket Type 1 Contribution  
- Tier 3 Outlet Performance  

### ✔ **Excel Functions Used**  
- `SUMIFS()`  
- `VLOOKUP()`  
- `FILTER()`  
- `GETPIVOTDATA()`  

### ✔ **Visualizations**  
- Column Charts  
- Bar Charts  
- KPI Cards  
- Insight summaries  

---

## 📉 Key Insights  

### 🔹 **Top Outlets**  
- OUT035  
- OUT046  
- OUT013  
- OUT018  
- OUT045  

### 🔹 **Top Products**  
- FDL58  
- FDP28  
- FDB15  

### 🔹 **Strongest Outlet Type**  
**Supermarket Type 1** has the highest revenue contribution  

### 🔹 **Tier-3 Performance**  
Outlets like **OUT013, OUT018, OUT010** show strong sales  

### 🔹 **Overall Metrics**  
- Total revenue nearly **₹10 lakh**  
- **1,555** unique SKUs  
- **8** operational outlets  

---

## 📬 Contact
📧 Email: [mauryaayush7377@gmail.com](mailto:mauryaayush7377@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/ayush4628)



