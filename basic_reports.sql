-- ============================================================
-- Basic Reports — Hotel Management System
-- ============================================================

USE hotel_management;

-- -----------------------------------------------
-- Q1: All available rooms with category & price
-- -----------------------------------------------
SELECT
    r.room_number,
    r.floor,
    rc.category_name,
    rc.base_price,
    rc.amenities
FROM rooms r
JOIN room_categories rc ON r.category_id = rc.category_id
WHERE r.status = 'Available'
ORDER BY rc.base_price;

-- -----------------------------------------------
-- Q2: All bookings with guest name and room details
-- -----------------------------------------------
SELECT
    b.booking_id,
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    r.room_number,
    rc.category_name,
    b.check_in,
    b.check_out,
    DATEDIFF(b.check_out, b.check_in) AS nights_stayed,
    b.status
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r  ON b.room_id  = r.room_id
JOIN room_categories rc ON r.category_id = rc.category_id
ORDER BY b.check_in;

-- -----------------------------------------------
-- Q3: Total revenue per booking (room + services)
-- -----------------------------------------------
SELECT
    b.booking_id,
    CONCAT(g.first_name, ' ', g.last_name)           AS guest_name,
    p.amount                                           AS room_charges,
    COALESCE(SUM(gs.quantity * s.unit_price), 0)      AS service_charges,
    p.amount + COALESCE(SUM(gs.quantity * s.unit_price), 0) AS total_bill
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN payments p ON b.booking_id = p.booking_id
LEFT JOIN guest_services gs ON b.booking_id = gs.booking_id
LEFT JOIN services s ON gs.service_id = s.service_id
GROUP BY b.booking_id, guest_name, p.amount
ORDER BY total_bill DESC;

-- -----------------------------------------------
-- Q4: Room occupancy status summary
-- -----------------------------------------------
SELECT
    status,
    COUNT(*) AS room_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM rooms), 2) AS percentage
FROM rooms
GROUP BY status;

-- -----------------------------------------------
-- Q5: Staff performance — bookings handled per receptionist
-- -----------------------------------------------
SELECT
    s.full_name,
    s.role,
    COUNT(b.booking_id) AS bookings_handled
FROM staff s
LEFT JOIN bookings b ON s.staff_id = b.staff_id
GROUP BY s.staff_id, s.full_name, s.role
HAVING s.role = 'Receptionist'
ORDER BY bookings_handled DESC;

-- -----------------------------------------------
-- Q6: Guest feedback summary
-- -----------------------------------------------
SELECT
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    rc.category_name,
    f.rating,
    f.comments
FROM feedback f
JOIN bookings b ON f.booking_id = b.booking_id
JOIN guests g   ON b.guest_id = g.guest_id
JOIN rooms r    ON b.room_id = r.room_id
JOIN room_categories rc ON r.category_id = rc.category_id
ORDER BY f.rating DESC;

-- -----------------------------------------------
-- Q7: Monthly revenue summary
-- -----------------------------------------------
SELECT
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    COUNT(p.payment_id)                  AS total_payments,
    SUM(p.amount)                        AS total_revenue
FROM payments p
WHERE p.status = 'Paid'
GROUP BY month
ORDER BY month;
