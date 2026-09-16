-- ============================================================
-- ONLINE BOOKSTORE SQL DATA ANALYSIS PROJECT
-- PostgreSQL
-- Source datasets: Books.csv, Customers.csv, Orders.csv
-- ============================================================
-- DATASET OVERVIEW
-- Books: 500 rows
-- Customers: 500 rows
-- Orders: 500 rows
-- ============================================================

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200),
    author VARCHAR(200),
    genre VARCHAR(100),
    published_year INT,
    price NUMERIC(10,2),
    stock INT
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(200),
    email VARCHAR(200),
    phone VARCHAR(20),
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    order_date DATE,
    quantity INT,
    total_amount NUMERIC(10,2),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id)
        REFERENCES Books(book_id)
);

\COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'data/Books.csv'
WITH (FORMAT csv, HEADER true);

\COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'data/Customers.csv'
WITH (FORMAT csv, HEADER true);

\COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'data/orders.csv'
WITH (FORMAT csv, HEADER true);

--Questions and solutions

-- Q1. What are the available book genres?
SELECT DISTINCT genre As Available_book_Genres
FROM Books
ORDER BY genre;

-- Q2. How many books are available in each genre?
SELECT genre, COUNT(*) AS book_count
FROM Books
GROUP BY genre
ORDER BY book_count DESC;

-- Q3. What are the most expensive books?
SELECT title, author, price
FROM Books
ORDER BY price DESC
LIMIT 10;

-- Q4. How many customers are registered in each city?
SELECT city, COUNT(*) AS customer_count
FROM Customers
GROUP BY city
ORDER BY customer_count DESC;


-- ============================================================
-- 3. SALES & REVENUE ANALYSIS
-- ============================================================

-- Q5. What is the total revenue generated from all orders?
SELECT SUM(total_amount) AS total_revenue
FROM Orders;


-- Q6. What is the total quantity of books sold?
SELECT SUM(quantity) AS total_books_sold
FROM Orders;

-- Q7. Which genres generate the highest sales revenue?
SELECT
    b.genre, SUM(o.quantity) AS books_sold,
    SUM(o.total_amount) AS revenue
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.genre
ORDER BY revenue DESC;

-- Q8. Which books have generated the highest revenue?
SELECT
    b.title, b.author, SUM(o.quantity) AS quantity_sold, SUM(o.total_amount) AS revenue
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.title, b.author
ORDER BY revenue DESC
LIMIT 10;

-- Q9. What is the average order value?
SELECT ROUND(AVG(total_amount), 2) AS average_order_value
FROM Orders;

-- Q10. Which customers have spent the most in total?
SELECT
    c.customer_id, c.name, c.city,
    ROUND(SUM(o.total_amount), 2) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spent DESC
LIMIT 10;

-- ============================================================
-- 4. CUSTOMER BEHAVIOUR
-- ============================================================

-- Q11. Which customers have placed more than one order?
SELECT
    c.customer_id, c.name,
    COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;

-- Q12. Which customers have spent more than $30 in total?
SELECT
    o.customer_id,
    c.name,
    c.city,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.name, c.city
HAVING SUM(o.total_amount) > 30
ORDER BY total_spent DESC;

-- Q13. Which cities have customers whose total spending exceeds $30?
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS qualifying_customers,
    SUM(o.total_amount) AS total_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 30
ORDER BY total_revenue DESC;

-- Q14. Which customers purchased more than one book in total?
SELECT
    c.customer_id,
    c.name,
    SUM(o.quantity) AS books_purchased
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.quantity) > 1
ORDER BY books_purchased DESC;


-- ============================================================
-- 5. INVENTORY ANALYSIS
-- ============================================================

-- Q15. What is the estimated remaining stock after recorded sales?
SELECT
    b.book_id, b.title, b.stock,
    COALESCE(SUM(o.quantity), 0) AS quantity_sold,
    b.stock - COALESCE(SUM(o.quantity), 0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY book_id ASC;

-- Q16. Which books have low remaining stock (10 or fewer)?
WITH Inventory AS (
    SELECT
        b.book_id, b.title, b.stock,
        COALESCE(SUM(o.quantity), 0) AS quantity_sold,
        GREATEST(b.stock - COALESCE(SUM(o.quantity), 0), 0) AS remaining_stock
    FROM Books b
    LEFT JOIN Orders o ON b.book_id = o.book_id
    GROUP BY b.book_id, b.title, b.stock
)
SELECT *
FROM inventory
WHERE remaining_stock <= 10
ORDER BY remaining_stock, title;

-- ============================================================
-- 6. ADVANCED SQL ANALYSIS
-- ============================================================

-- Q17. Rank books by revenue within each genre.
WITH book_revenue AS (
    SELECT
        b.book_id, b.title, b.genre,
        ROUND(SUM(o.total_amount), 2) AS revenue
    FROM Books b
    JOIN Orders o ON b.book_id = o.book_id
    GROUP BY b.book_id, b.title, b.genre
)
SELECT
    title,
    genre,
    revenue,
    RANK() OVER (PARTITION BY genre ORDER BY revenue DESC) AS genre_rank
FROM book_revenue
ORDER BY genre, genre_rank;

								--OR--

SELECT 
	b.title, b.genre, 
	SUM(o.Total_amount) AS Total_revenue, 
	RANK() OVER(PARTITION BY b.genre ORDER BY SUM(o.Total_amount) DESC)
FROM books b 
JOIN orders o ON o.book_id = b.book_id
GROUP BY b.title, b.genre;


-- Q18. What percentage of total revenue comes from each genre?
WITH genre_revenue AS (
    SELECT
        b.genre,
        SUM(o.total_amount) AS revenue
    FROM Books b
    JOIN Orders o ON b.book_id = o.book_id
    GROUP BY b.genre
)
SELECT
    genre,
    ROUND(revenue, 2) AS revenue,
    ROUND(100.0 * revenue / SUM(revenue) OVER (), 2) AS revenue_percentage
FROM genre_revenue
ORDER BY revenue DESC;


-- Q19. Segment customers based on total spending.
WITH customer_spend AS (
    SELECT
        c.customer_id,
        c.name,
        ROUND(COALESCE(SUM(o.total_amount), 0), 2) AS total_spent
    FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name
)
SELECT
    customer_id,
    name,
    total_spent,
    CASE
        WHEN total_spent >= 100 THEN 'High Value'
        WHEN total_spent >= 50 THEN 'Medium Value'
        WHEN total_spent > 0 THEN 'Low Value'
        ELSE 'No Purchase'
    END AS customer_segment
FROM customer_spend
ORDER BY total_spent DESC;

-- Q20. Which customers are in the top 10% by total spending?
WITH customer_spend AS (
    SELECT
        c.customer_id,
        c.name,
        ROUND(SUM(o.total_amount), 2) AS total_spent
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name
),
ranked AS (
    SELECT
        *,
        NTILE(10) OVER (ORDER BY total_spent DESC) AS spending_decile
    FROM customer_spend
)
SELECT
    customer_id,
    name,
    total_spent
FROM ranked
WHERE spending_decile = 1
ORDER BY total_spent DESC;

-- ============================================================
-- SQL SKILLS DEMONSTRATED
-- SELECT | WHERE | DISTINCT | ORDER BY | LIMIT
-- GROUP BY | HAVING | COUNT | SUM | AVG
-- INNER JOIN | LEFT JOIN | COALESCE
-- CTEs | CASE WHEN | RANK | NTILE | Window Functions
-- ============================================================
