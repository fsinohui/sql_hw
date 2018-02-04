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
    

