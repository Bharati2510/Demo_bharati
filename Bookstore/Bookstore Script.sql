select * from books b ;
select * from customers c ;
select * from orders o ;

#1) Retrieve all books in the "Fiction" genre:
select * from books b 
where  Genre = "Fiction";

#2) Find books published after the year 1950:

select * from books b 
where  Published_Year >1950;

#3) List all customers from the Canada:
select * from customers c 
where  Country = "Canada";

# 4) Show orders placed in November 2023:
select * from orders o 
where Order_Date between "2023-11-1"and "2023-11-30";

# 5) Retrieve the total stock of books available:

select * from books b ;

select sum(stock) as Total_stock
from books b ;

#6) Find the details of the most expensive book

SELECT * FROM Books b
ORDER BY Price DESC 
LIMIT 1;

#7) Show all customers who ordered more than 1 quantity of a book:
select * from orders o
where quantity >1;

#8) Retrieve all orders where the total amount exceeds $20:
select * from orders o 
where Total_Amount >20;

#9) List all genres available in the Books table:
select * from books b ;
select distinct genre from books b ;

# 10) Find the book with the lowest stock:
select * from books b 
order by  Stock
limit 1;

#11) Calculate the total revenue generated from all orders:
select * from orders o ;

select sum(total_amount)as total_revenue
from orders o ;

#12-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select * from books b ;
select * from orders o  ;
select genre,sum(o.Quantity) as total_books_sold 
from orders o join  books b 
on o.Book_ID = b.Book_ID 
group by b.Genre ;

-- 2) Find the average price of books in the "Fantasy" genre:

select avg(price) from books b 
where genre ="Fantasy";

-- 3) List customers who have placed at least 2 orders:
select * from orders o  ;
select * from customers c  ;

select c.customer_id,c.name,count(o.order_id) as order_count
from orders o  join customers c 
on o.Customer_ID = c.Customer_ID
group by c.customer_id,c.name
having  order_count>=2;


-- 4) Find the most frequently ordered book:
select *from books b ;
select * from orders o ;

select b.book_id,b.title,count(o.order_id)as order_count
from orders o  join books b 
on o.Book_ID =b.Book_ID 
group by  b.book_id,b.title
order  by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

select * from books b 
where genre="Fantasy"
order by b.Price desc limit 3 ;

-- 6) Retrieve the total quantity of books sold by each author:

select * from books b ;
select b.author,sum(o.quantity) as total_quantity
from orders o join books b 
on o.Book_ID =b.Book_ID 
group by b.Author;

-- 7) List the cities where customers who spent over $30 are located:
select * from customers c ;
select * from orders o ;

select distinct c.city,o.total_amount from orders o join customers c 
on o.Customer_ID =c.Customer_ID 
where o.Total_Amount >30;

-- 8) Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount)as total_spent
from orders o  join customers c 
on o.Customer_ID = c.Customer_ID
group by c.customer_id,c.name
order  by total_spent desc limit 1;

#--9) Calculate the stock remaining after fulfilling all orders:
select * from books b ;
select b.book_id,b.Title,b.stock,COALESCE(sum(o.quantity),0) as order_quantity,b.stock-COALESCE(sum(o.quantity),0) as remaing_quantity
from books b left join orders o 
on b.Book_ID = o.Book_ID
group by b.book_id,b.Title,b.stock;


