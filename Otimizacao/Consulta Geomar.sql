--Faça uma apresentação das consutlas otimizadas, quais os passos seguidos, plano de custo original e otimizado. Quais ações adicionais foram feitas...


-- (1) Otimize a consulta que mostra todas as reservas (Bookings) dos vôos com saída do aeroporto BAX com ordenação decrescente por total_amount
SELECT
	bookings.*
FROM
	flights,
	ticket_flights,
	tickets,
	bookings,
	airports
WHERE
	flights.flight_id = ticket_flights.flight_id
	AND
ticket_flights.ticket_no = tickets.ticket_no
	AND
tickets.book_ref = bookings.book_ref
	AND
airports.airport_code = flights.departure_airport
	AND
airports.airport_code = 'BAX'
ORDER BY
	bookings.total_amount DESC
	
	
-- (2) Otimize a consulta que seleciona o total de tickets (ticket_flighs) por vôos (flights) que saem ou chegam do aeroporto ‘Barnaul Airport’
SELECT
	flights.flight_id,
	count(*) total_flight_id
FROM
	flights
JOIN ticket_flights ON
	flights.flight_id = ticket_flights.flight_id
WHERE
	flights.arrival_airport IN (
	SELECT
		airport_code
	FROM
		airports
	WHERE
		airport_name =
'Barnaul Airport')
	OR
flights.departure_airport IN (
	SELECT
		airport_code
	FROM
		airports
	WHERE
		airport_name =
'Barnaul Airport')
GROUP BY
	flights.flight_id
ORDER BY
	flights.flight_id
	
	
-- (3) Otimize a consulta que seleciona todos os bookings, o total de tickets por booking de vôos agendados, no qual o booking tenha mais de um ticket
SELECT
	bookings.book_ref,
	count(*)
FROM
	bookings,
	tickets,
	ticket_flights,
	flights
WHERE
	tickets.ticket_no = ticket_flights.ticket_no
	AND
flights.status = 'Scheduled'
	AND
ticket_flights.flight_id = flights.flight_id
	AND
bookings.book_ref = tickets.book_ref
GROUP BY
	bookings.book_ref
HAVING
	count(*) > 1
ORDER BY
	bookings.book_ref

-- (4) Otimizar a consulta que retorna os voos, com seus respectivos aeroportos de partida e chegada tempo médio das viagens e dias da semana que a viagem é feita.
SELECT f2.flight_no,
    f2.departure_airport,
    dep.airport_name AS departure_airport_name,
    dep.city AS departure_city,
    f2.arrival_airport,
    arr.airport_name AS arrival_airport_name,
    arr.city AS arrival_city,
    f2.aircraft_code,
    (SELECT avg(flights.scheduled_arrival - flights.scheduled_departure) FROM bookings.flights WHERE flight_no = f2.flight_no LIMIT 1) duration,
    (SELECT array_agg(DISTINCT to_char(flights.scheduled_departure, 'ID'::text)::integer) FROM bookings.flights WHERE flight_no = f2.flight_no LIMIT 1) days_of_week
   FROM  bookings.flights f2 ,
    bookings.airports dep,
    bookings.airports arr
  WHERE f2.departure_airport = dep.airport_code AND f2.arrival_airport = arr.airport_code 
    AND dep.city LIKE '%Petro%' OR arr.city LIKE '%Petro%'
  
