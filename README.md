# MySQL-Project-Ecommerce-Online-Sales

Online ecommerce sales data

Data cleaning, feature engineering, and exploratory data analysis using MySQL Workbench

I was working with a dataset of 8 columns and 541,910 rows. I obtained the dataset from Kaggle, and it can be found here.

The dataset contains the following columns: invoice number, stock code, description, quantity, invoice date, unit price, customerID, and country. They provide information on the customers shopping at the ecommerce store and the items they bought.

I downloaded the dataset and opened it on Microsoft Excel to scan through it to gather some insight on the information it contains and discover the patterns that exist in it. However, I noticed the data was dirty. Several columns had wrong values and data placed in them that were supposed to be in other columns. For example, there were strings in columns meant for integers. There were also blank values in the rows of some columns.

I determined that the dataset needed to be cleaned in MySQL Workbench before analysis. Therefore, I closed Microsoft Excel and opened MySQL Workbench and created a database to import the dataset into.

I created the database and a sales table, and assigned a VARCHAR data type to all columns because they were dirty and a mix of numbers and strings. Without doing that, data would have been truncated while importing it, and I would not be able to analyse the entire dataset.
