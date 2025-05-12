CREATE TABLE menu (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    ingredient TEXT NOT NULL,
    weight INT NOT NULL
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL
);


CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    dish_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (dish_id) REFERENCES MENU(id)
);

---------------1
SELECT 
    m.name,
    m.ingredient, 
    SUM(m.price * oi.quantity) AS total_price
FROM 
    menu m
JOIN 
    order_items oi ON m.id = oi.dish_id
WHERE 
    oi.order_id = 1
GROUP BY 
    m.name, m.ingredient;
---------------2

SELECT *
FROM orders 
WHERE created_at::date = CURRENT_DATE;

---------------3

SELECT *
FROM orders
WHERE created_at::date BETWEEN DATE '2025-05-01' AND DATE '2025-05-07';

---------------4
SELECT SUM(m.price * oi.quantity) AS daily_revenue
FROM order_items oi 
JOIN menu m ON oi.dish_id = m.id
JOIN orders o ON oi.order_id = o.id
WHERE o.created_at::date = CURRENT_DATE;

---------------5

SELECT SUM(m.price * oi.quantity) AS monthly_revenue
FROM order_items oi
JOIN menu m ON oi.dish_id = m.id
JOIN orders o ON oi.order_id = o.id
WHERE DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', CURRENT_DATE);

---------------6
SELECT DISTINCT c.name, c.email
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', CURRENT_DATE);

---------------7
SELECT m.name, SUM(oi.quantity) AS total_quantity
FROM menu m
JOIN order_items oi ON m.id = oi.dish_id
JOIN orders o ON oi.order_id = o.id
WHERE DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY m.name
ORDER BY total_quantity DESC
LIMIT 5;

---------------8
SELECT SUM(m.price *0.03* oi.quantity) AS my_monthly_revenue
FROM order_items oi
JOIN menu m ON oi.dish_id = m.id
JOIN orders o ON oi.order_id = o.id
WHERE DATE_TRUNC('month', o.created_at) = DATE_TRUNC('month', CURRENT_DATE);