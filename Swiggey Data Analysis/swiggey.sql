#1)	Details of customers whose name starts with 'A' and have gmail id
select  * from customers c ;
select * from card c2 ;
select* from cuisine c1 ;
select * from details d ;
select * from dish d1 ;
select * from orders o ;
#1)	Details of customers whose name starts with 'A' and have gmail id
select *  from customers c 
where name  like "A%" and email like "%gmail%";

#2)	Details of customers containing 3 times 5 in password
select password from customers c 
where password regexp '(5.*){3,}';


#only 5
select password from customers c 
where password  regexp '^5';
select * from customers c ;
select * from cuisine c ;
#3)	Name & address of North Indian restaurant which is situated in 456 Elm St
select * from cuisine c ;
select r_name,address from cuisine c 
where address="456 Elm St";

#4)	Names of restaurant which is either Italian or situated in '433 Oak St'
select r_name,cuisine,address from cuisine c 
where cuisine ="italian"or address="433 Oak St";

#5)	How many orders were palced with amount 650 or more
select * from orders o ;
select order_id,amount,count(*)from orders o 
where amount >=650
group by order_id ,amount ;

#6)	Find details of those customers who have never ordered 
select * from customers c ;
select * from orders o ;
select * from customers c 
where user_id not in (select  order_id from orders o );
#CORRECT
select c.*from customers c 
left join orders o on 
c.user_id =o.user_id 
where o.order_id is null;

#7)	Find out details of restaurants having sales greater than x (1000 or any amount)
select * from cuisine c1 ;
select * from orders o  ;
select c1.r_id,c1.r_name,sum(o.amount)as sales
from cuisine c1 join orders o 
on c1.r_id =o.r_id
group by c1.r_id,c1.r_name
having sales>1000;

#8)	Show all order details for a particular customer ('Vartika')
select * from customers c ;
select * from orders o ;
select o.* ,c.name from  customers c 
join orders o 
on c.user_id =o.user_id 
where name="Vartika";

#9)	What is the average Price per dish 
select * from dish d ;
select * from cuisine c1 ;
select * from card c2 ;
select avg(price ) as avg_per_dish from card c2 ;

#10)	Find out number of times each customer ordered food from each restaurants 
select * from customers c ;
select * from cuisine c1;
select * from orders o ;

#10)	Find out number of times each customer ordered food from each restaurants 
SELECT  c.user_id,c.name AS customer_name, c1.r_id,c1.r_name AS restaurant_name,
COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c  ON o.user_id = c.user_id
JOIN cuisine c1 ON o.r_id = c1.r_id
GROUP BY c.user_id, c.name, c1.r_id, c1.r_name
ORDER BY c.user_id, total_orders DESC;


#11)	Find the top restaurant in terms of the number of orders for a given month   
 select * from cuisine c1; 
select * from orders o  ;

select c1.r_id,c1.r_name,count(o.order_id)as total_orer from cuisine c1
join orders o on c1.r_id =o.r_id 
where month(o.date)=7
group by c1.r_id,c1.r_name
order by  total_orer desc; 
limit 1;

select c1.r_id,c1.r_name,count(o.order_id)as total_orer from cuisine c1
join orders o on c1.r_id =o.r_id 
where month(o.date)=7 and year(o.date)=2022
group by c1.r_id,c1.r_name
order by  total_orer desc 
limit 1;



#12)	Who is most loyal customer of dominos?
select * from cuisine c1;
select * from orders o  ;
select * from customers c ;
select c1.r_id,c1.r_name,count(o.order_id)as total_order from cuisine c1 join orders o 
on c1.r_id =o.r_id
where c1.r_name ="dominos"
group  by c1.r_id,c1.r_name
order by total_order desc 
limit 1;
#correct
select c.user_id,c.name,c1.r_name,COUNT(o.order_id)as total_order from orders o join customers c 
on o.user_id = c.user_id 
join cuisine c1 on o.r_id =c1.r_id
where c1.r_name ="dominos"
group by c.user_id,c.name,c1.r_name
order by total_order desc 
limit 1;
select * from customers c;



#13)	What is the favorite food of each customer?

select * from customers c ;
select * from orders o ;
select * from cuisine c1; 
select * from details d ;
select * from dish d1;
select * from card c2;


SELECT
    c.user_id,
    c.name AS customer_name,
    d.f_id AS food_id,
    d1.f_name,
    COUNT(d.f_id) AS order_count
FROM orders o
JOIN customers c 
    ON o.user_id = c.user_id
JOIN details d 
    ON o.order_id = d.order_id
join dish d1
    on d.f_id =d1.f_id 
GROUP BY c.user_id, c.name, d.f_id,d1.f_name
order by order_count desc
limit 1;

#15)	For each restaurant find out user who has ordered maximum number of times

select * from customers c ;
select * from orders o ;
select * from cuisine c1; 
select c.user_id,c.name,c1.r_name,count(o.order_id) as max_order from orders o join customers c 
on o.user_id =c.user_id
join cuisine c1 
on o.r_id =c1.r_id
group by c.user_id,c.name,c1.r_name
order by max_order desc;


select * from details d ;
select * from dish d1;
select * from card c2;
#1. Revenue by City (Bar Chart)
select * from customers c ;
select * from orders o ;
select * from cuisine c1; 

select c1.city,SUM(o.amount) as total_revenue
from cuisine c1 join orders o 
on c1.r_id =o.r_id
group by c1.city
order  by total_revenue desc;

#3. Orders by State (Map View)
SELECT c1.state,COUNT(o.order_id) AS total_orders
FROM orders o JOIN cuisine c1 ON o.r_id = c1.r_id
GROUP BY c1.state;

# 4. Top 5 Restaurants by Revenue (Bar Chart)
select distinct r_name from cuisine c1;

select c1.r_id ,c1.r_name,SUM(o.amount)as revenue
from orders o join cuisine c1
on c1.r_id =o.r_id
group by c1.r_name,c1.r_id
order by revenue desc
limit 10;
select * from orders o ;
#. Monthly Sales Trend (Line Chart)

SELECT DATE_FORMAT(date, '%Y-%m') AS month,SUM(amount) AS monthly_sales
FROM orders o
GROUP BY month
ORDER BY month;

#. Cuisine-wise Revenue (Bar or Tree Map)
select * from cuisine c1;
select * from orders o ;

SELECT c1.cuisine,SUM(o.amount) AS total_revenue
FROM orders o
JOIN cuisine c1 ON o.r_id = c1.r_id
GROUP BY c1.cuisine
ORDER BY total_revenue DESC;

#. Developer-like Analysis: Restaurant Ratings vs Delivery Ratings (Scatter Plot)
SELECT restaurant_rating, delivery_rating FROM orders o
WHERE restaurant_rating IS NOT null AND delivery_rating IS NOT NULL;

#Average Delivery Time by City (Bar Chart)
SELECT c1.city, AVG(o.delivery_time) AS avg_delivery_time
FROM orders o
JOIN cuisine c1 ON o.r_id = c1.r_id
GROUP BY c1.city
ORDER BY avg_delivery_time;

#Top 10 Ordered Food Items (Pie / Bar)
select * from details d ;
SELECT d.f_id,COUNT(*) AS times_ordered FROM details d
GROUP BY d.f_id
ORDER BY times_ordered desc
LIMIT 10;
select * from cuisine c1; 
#. Complete Restaurant Menu Prices (Data Table)
SELECT c1.r_name, c2.menu_id,c2.f_id, c2.price
FROM card c2
JOIN cuisine c1 ON c2.r_id = c1.r_id
ORDER BY c1.r_name, c2.price DESC;