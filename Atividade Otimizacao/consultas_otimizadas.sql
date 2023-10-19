-- (1)
WITH airports_filter AS (
    SELECT
        * 
    FROM    
        bookings.airports
    WHERE
        AIRPORT_CODE = 'BAX'
)

SELECT
    b.BOOK_REF,
    b.BOOK_DATE,
    B.TOTAL_AMOUNT 
FROM
    bookings.flights AS f
INNER JOIN bookings.airports_filter AS af ON
    f.DEPARTURE_AIRPORT = af.AIRPORT_CODE
INNER JOIN bookings.ticket_flights AS tf ON
    f.FLIGHT_ID = tf.FLIGHT_ID
INNER JOIN bookings.tickets AS t ON
    tf.TICKET_NO = t.TICKET_NO 
INNER JOIN bookings.bookings AS b ON
    t.BOOK_REF = b.BOOK_REF
ORDER BY
    b.TOTAL_AMOUNT
DESC;

-- (2)
WITH airports_filter AS (
    SELECT 
        AIRPORT_CODE 
    FROM
        bookings.airports 
    WHERE 
        AIRPORT_NAME = 'Barnaul Airport'
)

SELECT  
    f.FLIGHT_ID,
    COUNT(F.FLIGHT_ID)
FROM 
    bookings.FLIGHTS AS f 
INNER JOIN bookings.ticket_flights AS tf ON
    f.FLIGHT_ID = tf.FLIGHT_ID 
WHERE
    EXISTS (SELECT * FROM airports_filter WHERE AIRPORT_CODE = f.ARRIVAL_AIRPORT OR AIRPORT_CODE = f.DEPARTURE_AIRPORT)
GROUP BY 
    1
ORDER BY    
    1
ASC;

-- (3)
WITH flights_filter AS (
    SELECT
        FLIGHT_ID
    FROM
        bookings.flights
    WHERE
        STATUS = 'Scheduled'
)

SELECT
    b.BOOK_REF,
    COUNT(b.BOOK_REF)
FROM
    bookings.bookings AS b
INNER JOIN bookings.tickets AS t ON
    b.BOOK_REF = t.BOOK_REF
INNER JOIN bookings.ticket_flights AS tf ON
    t.TICKET_NO = tf.TICKET_NO
INNER JOIN flights_filter AS ff ON
    tf.FLIGHT_ID = ff.FLIGHT_ID
GROUP BY
    1
HAVING 
    COUNT(b.BOOK_REF) > 1
ORDER BY    
    1
ASC;

-- (4)
WITH hub AS (
	SELECT 
		flight_no,
		ARRAY_AGG(DISTINCT to_char(f2.scheduled_departure, 'ID'::text)::integer) AS days_of_week
     FROM 
     	bookings.flights f2
     GROUP BY
     	1
)

SELECT 	
	f.FLIGHT_ID,
	f.flight_no,
    f.departure_airport,
    a.airport_name AS departure_airport_name,
    a.city AS departure_city,
    f.arrival_airport,
    a.airport_name AS arrival_airport_name,
    a.city AS arrival_city,
    f.aircraft_code,
    f.scheduled_arrival - f.scheduled_departure AS duration,
    h.days_of_week
FROM 	
	bookings.flights AS f
INNER JOIN bookings.airports AS a ON
	f.DEPARTURE_AIRPORT = a.AIRPORT_CODE 
	OR f.ARRIVAL_AIRPORT = a.AIRPORT_CODE
INNER JOIN hub AS h ON
	f.flight_no = h.flight_no
WHERE 
	a.CITY LIKE '%Petro%';