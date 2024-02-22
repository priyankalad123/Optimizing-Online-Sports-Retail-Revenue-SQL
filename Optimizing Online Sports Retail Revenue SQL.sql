CREATE DATABASE sports_retail_db;
use sports_retail_db;
### 1.How do the price points of Nike and Adidas products differ?
-- price points difference between Nike and Adidas products
SELECT b.brand, AVG(f.listing_price) AS avg_listing_price
FROM brands_v2 b
JOIN finance f ON b.product_id = f.product_id
WHERE b.brand IN ('Nike', 'Adidas')
GROUP BY b.brand;

#### 2.Is there a difference in the amount of discount offered between the brands

SELECT b.brand, AVG(f.discount) AS avg_discount
FROM finance f
JOIN brands_v2 b ON f.product_id = b.product_id
WHERE b.brand IN ('Nike', 'Adidas')
GROUP BY b.brand;

#### 3.Is there any correlation between revenue and reviews, and if so, how strong is it?
 SELECT
    (COUNT(*) * SUM(rating * reviews) - SUM(rating) * SUM(reviews)) /
    (SQRT((COUNT(*) * SUM(rating * rating) - (SUM(rating) * SUM(rating))) * (COUNT(*) * SUM(reviews * reviews) - (SUM(reviews) * SUM(reviews))))) AS correlation_coefficient
FROM
    reviews_v2;
    
#### 4.Does the length of a product's description influence its rating and reviews?
SELECT
    AVG(LENGTH(description)) AS avg_description_length,
    AVG(rating) AS avg_rating,
    AVG(reviews) AS avg_reviews
FROM
    info_v2
JOIN
    reviews_v2 ON info_v2.product_id = reviews_v2.product_id;

#### 5.Are there any trends or gaps in the volume of reviews by month?
SELECT
    YEAR(last_visited) AS visit_year,
    MONTH(last_visited) AS visit_month,
    COUNT(*) AS visit_count
FROM
    traffic_v3
GROUP BY
    YEAR(last_visited),
    MONTH(last_visited)
ORDER BY
    visit_year ASC,
    visit_month ASC;
    
#### 6.Which brands generate the highest revenue overall? What are their respective revenue figures?
SELECT b.brand, SUM(f.revenue) AS total_revenue
FROM finance f
JOIN brands_v2 b ON f.product_id = b.product_id
GROUP BY b.brand
ORDER BY total_revenue DESC;

#### 7.What percentage of the company's products were sold at a discount? How does this impact overall revenue and customer behavior?
-- Calculate the total number of products sold at a discount
SELECT COUNT(*) AS discounted_products
FROM finance
WHERE discount > 0;

-- Calculate the total number of products
SELECT COUNT(*) AS total_products
FROM finance;

-- Calculate the percentage of products sold at a discount
SELECT 
    (discounted_products / total_products) * 100 AS percentage_discounted
FROM (
    SELECT 
        (SELECT COUNT(*) FROM finance WHERE discount > 0) AS discounted_products,
        (SELECT COUNT(*) FROM finance) AS total_products
) AS counts;

-- Analyze the impact of discounts on overall revenue and customer behavior
SELECT
    SUM(revenue) AS total_revenue,
    AVG(discount) AS average_discount
FROM
    finance;






    
















