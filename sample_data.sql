-- ============================================================
-- Sample Data — Hotel Management System
-- ============================================================

USE hotel_management;

-- ROOM CATEGORIES
INSERT INTO room_categories (category_name, base_price, max_occupancy, amenities) VALUES
('Standard',     2500.00, 2, 'WiFi, TV, AC'),
('Deluxe',       4500.00, 2, 'WiFi, TV, AC, Mini-fridge, King Bed'),
('Suite',        8000.00, 3, 'WiFi, TV, AC, Jacuzzi, Living Room, King Bed'),
('Presidential',18000.00, 4, 'WiFi, TV, AC, Jacuzzi, Private Pool, Butler, King Bed');

-- ROOMS
INSERT INTO rooms (room_number, floor, category_id, status) VALUES
('101', 1, 1, 'Available'), ('102', 1, 1, 'Occupied'),
('103', 1, 1, 'Available'), ('201', 2, 2, 'Available'),
('202', 2, 2, 'Occupied'),  ('203', 2, 2, 'Reserved'),
('301', 3, 3, 'Available'), ('302', 3, 3, 'Occupied'),
('401', 4, 4, 'Available'), ('402', 4, 4, 'Under Maintenance');

-- STAFF
INSERT INTO staff (full_name, role, department, salary, hire_date, email) VALUES
('Ramesh Kumar',   'Manager',       'Administration', 75000, '2019-03-15', 'ramesh@grandhotel.com'),
('Sunita Sharma',  'Receptionist',  'Front Desk',     30000, '2021-06-01', 'sunita@grandhotel.com'),
('Vikram Nair',    'Receptionist',  'Front Desk',     30000, '2022-01-10', 'vikram@grandhotel.com'),
('Priya Das',      'Housekeeping',  'Housekeeping',   22000, '2020-08-20', 'priya@grandhotel.com'),
('Arjun Mehta',    'Chef',          'Kitchen',        45000, '2018-11-05', 'arjun@grandhotel.com');

-- GUESTS
INSERT INTO guests (first_name, last_name, email, phone, nationality, id_proof_type, id_proof_no) VALUES
('Aditya',   'Kapoor',   'aditya.k@email.com',   '9876543210', 'Indian',   'Aadhar',    'XXXX-XXXX-1234'),
('Meera',    'Iyer',     'meera.i@email.com',     '9812345678', 'Indian',   'Passport',  'Z1234567'),
('James',    'Wilson',   'james.w@email.com',     '9800001111', 'British',  'Passport',  'GB987654'),
('Fatima',   'Sheikh',   'fatima.s@email.com',    '9900002222', 'UAE',      'Passport',  'AE456789'),
('Rohan',    'Verma',    'rohan.v@email.com',     '9988776655', 'Indian',   'PAN',       'ABCDE1234F'),
('Ananya',   'Singh',    'ananya.s@email.com',    '9876000111', 'Indian',   'Aadhar',    'YYYY-YYYY-5678'),
('Carlos',   'Mendez',   'carlos.m@email.com',    '9700000000', 'Spanish',  'Passport',  'ES112233'),
('Preetha',  'Nair',     'preetha.n@email.com',   '9845123456', 'Indian',   'Passport',  'Z7654321');

-- BOOKINGS
INSERT INTO bookings (guest_id, room_id, staff_id, check_in, check_out, adults, children, booking_src, status) VALUES
(1, 2,  2, '2024-11-01', '2024-11-05', 2, 0, 'Online',        'Checked-out'),
(2, 5,  3, '2024-11-03', '2024-11-07', 1, 0, 'Phone',         'Checked-out'),
(3, 8,  2, '2024-11-10', '2024-11-14', 2, 1, 'Travel Agent',  'Checked-out'),
(4, 9,  2, '2024-11-15', '2024-11-20', 2, 0, 'Online',        'Checked-out'),
(5, 1,  3, '2024-12-01', '2024-12-03', 1, 0, 'Walk-in',       'Checked-out'),
(6, 4,  2, '2024-12-05', '2024-12-10', 2, 1, 'Online',        'Checked-out'),
(7, 7,  3, '2024-12-12', '2024-12-15', 2, 0, 'Online',        'Checked-out'),
(8, 6,  2, '2024-12-20', '2024-12-25', 1, 0, 'Phone',         'Checked-out'),
(1, 3,  3, '2025-01-05', '2025-01-08', 2, 0, 'Online',        'Checked-out'),
(2, 4,  2, '2025-01-10', '2025-01-13', 1, 0, 'Online',        'Checked-out');

-- PAYMENTS
INSERT INTO payments (booking_id, amount, payment_method, status) VALUES
(1,  10000.00, 'Credit Card', 'Paid'),
(2,  18000.00, 'UPI',         'Paid'),
(3,  32000.00, 'Net Banking', 'Paid'),
(4,  90000.00, 'Credit Card', 'Paid'),
(5,   5000.00, 'Cash',        'Paid'),
(6,  22500.00, 'Debit Card',  'Paid'),
(7,  24000.00, 'UPI',         'Paid'),
(8,  24000.00, 'Credit Card', 'Paid'),
(9,   7500.00, 'UPI',         'Paid'),
(10, 13500.00, 'Net Banking', 'Paid');

-- SERVICES
INSERT INTO services (service_name, category, unit_price) VALUES
('Continental Breakfast', 'Food',       350.00),
('Room Service Dinner',   'Food',       650.00),
('Laundry (per kg)',      'Laundry',    200.00),
('Spa Session (60 min)',  'Spa',       2500.00),
('Airport Transfer',      'Transport', 1500.00),
('Minibar Restock',       'Minibar',    800.00);

-- GUEST SERVICE REQUESTS
INSERT INTO guest_services (booking_id, service_id, quantity, status) VALUES
(1, 1, 4, 'Delivered'), (1, 3, 2, 'Delivered'),
(2, 2, 2, 'Delivered'), (3, 4, 1, 'Delivered'),
(4, 5, 1, 'Delivered'), (4, 1, 5, 'Delivered'),
(6, 2, 3, 'Delivered'), (7, 4, 2, 'Delivered'),
(8, 6, 1, 'Delivered'), (9, 1, 3, 'Delivered');

-- FEEDBACK
INSERT INTO feedback (booking_id, rating, comments) VALUES
(1, 5, 'Excellent service, clean rooms. Highly recommended!'),
(2, 4, 'Good experience. Staff was very helpful.'),
(3, 5, 'Best hotel stay ever. Suite was stunning.'),
(4, 3, 'Presidential suite was great but room service was slow.'),
(5, 4, 'Nice and comfortable. Good value for money.'),
(6, 5, 'Amazing stay. Will definitely come back!'),
(7, 4, 'Loved the suite. Could improve breakfast options.'),
(8, 5, 'Perfect for a business trip. Excellent WiFi and service.');
