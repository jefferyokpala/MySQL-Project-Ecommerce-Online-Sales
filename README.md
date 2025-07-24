# MySQL-Project-Ecommerce-Online-Sales

# Overview

SQL-based data analysis of ecommerce online sales dataset. The dataset contains 8 columns and 541,910 rows. it contains the following columns: invoice number, stock code, description, quantity, invoice date, unit price, customerID, and country. They provide information on the customers shopping at the ecommerce store and the items they bought. 

# Data Source

I obtained the dataset from Kaggle, and it can be found here.

# Business Task

Data cleaning, feature engineering, and exploratory data analysis of Online ecommerce sales data using MySQL Workbench

# Tools

MySQL WorkBench

# Process

I downloaded the dataset and opened it on Microsoft Excel to scan through and gather some insight on the information it contains and discover the patterns that exist in it. However, I noticed the data was dirty. Several columns had wrong values and data placed in them that were supposed to be in other columns. For example, there were strings in columns meant for integers. There were also blank values in the rows of some columns.

I determined that the dataset needed to be cleaned in MySQL Workbench before analysis. Therefore, I closed Microsoft Excel and opened MySQL Workbench and created a database to import the dataset into.

I created the database and a sales table, and assigned a VARCHAR data type to all columns because they were dirty and a mix of numbers and strings. Without doing that, data would have been truncated while importing it, and I would not be able to analyse the entire dataset.
