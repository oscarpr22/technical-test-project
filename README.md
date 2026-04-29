# Technical Test - SQL & Python

## Project Description

This repository contains my solution to a data analysis/data engineering technical test. The goal of this space is to showcase my analytical approach and technical skills in **SQL** and **Python (Pandas)** within a real business scenario focused on relational database management and the creation of operational metrics.

The use case focuses on processing and analyzing data from an in-app chat system, tracking the messages exchanged between customers and couriers to generate valuable communication insights.

## Repository Structure

* 📁 `data/`: Directory containing the two `.csv` files (`orders.csv` and `customer_courier_chat_messages.csv`) used to populate the database and perform the exercises.
* 📄 `Technical Test - SQL.pdf`: Detailed pdf document including the justification, execution screenshots, and tabular results for the SQL section.
* 📄 `Technical Test - Python.ipynb`: Jupyter Notebook file containing all the Python (Pandas) code used to replicate the final SQL aggregation exercise.
* 📁 `SQL Queries/`: Directory containing eight .sql files (`Query SQL Exercise 1.sql` to `Query SQL Exercise 8.sql`), which contain individual scripts with the exact code for each of the queries built in SQL.

## Analyzed Data

The analysis is based on two datasets:

* **`orders`**: Table with general order information, including an identifier (`order_id`) and the city code (`city_code`).
* **`customer_courier_chat_messages`**: Granular table recording every message sent through the app. It includes, among other fields, the sender, order and courier identifiers, message timestamps, and the order stage at the time of the message.

## Highlighted Technologies and Tools

* **SQL (PostgreSQL)**: I used PostgreSQL via the **pgAdmin** administration environment to create the database, import the CSV files, and model and query the tables.
* **Python (Pandas)**: I used Python Pandas library for tabular data extraction, cleaning, grouping, and transformation, serving as a validation of the model generated in SQL.
* **Jupyter Notebooks**

## Summary of Exercises and Demonstrated Skills

### SQL Exploration and Modeling

In the first phase, the queries gradually progress from simple explorations to the creation of a consolidated model, allowing me to apply:

* **Data Types and Functions**: Conversion of `VARCHAR` to `TIMESTAMP` using the `TO_TIMESTAMP` function to ensure accurate calculations between dates and times.
* **Groupings and Joins**: Combining tables and usage identifiers (`GROUP BY`, `JOIN`) to count total customer messages per order.
* **Common Table Expressions (CTEs)**: Use of the `WITH` clause to modularize complex logic, making it possible to separate the extraction of the first and last chat messages.
* **Advanced Window Functions**: Fundamental use of `ROW_NUMBER()` and `FIRST_VALUE()` alongside data partitioning (`OVER(PARTITION BY)`) to evaluate messages sequentially within the specific context of each order (`order_id`).
* **Time Delta Calculations**: Extracting chat response time (in seconds) by using temporal statements like `EXTRACT (EPOCH FROM ...)` to measure efficiency between messages.
* **Conversations Table**: The final exercise generated a robust view (`customer_courier_conversations`) condensing multiple message rows into a single row per order, containing communication KPIs ready for BI analysis and visualization.

### Python Transformation (Pandas)

In the last section of the test, I solved the same final grouping problem (previously done in SQL) purely in Python to demonstrate adaptability:

* **Data Ingestion and Cleaning**: Reading `.csv` files, formatting text columns (manipulations with `.str`), and accurately converting to a compatible *datetime* format.
* **Advanced Aggregation**: Intensive use of `groupby().agg()` by defining multiple functions (`min`, `count`, `first`, `last`) simultaneously to calculate metrics based on sender and order.
* **DataFrame Merging**: Recreating relational logic using `pd.merge()` applying *Left Joins*.
* **Final Variable Calculation**: Null-filling logic, statistical data type changes, and absolute time calculation in seconds using `.dt.total_seconds().abs()` to standardize the final table ready for export.