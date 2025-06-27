**Task 4: Aggregate Functions and Grouping in SQL**

**📌 Objective**  
To gain hands-on experience in summarizing and analyzing tabular data using **SQL aggregate functions** and **grouping techniques**.

---

**🛠️ Tools Used**  
- **DB Browser for SQLite**  
- **MySQL Workbench**

---

**🧠 Learning Outcomes**  
By completing this task, you will:  
- Understand how to use aggregate functions like `SUM`, `COUNT`, and `AVG`.  
- Learn how to categorize data using the `GROUP BY` clause.  
- Apply filters to grouped data using the `HAVING` clause.  
- Enhance your data analysis capabilities using SQL.

---

**🔍 Key Concepts**

**1. Aggregate Functions**  
Functions that perform a calculation on a set of values and return a single value:
- `SUM()`: Adds up the values.  
- `COUNT()`: Counts the number of rows.  
- `AVG()`: Calculates the average of values.  
- `MIN()` / `MAX()`: Returns the smallest/largest value.

**2. GROUP BY Clause**  
Used to arrange identical data into groups.

**3. HAVING Clause**  
Used to filter records after grouping (unlike `WHERE`, which filters before grouping).

---

**📂 Deliverables**

**✅ SQL Queries Demonstrating:**  
- Use of `SUM`, `COUNT`, `AVG` on numeric columns.  
- Grouping data using `GROUP BY`.  
- Filtering groups using `HAVING`.

**Example SQL snippets:**
```sql
-- Count the number of orders per customer
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

-- Average order value by product category
SELECT category, AVG(order_total) AS avg_order_value
FROM products
JOIN orders ON products.product_id = orders.product_id
GROUP BY category;

-- Total sales by region with sales over $10,000
SELECT region, SUM(sales) AS total_sales
FROM sales_data
GROUP BY region
HAVING total_sales > 10000;
