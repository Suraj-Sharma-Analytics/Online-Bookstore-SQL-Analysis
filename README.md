# 📚 Online Bookstore SQL Data Analysis

## 📌 Project Overview

This project analyzes an online bookstore database using PostgreSQL to
answer 20 business-oriented questions related to books, sales, revenue,
customer behavior, and inventory.

The project demonstrates practical SQL skills used in data analysis,
including data aggregation, joins, filtering, Common Table Expressions
(CTEs), window functions, ranking, and customer segmentation.

---

## 🎯 Project Objectives

The main objectives of this project are to:

- Analyze bookstore sales and revenue performance
- Identify top-performing books and genres
- Understand customer purchasing behavior
- Analyze customer spending patterns
- Evaluate estimated remaining inventory
- Identify books with low remaining stock
- Rank books within their respective genres
- Calculate revenue contribution by genre
- Segment customers based on total spending
- Identify customers belonging to the top 10% of spenders

---

## 🛠️ Tools & Technologies

- **PostgreSQL**
- **SQL**
- **CSV**
- **GitHub**
- **Excel** — for presenting SQL query results

---

## 📊 Dataset

The project contains three datasets:

### Books

Contains information about books, including:

- Book ID
- Title
- Author
- Genre
- Published Year
- Price
- Stock

### Customers

Contains customer information, including:

- Customer ID
- Name
- Email
- Phone
- City
- Country

### Orders

Contains order information, including:

- Order ID
- Customer ID
- Book ID
- Order Date
- Quantity
- Total Amount

Each dataset contains 500 records.

---

## 🔎 Business Questions & Analysis

### 1. Basic Data Exploration

**Q1.** What are the available book genres?

**Q2.** How many books are available in each genre?

**Q3.** What are the most expensive books?

**Q4.** How many customers are registered in each city?

### 2. Sales & Revenue Analysis

**Q5.** What is the total revenue generated from all orders?

**Q6.** What is the total quantity of books sold?

**Q7.** Which genres generate the highest sales revenue?

**Q8.** Which books have generated the highest revenue?

**Q9.** What is the average order value?

**Q10.** Which customers have spent the most in total?

### 3. Customer Behaviour

**Q11.** Which customers have placed more than one order?

**Q12.** Which customers have spent more than $30 in total?

**Q13.** Which cities have customers whose total spending exceeds $30?

**Q14.** Which customers purchased more than one book in total?

### 4. Inventory Analysis

**Q15.** What is the estimated remaining stock after recorded sales?

**Q16.** Which books have low remaining stock (10 or fewer)?

### 5. Advanced SQL Analysis

**Q17.** Rank books by revenue within each genre.

**Q18.** What percentage of total revenue comes from each genre?

**Q19.** Segment customers based on total spending.

**Q20.** Which customers are in the top 10% by total spending?

---

## 💡 SQL Skills Demonstrated

This project demonstrates the following SQL concepts:

### Data Retrieval & Filtering
- SELECT
- WHERE
- DISTINCT
- ORDER BY
- LIMIT

### Aggregation
- COUNT()
- SUM()
- AVG()
- GROUP BY
- HAVING

### Joins
- INNER JOIN
- LEFT JOIN

### Advanced SQL
- Common Table Expressions (CTEs)
- CASE WHEN
- COALESCE
- GREATEST
- Window Functions
- RANK()
- NTILE()

---

## 📈 Analysis Highlights

The analysis focuses on several important business areas:

- Revenue generated across different book genres
- Top-performing books based on revenue
- Customer spending and purchasing frequency
- Customer segmentation based on spending
- Top 10% of customers by total spending
- Estimated inventory remaining after recorded sales
- Identification of books with low remaining stock
- Revenue contribution of individual genres

Detailed query results are available in the `results` folder.

---

## 📁 Project Structure

```text
Online-Bookstore-SQL-Analysis/
│
├── README.md
│
├── sql/
│   └── Online_Bookstore_SQL_Project.sql
│
├── data/
│   ├── Books.csv
│   ├── Customers.csv
│   └── orders.csv
│
└── results/
    └── SQL_Analysis_Results.xlsx

▶️ How to Run the Project
1. Create a PostgreSQL database

Create a new database in PostgreSQL or pgAdmin.

2. Open the SQL project

Open:

sql/Online_Bookstore_SQL_Project.sql
3. Make sure the datasets are available

The SQL script loads the datasets from the data folder using PostgreSQL \COPY.

4. Run the SQL script

Execute the script in a PostgreSQL environment.

The script will:

Create the Books table
Create the Customers table
Create the Orders table
Load the CSV datasets
Execute 20 analytical SQL queries
📂 Results

The complete outputs of the 20 SQL questions are available in:

results/SQL_Analysis_Results.xlsx

The workbook contains:

A Summary sheet
Individual result sheets for Q01–Q20
Complete query outputs, including queries returning hundreds of rows
🧠 Key Takeaway

This project demonstrates how SQL can be used to transform structured
business data into useful insights related to sales, customers, revenue,
and inventory.

The analysis progresses from basic SQL queries to advanced techniques
such as CTEs, window functions, ranking, revenue contribution analysis,
and customer segmentation.

👤 Author

Suraj Sharma

Aspiring Data Analyst

Connect with me
GitHub: [Suraj Sharma](https://github.com/Suraj-Sharma-Analytics)