-- LIS

-- 1)
select 
  max(first_name) as first_name, 
  max(last_name) as last_name, 
  sum(amount) as total_spent
from customer
left join payment using (customer_id)
group by customer.customer_id
having sum(amount) > 110

-- 2)
select customer.customer_id
from customer
left join payment using (customer_id)
where payment.customer_id is null
group by customer.customer_id

-- 3)
select sum(amount) as total_sales, month(payment_date) as month_total
from staff
inner join payment using (staff_id)
where staff.staff_id = 345 
    and year(payment_date) = 2022
group by month(payment_date)

-- 4)
select customer_id, payment_date, amount, 
  (
    select sum(amount) 
    from payment sub
    where sub.customer_id = main.customer_id 
      and sub.payment_date <= main.payment_date
  ) as total_cum
from payment main

-- 5)
select c.name as Category, l.name as Language, count(f.film_id) as NumFilms
from film f
join film_category fc using(film_id)
join category c using(category_id)
join language l using(language_id)
group by c.name, l.name
order by c.name, l.name
-- no lo podemos asegurar, ya que una pelicula puede tener más de una categoria (sino categoria sería una columna de film, pero es una tabla aparte con clave primaria siendo film y categoria juntas); entonces saldrán film_id repetidos entre filas de la tabla que agrega (idiomas sí es único y una columna de film)