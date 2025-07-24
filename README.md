# MySQL Project Ecommerce Online Sales

## Overview

SQL-based data analysis of ecommerce online sales dataset. The dataset contains 8 columns and 541,910 rows. it contains the following columns: invoice number, stock code, description, quantity, invoice date, unit price, customerID, and country. They provide information on the customers shopping at the ecommerce store and the items they bought. 

## Data Source

I obtained the dataset from Kaggle, and it can be found here.

## Business Task

Data cleaning, feature engineering, and exploratory data analysis of Online ecommerce sales data using MySQL Workbench

## Tools

MySQL WorkBench

## Process

* I downloaded the dataset and opened it on Microsoft Excel to scan through and gather some insight on the information it contains and discover the patterns that exist in it. However, I noticed the data was dirty. Several columns had wrong values and data placed in them that were supposed to be in other columns. For example, there were strings in columns meant for integers. There were also blank values in the rows of some columns.

* I determined that the dataset needed to be cleaned in MySQL Workbench before analysis. Therefore, I closed Microsoft Excel and opened MySQL Workbench and created a database to import the dataset into.

* I created the database and a sales table, and assigned a VARCHAR data type to all columns because they were dirty and a mix of numbers and strings. Without doing that, data would have been truncated while importing it, and I would not be able to analyse the entire dataset.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image14.png?raw=true)

* I imported data into the sales table using the LOAD DATA LOCAL INFILE query to speed up the process.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image5.png?raw=true)

* Once imported, I queried the entire table using a SELECT statement and explored it to note everything that needed cleaning, and proceeded with the cleaning process.

### Data Cleaning

* First, I searched for duplicate rows with a WINDOW function and CTE found 5,268 of them, which I deleted. Then I moved to standardize the data.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image8.png?raw=true)

* One problem that jumped out to me was that some values in the quantity column. This was odd because the quantity of goods sold at an ecommerce store should not be negative. I queried all the data that fell into the category for further analysis. I noticed that many of the entries with this problem had similar customer IDs and occurred in multiple countries.

  I initially thought the problem was most likely caused by entry errors, but I also noticed that some product descriptions of this category of items were listed as “damaged”, “discount”, “faulty”, and “samples”, and they were alongside listings with normal product descriptions. I concluded all these entries were non-sales. Since all these only accounted for 10,624 rows, which is less than 2% of all rows, I created a copy of the table and deleted all the rows.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image9.png?raw=true)

* While exploring the stock code column, I noticed some entries were either strings or alphanumeric characters, and I believed that column is supposed to only contain numbers. However, I did not clean those rows because I believed they would not have a major impact on my ability to analyse the dataset, and deleting them may make me lose valuable information.

* Furthermore, I found 1,179 rows where the unit price column had “0” values. I looked at the product description column, and many were blank, and had entries like “damaged”, “check”, “found”, “Amazon”, and “for online retail orders”. However, some seemed like legit product descriptions. Since products listed should not have “0” unit prices and many of the descriptions were out of place, I deleted all affected rows.

* In the country column, I changed the entries called “EIRE” and “RSA” to “Ireland” and “South Africa” respectively because those are the more recognised names.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image3.png?raw=true)

* I converted all the blank values in the customer ID column into nulls, and I made all the values in the unit price column have two decimal places for uniformity.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image4.png?raw=true)

### Feature Engineering

* After data cleaning, I began to conduct exploratory data analysis to extract insights from the dataset. While doing so, I realized I would need to engage in feature engineering to extract all the insights I need. For example, I needed to determine the income generated for each transaction and add that to a column. This would help me determine how much revenue each item was bringing in.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image12.png?raw=true)

* I also had to break down each sale to the day of week, month, and time of day (morning, afternoon, or night) from the datetime provided in the dataset to know the days of the week, month, and times of day customers were likely to purchase items. That information can inspire marketing campaigns focused on the days of the week and times of the week when sales are relatively low to boost sales during those periods.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image2.png?raw=true)

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image11.png?raw=true)

### Exploratory Data Analysis

* After the feature engineering exercise, I had all the information I needed for exploratory data analysis. During EDA, I queried the data to answer the following questions:

**Top selling item**: Out of the 4,026 unique items sold at the ecommerce store, WHITE HANGING HEART T-LIGHT HOLDER sold the most times (2,323) during the timespan of the dataset. Therefore, this item should always be in stock since customers want it.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image10.png?raw=true)

**Top-grossing item**: Of all the items sold, REGENCY CAKESTAND 3 TIER appears to be the item that brought in the most money ($174,484.74). It is worth noting that DOTCOM POSTAGE appeared to bring in the most revenue ($206,248.77), but from analyzing the dataset, DOTCOM POSTAGE was listed with different unit prices, making me skeptical that it is one unique item being sold.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image1.png?raw=true)

**Top selling month**: November was the top selling month, raking in $1,509,496.33 in revenue. This was closely followed by December, October, and September in that order. This means the holiday months bring in the most sales. Running holiday promotional campaigns might bring in even more revenue.

February sold the least, perhaps because most people had done their spending during the holidays. A suitable marketing campaign to boost sales here can be centered around Valentine’s Day.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image6.png?raw=true)

**Highest and lowest selling days**: The store brought in the highest revenue on Thursdays ($2,203,161.24), followed by Tuesdays. The least selling day was Sunday ($813,827.61). There was no data for Saturday sales. These sales figures were surprising, as I had expected more weekend sales. My immediate thought was that this may be because people are at work during the weekday and are unable to shop in person; therefore, they order online. But during the weekends, they go to the store. 

Nevertheless, this presents an opportunity for the company. They can grow their revenue by running ads on the weekends and offering incentives to attract more weekend shoppers.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image7.png?raw=true)

**Top-selling country**: The United Kingdom brought in the most revenue by far ($9,003,097.96) during the time period of the dataset. The Netherlands came in second place, raking in revenues of $285,446.34, followed by Ireland, Germany, and France, which all grossed a similar amount. Saudi Arabia grossed the lowest ($145.92), below Bahrain ($754.14). Analyzing the dataset revealed that most sales originated in Europe; therefore, the ecommerce company has to sell more items that appeal to non-European audiences or improve their marketing efforts outside Europe to increase their revenue in those areas.

![image alt](https://github.com/jefferyokpala/MySQL-Project-Ecommerce-Online-Sales/blob/main/image/image13.png?raw=true)





