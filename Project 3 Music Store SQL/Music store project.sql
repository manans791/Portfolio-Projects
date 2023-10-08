SQL Project Music Store Analysis

										EASY

1 /* Who is the senior most employee based on job title  */

select * from employee
order by levels desc 
limit 1

/* Hence we can say from the data that 'Madan Mohan' is te senior most employee  */


2 /* which country has the most invoices  */

select billing_country, count(*) from invoice
group by billing_country
order by count(*) desc

/* Here we can see 'USA' has the most transactions followed by 'cananda' and 'brazil'  */


3/* which city has the best customers? we would like to throw a music festival in that city
which made most money. write a query that returns one city that has highest sum of invoice totals.
Return both city name and sum of all invoices totals*/

select invoice.billing_city, sum(invoice.total) from customer join invoice on 
customer.customer_id=invoice.customer_id
group by invoice.billing_city
order by sum(invoice.total) desc

/*From the above we can see prague is the city with most transaction and prague is the city to throw a music festival*/


4/*Top 3 values of total invoice */

select total, from invoice
order by total desc
limit 3

/*The top 3 invoices are 23.75, 19.8, 19.8 respectively */


5/*who is the best customer? customer who have spend most amount of money.
Write a query that returns the person who has spent the most money*/

select customer.first_name, customer.last_name, sum(invoice.total) from customer join invoice on
customer.customer_id = invoice.customer_id
group by customer.customer_id
order by sum(invoice.total) desc
limit 1



											INTERMEDIATE
1/* Write a query to return email,first name, lastname and genre of all rock music listeners.
return your list ordered alphabetically by email starting with 'A */


select distinct c.email , c.first_name, c.last_name from customer c join invoice i on 
c.customer_id = i.customer_id join invoice_line il on
il.invoice_id=i.invoice_id join track t on 
il.track_id = t.track_id where t.genre_id in
(select genre_id from genre where name = 'Rock')
order by c.email


2/* Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select distinct ar.name, count(*) as total_songs from artist ar join album al on
ar.artist_id = al.artist_id join track t on 
al.album_id = t.album_id where genre_id =
(select genre_id from genre where name = 'Rock')
group by ar.artist_id
order by total_songs desc
limit 10



3/* Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.*/

select name, milliseconds from track
where milliseconds >
(select avg(milliseconds) from track)
order by milliseconds desc



												













