# E-Commerce Sales Data Analysis using SQL

## Project Overview

This project analyzes e-commerce sales data using **MySQL** to generate meaningful business insights from raw transactional data.

The project covers data cleaning, database preparation, business analysis, and SQL-based reporting. The main goal is to transform raw sales data into useful information that can help understand sales performance, customer behavior, product performance, and business trends.

## Objectives

* Clean and prepare raw e-commerce sales data
* Store and manage the data using MySQL
* Analyze sales and transaction performance
* Identify top-performing products and categories
* Analyze sales trends over time
* Understand customer purchasing patterns
* Generate business insights using SQL

## Tools & Technologies

* **MySQL**
* **SQL**
* **MySQL Workbench**
* **VS Code**
* **Git & GitHub**

## Project Structure

```text
Ecommerce-SQL-Analysis/
│
├── data/
│   └── raw_ecommerce_sales.csv
│
├── sql/
│   ├── 01_data_cleaning.sql
│   ├── 02_database_setup.sql
│   └── 03_business_analysis.sql
│
└── README.md
```

## SQL Analysis

The project is divided into three main stages:

### 1. Data Cleaning

The raw dataset was cleaned and prepared for analysis by handling:

* Missing values
* Incorrect data formats
* Duplicate or inconsistent records
* Date formatting
* Numeric data type conversion
* Invalid or inconsistent values

### 2. Database Setup

The cleaned data was imported into MySQL and organized into tables suitable for analysis.

SQL operations used include:

* `CREATE TABLE`
* `INSERT`
* `ALTER TABLE`
* `UPDATE`
* `SELECT`

### 3. Business Analysis

The final analysis uses SQL to answer practical business questions such as:

* What is the total revenue?
* Which products generate the highest revenue?
* Which categories perform best?
* How does sales performance change over time?
* Which payment methods are most commonly used?
* What are the key sales trends?
* Which products or categories require further attention?

SQL concepts used include:

* Filtering with `WHERE`
* Aggregation with `SUM()`, `AVG()`, `COUNT()`, and `MAX()`
* `GROUP BY`
* `ORDER BY`
* `CASE`
* `JOIN`
* Subqueries
* Common Table Expressions (CTEs)
* Date-based analysis
* Window functions where required

## Key Skills Demonstrated

This project demonstrates practical experience with:

* SQL data cleaning
* Relational databases
* Data transformation
* Exploratory data analysis using SQL
* Business-oriented problem solving
* Writing analytical SQL queries
* Extracting insights from transactional data

## How to Run the Project

1. Install MySQL and MySQL Workbench.
2. Download or clone this repository.
3. Import the raw dataset from the `data` folder.
4. Run the SQL files in the following order:

```text
01_data_cleaning.sql
02_database_setup.sql
03_business_analysis.sql
```

5. Review the output of the business analysis queries.

## Project Outcome

The project demonstrates how SQL can be used to move from raw transactional data to meaningful business insights. It focuses on practical data analysis rather than only writing individual SQL queries.

## Author

**Shradha Patil**
BCA Student | Aspiring Data Scientist

GitHub: [Shradha Patil](https://github.com/shradhapatil702-droid)
