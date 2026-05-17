-- ============================================================
-- Hotel Management Database System
-- Author: Anusha Srivastava
-- Description: Normalized relational schema for hotel operations
-- ============================================================

CREATE DATABASE IF NOT EXISTS hotel_management;
USE hotel_management;

-- -----------------------------------------------
-- 1. GUESTS
-- -----------------------------------------------
CREATE TABLE guests (
    guest_id      INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    phone         VARCHAR(15),
    nationality   VARCHAR(50),
    id_proof_type ENUM('Passport', 'Aadhar', 'PAN', 'Driving License'),
    id_proof_no   VARCHAR(30),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------
-- 2. ROOM CATEGORIES
-- -----------------------------------------------
CREATE TABLE room_categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,   -- Standard, Deluxe, Suite, Presidential
    base_price    DECIMAL(10,2) NOT NULL,
    max_occupancy INT NOT NULL,
    amenities     TEXT                    -- JSON-style or comma-separated
);

-- -----------------------------------------------
-- 3. ROOMS
-- -----------------------------------------------
CREATE TABLE rooms (
    room_id      INT AUTO_INCREMENT PRIMARY KEY,
    room_number  VARCHAR(10) UNIQUE NOT NULL,
    floor        INT NOT NULL,
    category_id  INT NOT NULL,
    status       ENUM('Available', 'Occupied', 'Under Maintenance', 'Reserved') DEFAULT 'Available',
    FOREIGN KEY (category_id) REFERENCES room_categories(category_id)
);

-- -----------------------------------------------
-- 4. STAFF
-- -----------------------------------------------
CREATE TABLE staff (
    staff_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    role        ENUM('Manager', 'Receptionist', 'Housekeeping', 'Chef', 'Security') NOT NULL,
    department  VARCHAR(50),
    salary      DECIMAL(10,2),
    hire_date   DATE,
    email       VARCHAR(100) UNIQUE
);

-- -----------------------------------------------
-- 5. BOOKINGS
-- -----------------------------------------------
CREATE TABLE bookings (
    booking_id    INT AUTO_INCREMENT PRIMARY KEY,
    guest_id      INT NOT NULL,
    room_id       INT NOT NULL,
    staff_id      INT,                  -- Receptionist who handled check-in
    check_in      DATE NOT NULL,
    check_out     DATE NOT NULL,
    adults        INT DEFAULT 1,
    children      INT DEFAULT 0,
    booking_src   ENUM('Walk-in', 'Online', 'Phone', 'Travel Agent') DEFAULT 'Walk-in',
    status        ENUM('Confirmed', 'Checked-in', 'Checked-out', 'Cancelled') DEFAULT 'Confirmed',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id)  REFERENCES guests(guest_id),
    FOREIGN KEY (room_id)   REFERENCES rooms(room_id),
    FOREIGN KEY (staff_id)  REFERENCES staff(staff_id)
);

-- -----------------------------------------------
-- 6. PAYMENTS
-- -----------------------------------------------
CREATE TABLE payments (
    payment_id     INT AUTO_INCREMENT PRIMARY KEY,
    booking_id     INT NOT NULL,
    amount         DECIMAL(10,2) NOT NULL,
    payment_date   DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('Cash', 'Credit Card', 'Debit Card', 'UPI', 'Net Banking'),
    status         ENUM('Paid', 'Pending', 'Refunded') DEFAULT 'Pending',
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- -----------------------------------------------
-- 7. SERVICES (Room Service / Add-ons)
-- -----------------------------------------------
CREATE TABLE services (
    service_id   INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    category     ENUM('Food', 'Laundry', 'Spa', 'Transport', 'Minibar', 'Other'),
    unit_price   DECIMAL(10,2) NOT NULL
);

-- -----------------------------------------------
-- 8. GUEST SERVICE REQUESTS
-- -----------------------------------------------
CREATE TABLE guest_services (
    gs_id        INT AUTO_INCREMENT PRIMARY KEY,
    booking_id   INT NOT NULL,
    service_id   INT NOT NULL,
    quantity     INT DEFAULT 1,
    requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status       ENUM('Pending', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (booking_id)  REFERENCES bookings(booking_id),
    FOREIGN KEY (service_id)  REFERENCES services(service_id)
);

-- -----------------------------------------------
-- 9. FEEDBACK / REVIEWS
-- -----------------------------------------------
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id  INT NOT NULL,
    rating      TINYINT CHECK (rating BETWEEN 1 AND 5),
    comments    TEXT,
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
