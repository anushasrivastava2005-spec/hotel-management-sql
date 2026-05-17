-- ============================================================
-- Advanced Analytics — Hotel Management System
-- Uses: CTEs, Subqueries, Aggregations, Complex JOINs
-- ============================================================

USE hotel_management;

-- -----------------------------------------------
-- Q1: Top 3 highest-spending guests (CTE)
-- -----------------------------------------------
WITH guest_spending AS (
    SELECT
        g.guest_id,
        CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
        SUM(p.amount)                           AS total_spent,
        COUNT(b.booking_id)                     AS total_bookings
    FROM guests g
    JOIN bookings b  ON g.guest_id = b.guest_id
    JOIN payments p  ON b.booking_id = p.booking_id
    WHERE p.status = 'Paid'
    GROUP BY g.guest_id, guest_name
)
SELECT
    guest_name,
    total_bookings,
    total_spent,
    ROUND(total_spent / total_bookings, 2) AS avg_spend_per_booking
FROM guest_spending
ORDER BY total_spent DESC
LIMIT 3;

-- -----------------------------------------------
-- Q2: Average rating per room category
-- -----------------------------------------------
SELECT
    rc.category_name,
    ROUND(AVG(f.rating), 2)     AS avg_rating,
    COUNT(f.feedback_id)        AS total_reviews,
    MIN(f.rating)               AS min_rating,
    MAX(f.rating)               AS max_rating
FROM feedback f
JOIN bookings b ON f.booking_id = b.booking_id
JOIN rooms r    ON b.room_id    = r.room_id
JOIN room_categories rc ON r.category_id = rc.category_id
GROUP BY rc.category_name
ORDER BY avg_rating DESC;

-- -----------------------------------------------
-- Q3: Identify repeat guests (booked more than once)
-- -----------------------------------------------
SELECT
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    g.email,
    g.nationality,
    COUNT(b.booking_id)                    AS total_bookings,
    MIN(b.check_in)                        AS first_visit,
    MAX(b.check_in)                        AS latest_visit
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, guest_name, g.email, g.nationality
HAVING COUNT(b.booking_id) > 1
ORDER BY total_bookings DESC;

-- -----------------------------------------------
-- Q4: Most popular services ordered by guests
-- -----------------------------------------------
SELECT
    s.service_name,
    s.category,
    s.unit_price,
    SUM(gs.quantity)                          AS total_ordered,
    SUM(gs.quantity * s.unit_price)           AS total_revenue_generated
FROM guest_services gs
JOIN services s ON gs.service_id = s.service_id
WHERE gs.status = 'Delivered'
GROUP BY s.service_id, s.service_name, s.category, s.unit_price
ORDER BY total_ordered DESC;

-- -----------------------------------------------
-- Q5: Revenue contribution by booking source
-- -----------------------------------------------
SELECT
    b.booking_src,
    COUNT(b.booking_id)  AS total_bookings,
    SUM(p.amount)        AS total_revenue,
    ROUND(AVG(p.amount), 2) AS avg_booking_value
FROM bookings b
JOIN payments p ON b.booking_id = p.booking_id
WHERE p.status = 'Paid'
GROUP BY b.booking_src
ORDER BY total_revenue DESC;

-- -----------------------------------------------
-- Q6: Rooms that have never been booked (LEFT JOIN)
-- -----------------------------------------------
SELECT
    r.room_number,
    r.floor,
    rc.category_name,
    r.status
FROM rooms r
JOIN room_categories rc ON r.category_id = rc.category_id
LEFT JOIN bookings b ON r.room_id = b.room_id
WHERE b.room_id IS NULL;

-- -----------------------------------------------
-- Q7: Guests with longer-than-average stays
-- -----------------------------------------------
SELECT
    CONCAT(g.first_name, ' ', g.last_name)  AS guest_name,
    r.room_number,
    rc.category_name,
    DATEDIFF(b.check_out, b.check_in)       AS nights_stayed
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r  ON b.room_id  = r.room_id
JOIN room_categories rc ON r.category_id = rc.category_id
WHERE DATEDIFF(b.check_out, b.check_in) > (
    SELECT AVG(DATEDIFF(check_out, check_in)) FROM bookings
)
ORDER BY nights_stayed DESC;

-- -----------------------------------------------
-- Q8: Total outstanding (unpaid) bills
-- -----------------------------------------------
SELECT
    b.booking_id,
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    p.amount,
    p.status
FROM payments p
JOIN bookings b ON p.booking_id = b.booking_id
JOIN guests g   ON b.guest_id   = g.guest_id
WHERE p.status = 'Pending'
ORDER BY p.amount DESC;
