create schema dinner;
use dinner;

select * from members;
select * from menu;
select * from sales;

-- Q1) What is the total amount each customer spent at the restaurant?

select s.customer_id,
sum(if(s.product_id=1,1,0)) as total_prod_1,
sum(if(s.product_id=2,1,0)) as total_prod_2,
sum(if(s.product_id=3,1,0)) as total_prod_3
from sales s group by s.customer_id;

with x as(
select s.*,m.price from sales s join menu m on s.product_id=m.product_id
) select x.customer_id,sum(x.price) as money_spent from x group by x.customer_id;

-- Q2) How many days has each customer visited the restaurant?

select * from sales;
select * from members;

select customer_id,count(distinct order_date) from sales group by customer_id;

-- Q3) What was the first item from the menu purchased by each customer?

select * from sales;
select * from menu;

with cte as(
select customer_id,order_date,product_id from (
select *,row_number() over(partition by customer_id) as rn from sales) as x
where x.rn=1)
select cte.customer_id,cte.product_id,m.product_name
from cte join menu m on cte.product_id=m.product_id;

-- Q5) Which item was the most popular for each customer?

with y as(
with x as(
select s.customer_id,m.product_name,count(s.product_id) as items_bought
from sales s join menu m on m.product_id=s.product_id
group by s.customer_id,m.product_name)
select *,row_number() over(partition by customer_id order by x.items_bought desc) as rn
from x)
select customer_id, product_name,items_bought from y where y.rn=1;

-- Q4) What is the most purchased item on the menu and how many times was it purchased by all customers?

select * from sales;

select m.product_name,count(s.customer_id) as no_of_customers_bought
from sales s join menu m on s.product_id=m.product_id group by m.product_name
order by no_of_customers_bought desc;

-- Q6) Which item was purchased first by the customer after they became a member?
select * from members;
select * from sales;
select * from menu;

with z as(
with y as(
with x as(
select s.*,m.join_date,datediff(m.join_date,s.order_date) as join_order_diff
from sales s join members m on m.customer_id=s.customer_id
)
select * from x where join_order_diff<0
) select customer_id,join_date,order_date,product_id,
dense_rank() over(partition by customer_id order by join_order_diff desc) as d_rnk
from y
) select z.customer_id,mn.product_name from z join menu mn on z.product_id=mn.product_id
where z.d_rnk=1 order by z.customer_id;

-- Q7) Which item was purchased just before the customer became a member?
with y as(
with x as
(
select s.customer_id,m.join_date,s.order_date,s.product_id,
datediff(m.join_date,s.order_date) as time_diff 
from sales s join members m on s.customer_id=m.customer_id
where datediff(m.join_date,s.order_date)>0
) 
select * , row_number() over(partition by customer_id order by time_diff asc) as rn from x
) select y.customer_id,y.join_date,y.order_date,y.product_id,mn.product_name
from y join menu mn on mn.product_id=y.product_id where y.rn=1;

-- Q8) What is the total items and amount spent for each member before they became a member?
select * from members;
select * from menu;

with x as(
select s.*,mn.price from sales s join members m on s.customer_id=m.customer_id 
join menu mn on mn.product_id=s.product_id 
where s.order_date>m.join_date order by s.customer_id
)
select customer_id,product_id,count(product_id) as total_items,concat('$',sum(price)) as total_amount
from x group by customer_id,product_id order by customer_id;

use dinner;
-- Q9) If each $1 spent equates to 10 points and sushi has a 2x points multiplier
-- how many points would each customer have?
with y as(
with x as(
select s.customer_id,mn.product_name,sum(mn.price) as amount_spend
from sales s join menu mn on s.product_id=mn.product_id
group by s.customer_id,mn.product_name
) select x.*,
CASE WHEN x.product_name<>'sushi' THEN amount_spend*10 ELSE amount_spend*20 END as points_earned
from x
) select y.customer_id,sum(y.points_earned) as total_points_earned
from y group by y.customer_id;

/*
In the first week after a customer joins the program (including their join date)
they earn 2x points on all items, not just sushi - how many points do customer A and B have
at the end of January?
*/
select * from sales;
with z as
(
with y as
(
with x as
(
select s.customer_id,m.join_date,s.order_date,s.product_id,mn.product_name,mn.price,
datediff(s.order_date,m.join_date) as date_diff
from sales s join members m on s.customer_id=m.customer_id
join menu mn on mn.product_id=s.product_id where m.join_date<s.order_date  
order by s.customer_id
) select customer_id, join_date, order_date, product_id, product_name, price
from x where x.date_diff<=7
) select *,price*20 as points from y
) select customer_id,sum(points) as total_earned_points from z group by customer_id
order by customer_id;

