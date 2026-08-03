# Primero llamamos la base de datos
USE sakila;
## PARTE 1
# utilizamos SELECT para definir que columnas mostrar Y WHERE para filtrar filas 
SELECT * from actor;
select first_name, last_name FROM actor;
SELECT * FROM actor LIMIT 10;
SELECT * FROM actor 
WHERE first_name = 'JOHNNY';  
SELECT * FROM film
WHERE length >= 120;
SELECT * FROM film
WHERE title LIKE 'A%';

## PARTE 2
# Usamos ORDER BY para ordenar los clientes y ASC para ordenar de la A-Z
SELECT first_name, last_name
FROM customer
ORDER BY last_name ASC;
# Aqui combinamoos ORDER BY con LIMIT 
SELECT title, length
from film
order by length desc
limit 5;

##PARTE 3
# usamos INNER JOIN para buscar registros que tengan coincidencia en ambas tablas

SELECT c.first_name, c.last_name, p.amount, p.payment_date
FROM payment p
INNER JOIN customer c ON p.customer_id = c.customer_id;

# Necesitamos conectar rental, inventory y film, asi que los llamamos como estan en la tabla de rental

select f.title, r.rental_date
from rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id;
 
 ##PARTE 4
 # Left join para mostrar todos los registros de la tabla de la izquierda, y si no hay coincidencia en la tabla de la derecha, rellena con NULL.
 select c.first_name, c.last_name
 from customer c
 left join payment p on c.customer_id = p.customer_id
 where p.payment_id is null;
 
 # hacemos lo mismo pero usamos film_actor 
 select f.title, f.length
 from film f
 left join film_actor fa on f.film_id = fa.film_id 
 where fa.actor_id is null;
 
 ##PARTE 5
 # usamos insert, update, delete y usamos where para no afectar toda la tabla
 
 #INSERT
insert into actor (first_name, last_name)
values ('TEMPORAL', 'ACTOR');
# UPDATE
update actor
set last_name = 'MODIFICADO'
where first_name = 'TEMPORAL';
# DELETE
delete from actor
where first_name = 'TEMPORAL';

##PARTE 6
# usamos SUM para calcular los clientes con mayor cantidad de dinero pagado
select c.first_name, c.last_name, sum(p.amount) as total_pagado
from customer c 
inner join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by total_pagado desc
limit 5;

# Hacemos el mismo proceso anterior pero ahora usamos COUNT para contar registros
 select f.title, count(r.rental_id) as veces_alquilada
 from rental r
 inner join inventory i on r.inventory_id = i.inventory_id
 inner join film f on i.film_id = f.film_id
 group by f.film_id
 order by veces_alquilada desc
 limit 5;
