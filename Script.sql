--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.

select film.title ,film.rating 
from film
where rating = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

select actor_id , concat(a.first_name , ' ' , a.last_name) as nombre_actor 
from actor a 
where actor_id <= 40 and a.actor_id >= 30;

--4. Obtén las películas cuyo idioma coincide con el idioma original.

select title
from film f 
where language_id = f.original_language_id ;

--5. Ordena las películas por duración de forma ascendente.

select f.title , f.length 
from film f 
order by f.length ;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

select concat(a.first_name , ' ' , a.last_name) as nombre_actor 
from actor a
where a.last_name ='ALLEN' ;

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

select f.rating , count(f.film_id) as numero_peliculas
from film f
group by f.rating  ;

--8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.

select title , rating , f.length  
from film f 
where rating = 'PG-13' or f.length >= 180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select round(variance(f.replacement_cost),2) as coste_variabilidad
from film f ;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select min(length) as duracion_minima , max(length) as duracion_maxima
from film f ;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select p.amount , p.payment_date 
from payment p 
order by p.payment_date desc;

--12.Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.

select title, film.rating 
from film
where rating <> 'NC-17' and rating <> 'G'
order by rating;

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

select f.rating , avg(length) as promedio_duracion
from film f
group by f.rating ;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select title , rating , f.length  
from film f 
where f.length >= 180;

--15. ¿Cuánto dinero ha generado en total la empresa?

select sum(p.amount )
from payment p ;

--16. Muestra los 10 clientes con mayor valor de id.

select c.customer_id, c.first_name , c.last_name  
from customer c 
order by c.customer_id desc
limit 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

select concat(a.first_name , ' ', a.last_name) as nombre_actor , f.title 
from actor a
join film_actor fa 
	on a.actor_id = fa.actor_id
join film f 
	on f.film_id = fa.film_id
where f.title = 'EGG IGBY'; 

--18. Selecciona todos los nombres de las películas únicos.

select distinct(title)
from film ;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

select f.title , f.length , c."name" 
from film f 
join film_category fc 
	on f.film_id  = fc.film_id
join category c 
	on fc.category_id = c.category_id
where c."name" = 'Comedy' and f.length > 180;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

select c."name" , avg(f.length) as promedio_duracion  
from film f 
join film_category fc 
	on f.film_id  = fc.film_id
join category c 
	on fc.category_id = c.category_id
group by c."name"
having avg(f.length) > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?

select round(avg(f.rental_duration ),1) as media_duracion_alquiler --Mejor un numero entero porque 4.98 dias de media es un lenguaje que no se usa
from film f ;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

select concat(a.first_name , ' ' , a.last_name )
from actor a ;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select date(r.rental_date )  as dia_alquiler, count(r.rental_id )  as numero_alquileres
from rental r 
group by dia_alquiler  
order by numero_alquileres desc;

--24. Encuentra las películas con una duración superior al promedio.

select title , length
from film
where length > (
	select avg(length)
	from film);

--25. Averigua el número de alquileres registrados por mes.´

select extract(year from rental.rental_date ) as año_alquiler, count(rental_id) as numero_alquileres
from rental
group by año_alquiler;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select round(avg(amount),2) as promedio_pagado,
	   round(stddev(amount),2) desviacion_estandar_pagado,
	   round(variance(amount),2) as varianza_pagado
from payment p  ;

--27. ¿Qué películas se alquilan por encima del precio medio?


select title, p.amount
from film f 
join inventory i 
	on f.film_id = i.film_id
join rental r 
	on i.inventory_id = r.inventory_id
join payment p 
	on r.rental_id = p.rental_id
where amount > (
	select avg(amount)
	from payment
	);

--28. Muestra el id de los actores que hayan participado en más de 40 películas.

select concat(a.first_name , ' ' , a.last_name ) as nombre_actor, count(a.actor_id) as numero_peliculas
from film f  
join film_actor fa 
	on f.film_id = fa.film_id
join actor a 
	on a.actor_id = fa.actor_id
group by nombre_actor 
having count(a.actor_id) > 40;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select title, count(f.film_id ) as numero_disponible
from film f 
join inventory i 
	on f.film_id = i.film_id
join store s 
	on i.store_id = s.store_id
where s.store_id = 1
group by f.title ;

--30. Obtener los actores y el número de películas en las que ha actuado.

select concat(a.first_name, ' ' ,a.last_name) as nombre_actor, count(a.actor_id ) as numero_actuaciones
from film f 
join film_actor fa 
	on f.film_id = fa.film_id
join actor a 
	on fa.actor_id = a.actor_id
group by nombre_actor ;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select  f.title, concat(a.first_name, ' ' ,a.last_name) as nombre_actor
from film f 
full join film_actor fa 
	on f.film_id = fa.film_id
full join actor a 
	on fa.actor_id = a.actor_id
order by title;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select  concat(a.first_name, ' ' ,a.last_name) as nombre_actor,f.title
from film f 
full join film_actor fa 
	on f.film_id = fa.film_id
full join actor a 
	on fa.actor_id = a.actor_id
order by nombre_actor;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.

select *
from film f 
full join inventory i 
	on f.film_id = i.film_id
full join rental r 
	on i.inventory_id = r.inventory_id ;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select concat(c.first_name ,' ', c.last_name) as nombre_cliente ,sum(amount) as cantidad_gastada
from payment p 
join customer c 
	on p.customer_id = c.customer_id
group by nombre_cliente
order by cantidad_gastada desc
limit 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select concat(first_name, ' ' , last_name) 
from actor
where first_name = 'JOHNNY';

--36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.

select a.first_name as Nombre, a.last_name as Apellido
from actor a ;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select max(a.actor_id ), min(a.actor_id )
from actor a ;

--38. Cuenta cuántos actores hay en la tabla “actorˮ.

select count(actor_id)
from actor;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select actor.first_name, actor.last_name 
from actor
order by actor.last_name ;

--40. Selecciona las primeras 5 películas de la tabla “filmˮ.

select *
from film f 
limit 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select a.first_name , count(a.actor_id) as numero_veces_repetidos
from actor a 
group by a.first_name 
order by numero_veces_repetidos desc; --Kenneth es el nombre mas repetido

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select *
from customer c 
join rental r 
	on c.customer_id = r.customer_id;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

select *
from customer c 
full join rental r 
	on c.customer_id = r.customer_id;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

select *
from film f 
cross join category;

-- Aporta valor si queremos saber todas las combinaciones existentes entre las dos tablas, si no queremos, no aporta valor alguno.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

select concat(a.first_name, ' ', a.last_name), c."name"  
from actor a 
join film_actor fa 
	on a.actor_id = fa.actor_id
join film f 
	on fa.film_id = f.film_id 
join film_category fc 
	on f.film_id = fc.film_id
join category c 
	on fc.category_id = c.category_id
where c."name" = 'Action';

--46.  Encuentra todos los actores que no han participado en películas.

select concat(a.first_name, ' ' ,a.last_name) as nombre_actor, f.title
from film f 
full join film_actor fa 
	on f.film_id = fa.film_id
full join actor a 
	on fa.actor_id = a.actor_id
where f.title = null
order by nombre_actor ;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select concat(a.first_name, ' ' ,a.last_name) as nombre_actor, count(a.actor_id ) as numero_actuaciones
from film f 
join film_actor fa 
	on f.film_id = fa.film_id
join actor a 
	on fa.actor_id = a.actor_id
group by nombre_actor ;

--48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as
select concat(a.first_name, ' ' ,a.last_name) as nombre_actor, count(a.actor_id ) as numero_actuaciones
from film f 
join film_actor fa 
	on f.film_id = fa.film_id
join actor a 
	on fa.actor_id = a.actor_id
group by nombre_actor ;

--49. Calcula el número total de alquileres realizados por cada cliente.

select concat(c.first_name, ' ', c.last_name) as nombre_cliente, count(r.rental_id ) as numero_alquileres
from rental r 
join customer c 
	on r.customer_id = c.customer_id
group by nombre_cliente ;

--50. Calcula la duración total de las películas en la categoría 'Action'.

select c."name" , sum(f.length ) as duracion_total
from film f 
join film_category fc 
	on f.film_id = fc.film_id 
join category c 
	on fc.category_id = c.category_id
where c."name" = 'Action'
group by c."name" ;

--51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.

create temporary table cliente_rentas_temporal as
	select concat(c.first_name, ' ', c.last_name) as nombre_cliente, count(r.rental_id ) as numero_alquileres
	from rental r 
	join customer c
		on r.customer_id = c.customer_id
	group by nombre_cliente ;

--52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.

create temporary table peliculas_alquiladas as
	select f.title, count(r.rental_id) as numero_veces_alquiladas
	from rental r 
	join inventory i 
		on r.inventory_id = i.inventory_id
	join film f 
		on i.film_id = f.film_id
	group by f.title 
	having count(r.rental_id) > 10;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

select distinct f.title
from customer c
join store s 
	on c.store_id = s.store_id
join inventory i 
	on s.store_id = i.store_id
join film f 
	on i.film_id = f.film_id
where c.first_name  = 'TAMMY' and c.last_name = 'SANDERS'and s.store_id = 2
order by f.title ;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.

select concat(a.first_name, ' ', a.last_name)
from category c 
join film_category fc 
	on c.category_id = fc.category_id
join film f 
	on f.film_id = fc.film_id
join film_actor fa 
	on f.film_id = fa.film_id
join actor a 
	on fa.actor_id = a.actor_id
where c."name" = 'Sci-Fi'
order by a.last_name;

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

select distinct a.first_name, a.last_name
from actor a
join film_actor fa 
	on a.actor_id = fa.actor_id
join inventory i 
	on fa.film_id = i.film_id
join rental r 
	on i.inventory_id = r.inventory_id
where r.rental_date > (
    select MIN(r2.rental_date)
    from film f
    join inventory i2 
    	on f.film_id = i2.film_id
    join rental r2 
    	on i2.inventory_id = r2.inventory_id
    where f.title = 'SPARTACUS CHEAPER'
)
order by a.last_name;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.

select a.first_name, a.last_name
from actor a
where not exists (
    select 1
    from film_actor fa
    join film_category fc 
    	on fa.film_id = fc.film_id
    join category c 
    	on fc.category_id = c.category_id
    where fa.actor_id = a.actor_id and c.name = 'Music'
);

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

select f.title
from film f
join inventory i 
	on f.film_id = i.film_id
join rental r 
	on i.inventory_id = r.inventory_id
where (date(return_date) - date(rental_date)) > 8;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

select title
from film
where film_id IN (
  select category_id
  from category c 
  where c."name"  = 'Animation'
);

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.

select *
from film f 
where length = (
	select film.length 
	from film
	where title = 'DANCING FEVER'
	);

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

select c.first_name, c.last_name
from customer c
where (
    select count(distinct i.film_id)
    from rental r
    join inventory i 
    	on r.inventory_id = i.inventory_id
    where r.customer_id = c.customer_id
) >= 7
order by c.last_name;


--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

select c.name AS categoria,
       (
         select COUNT(*) 
         from film_category fc
         where fc.category_id = c.category_id
       ) as total_peliculas
from category c;

--62. Encuentra el número de películas por categoría estrenadas en 2006.

select c.name as categoria,
       (
         select COUNT(*) 
         from film_category fc
         where fc.category_id = c.category_id 
       ) as total_peliculas
from category c
where (
	select release_year
	from film f
	where f.film_id = c.category_id
) = 2006;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

select *
from staff s 
cross join address a ;

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

select r.customer_id ,concat(c.first_name, ' ', c.last_name) as nombre_cliente, count(r.rental_id ) as numero_alquileres
from rental r 
join customer c 
	on r.customer_id = c.customer_id
group by nombre_cliente,r.customer_id  ;
