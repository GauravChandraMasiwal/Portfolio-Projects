--Q1 A: Who is the senior most employee based on age
select first_name,last_name,title,(extract(year from current_date)-extract(year from birthdate)) as Age
 from employee order by Age desc limit 1;
 
--Q1 B: Who is the senior most employee based on jobtitle
select first_name,last_name,title,levels
 from employee order by levels desc limit 1;
 
--Q2 : Which country has the most invoices
select billing_country,count(invoice_id) from invoice
group by billing_country
order by 2 desc limit 1;

--Q3 : What are top 3 values of total invoice
select invoice_id,total from invoice
order by total desc limit 3;

--Q4. Which city has the best customers? We would like to throw a promotional Music
--Festival in the city we made the most money. Write a query that returns one city that
--has the highest sum of invoice totals. Return both the city name & sum of all invoice
--totals
select billing_city,sum(total) as Total_invoices from invoice
group by billing_city order by Total_invoices desc limit 1;

--Q5. Who is the best customer? The customer who has spent the most money will be
--declared the best customer. Write a query that returns the person who has spent the
--most money
select c.customer_id,c.first_name,c.last_name,sum(i.total) as total
from customer c join invoice i
on c.customer_id = i.customer_id
group by c.customer_id
order by 4 desc limit 1;

--Q6. Write query to return the email, first name, last name, & Genre of all Rock Music
--listeners. Return your list ordered alphabetically by email starting with A
select distinct c.first_name,c.last_name,c.email from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on t.track_id = il.track_id
join genre g on g.genre_id = t.genre_id
where g.name like 'Rock'
order by email;

--#A better and optimised method for the same problem :
select email,first_name,last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
	select track_id from track
	join genre on track.genre_id = genre.genre_id
	where genre.name like 'Rock'
)
group by customer.customer_id
order by email;

--Q7. Let's invite the artists who have written the most rock music in our dataset. Write a
--query that returns the Artist name and total track count of the top 10 rock bands
select a.name,count(track_id) as number_of_songs from artist a
join album ab on ab.artist_id=a.artist_id
join track t on t.album_id = ab.album_id
join genre g on g.genre_id = t.genre_id
where g.name like 'Rock'
group by a.name
order by 2 desc limit 10;

--Q8. Return all the track names that have a song length longer than the average song length.
--Return the Name and Milliseconds for each track. Order by the song length with the
--longest songs listed first

select name ,milliseconds from track where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc

--Q9. Find how much amount spent by each customer on artists? Write a query to return
--customer name, artist name and total spent

--I made a CTE so that we can get the customers who have spent on the top n best selling artist
with best_selling_artist as(
	select a.artist_id,a.name,sum(il.quantity * il.unit_price) as total_spent from artist a
	join album ab on ab.artist_id = a.artist_id
	join track t on t.album_id = ab.album_id
	join invoice_line il on il.track_id = t.track_id
	group by 1
	order by 3 desc	
	limit 1
)
select c.customer_id,c.first_name,c.last_name,bsa.name,sum(il.quantity * il.unit_price) as amt_spent from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album ab on ab.album_id = t.album_id 
join artist a on a.artist_id = ab.artist_id
join best_selling_artist bsa on bsa.artist_id = a.artist_id
group by 1,2,3,4
order by 5 desc

--Q10. We want to find out the most popular music Genre for each country. We determine the
--most popular genre as the genre with the highest amount of purchases. Write a query
--that returns each country along with the top Genre. For countries where the maximum
--number of purchases is shared return all Genres

with popular_genre as (
	select c.country ,g.name,count(il.quantity) as purchase ,
	dense_rank() over (partition by c.country order by count(il.quantity) desc) as rank
	from customer c
	join invoice i on i.customer_id = c.customer_id
	join invoice_line il on i.invoice_id = il.invoice_id
	join track t on t.track_id = il.track_id
	join genre g on g.genre_id = t.genre_id
	group by 1,2
	order by 3 desc,1 asc
)
select * from popular_genre where rank = 1;

--Here is another method to solve the above question  but now using recursion
with recursive
	sales_per_country as(
	select c.country ,g.name,count(il.quantity) as purchase_per_genre
	from customer c
	join invoice i on i.customer_id = c.customer_id
	join invoice_line il on i.invoice_id = il.invoice_id
	join track t on t.track_id = il.track_id
	join genre g on g.genre_id = t.genre_id
	group by 1,2
	order by 1 asc,3 desc
	),
	max_genre_per_country as(
	select max(purchase_per_genre) as max_genre_number,country
		from sales_per_country
		group by 2
		order by 2
	)
select sales_per_country.* from sales_per_country
join max_genre_per_country on sales_per_country.country = max_genre_per_country.country
where sales_per_country.purchase_per_genre = max_genre_per_country.max_genre_number
order by sales_per_country.purchase_per_genre desc;


--Q3: Write a query that determines the customer that has spent the most on music for each
--country. Write a query that returns the country along with the top customer and how
--much they spent. For countries where the top amount spent is shared, provide all
--customers who spent this amount

WITH Customter_with_country AS (
		SELECT c.customer_id,c.first_name,c.last_name,c.country,SUM(total) AS total_spending,
	    DENSE_RANK() OVER(PARTITION BY c.country ORDER BY SUM(total) DESC) AS Rank 
		FROM invoice i
		JOIN customer c ON c.customer_id = i.customer_id
		GROUP BY 1,2,3
		ORDER BY 4 DESC,3 asc)
SELECT * FROM Customter_with_country WHERE Rank = 1


--Here is another method to solve the above question  but now using recursion

WITH RECURSIVE 
	customer_with_country AS (
		SELECT customer.customer_id,first_name,last_name,country,SUM(total) AS total_spending
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 2,3 DESC),

	country_max_spending AS(
		SELECT country,MAX(total_spending) AS max_spending
		FROM customer_with_country
		GROUP BY country)

SELECT cc.country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
FROM customer_with_country cc
JOIN country_max_spending ms
ON cc.country = ms.country
WHERE cc.total_spending = ms.max_spending
ORDER BY 1;