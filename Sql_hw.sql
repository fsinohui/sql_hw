USE sakila;

select *
from actor;

select 
first_name,
last_name
from actor;

select 
concat(first_name," ", last_name) as Names
from actor;

SELECT 
actor_id,first_name,last_name
from actor
where first_name = "JOE";

SELECT 
actor_id,first_name,last_name
from actor
where last_name LIKE '%GEN%';

SELECT 
actor_id,first_name,last_name
from actor
where last_name LIKE '%LI%'
ORDER BY last_name,first_name;

SELECT *
from country;

SELECT
country_id,
country
from country 
where (country='China' OR country='Bangladesh' OR country='Afghanistan');

ALTER TABLE actor
  ADD middle_name VARCHAR(50);

ALTER TABLE actor MODIFY COLUMN last_name BLOB(255);

ALTER TABLE actor DROP COLUMN middle_name;

SELECT last_name, COUNT(*) FROM actor GROUP BY last_name;

UPDATE actor
    SET last_name = "Harpo",
        first_name = "Williams"
    WHERE first_name = "GROUCHO";
  
SELECT last_name, (
				SELECT count(last_name) 
                FROM actor 
                WHERE a.last_name = actor.last_name) 
AS 'last_name_count' 
FROM actor AS a GROUP BY a.last_name;
	
SELECT last_name, last_name_count 
FROM (
		SELECT last_name, (
							SELECT count(last_name) 
                            FROM actor 
                            WHERE a.last_name = actor.last_name) 
	AS 'last_name_count' FROM actor AS a GROUP BY a.last_name) 
AS b WHERE b.last_name_count > 1;
	
UPDATE actor 
SET first_name = 'HARPO' 
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
	
UPDATE actor 
SET first_name = CASE WHEN first_name = 'HARPO' THEN 'GROUCHO' ELSE 'MUCHO GROUCHO' END WHERE actor_id = 172;
SHOW CREATE TABLE address;
	
SELECT first_name, last_name, address, city, district, postal_code 
FROM staff 
JOIN address ON staff.address_id = address.address_id 
JOIN city ON address.city_id = city.city_id;
	
SELECT first_name, last_name, total_amount 
FROM staff JOIN (SELECT staff_id, SUM(amount) AS 'total_amount' 
FROM payment WHERE payment_date BETWEEN '2005-08-01 00:00:00' AND '2005-08-31 00:00:00' 
GROUP BY staff_id) AS payments on staff.staff_id = payments.staff_id;
	

SELECT title, number_of_actors 
FROM film INNER JOIN (
					SELECT film_id, COUNT(actor_id) AS 'number_of_actors' FROM film_actor 
                    GROUP BY film_id)
AS actor_count ON film.film_id = actor_count.film_id;
	
SELECT title, copies_in_inventory 
FROM film JOIN (SELECT film_id, COUNT(inventory_id) AS 'copies_in_inventory' 
FROM inventory GROUP BY film_id) AS inventory_count ON film.film_id = inventory_count.film_id 
WHERE title = 'HUNCHBACK IMPOSSIBLE';
	
SELECT first_name, last_name, total_paid 
FROM customer JOIN (SELECT customer_id, SUM(amount) AS 'total_paid' 
FROM payment GROUP BY customer_id) AS total_payments ON customer.customer_id = total_payments.customer_id 
ORDER BY last_name;
	
SELECT title 
FROM film 
WHERE language_id IN (SELECT language_id FROM language WHERE name = 'English') AND title IN (
																							SELECT title 
                                                                                            FROM film 
                                                                                            WHERE title LIKE 'K%' OR title LIKE 'Q%');
	
SELECT first_name, last_name 
FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film WHERE title = 'ALONE TRIP'));
	
SELECT name, email 
FROM customer_list 
JOIN customer ON customer_list.ID = customer.customer_id 
WHERE country = 'Canada';
	
SELECT title, description, release_year, rental_duration, rental_rate, length, replacement_cost, rating, special_features 
FROM film WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id IN (SELECT category_id FROM category WHERE name ='Family'));
	
SELECT title, film_rental_count 
FROM film JOIN (SELECT film_id, SUM(inventory_rental_count) AS film_rental_count 
FROM inventory JOIN (
						SELECT inventory_id, COUNT(rental_id) AS inventory_rental_count 
                        FROM rental 
                        GROUP BY inventory_id) AS rental_count ON inventory.inventory_id = rental_count.inventory_id 
                        GROUP BY film_id) AS rent_count ON film.film_id = rent_count.film_id 
ORDER BY film_rental_count DESC;
	
SELECT store_id, staff_total_amount AS store_total_amount 
FROM store JOIN (
				SELECT staff_id, SUM(amount) AS staff_total_amount 
                FROM payment 
                GROUP BY staff_id) 
AS staff_amount ON store.manager_staff_id = staff_amount.staff_id;
	
SELECT store_id, city, country 
FROM store JOIN address ON store.address_id = address.address_id 
JOIN city ON address.city_id = city.city_id 
JOIN country ON city.country_id = country.country_id;
	
SELECT name, SUM(amount) AS gross_revenue 
FROM category JOIN film_category ON category.category_id = film_category.category_id 
JOIN inventory ON film_category.film_id = inventory.film_id 
JOIN rental ON inventory.inventory_id = rental.inventory_id 
JOIN payment ON rental.rental_id = payment.rental_id 
GROUP BY name 
ORDER BY SUM(amount) DESC LIMIT 5;
	

CREATE VIEW top_five_genres AS (
								SELECT name, SUM(amount) AS gross_revenue 
                                FROM category 
                                JOIN film_category ON category.category_id = film_category.category_id 
                                JOIN inventory ON film_category.film_id = inventory.film_id 
                                JOIN rental ON inventory.inventory_id = rental.inventory_id 
                                JOIN payment ON rental.rental_id = payment.rental_id 
                                GROUP BY name ORDER BY SUM(amount) DESC LIMIT 5);
	

	#8b.
	SELECT * FROM top_five_genres;
	

	#8c.
	DROP VIEW top_five_genres;


