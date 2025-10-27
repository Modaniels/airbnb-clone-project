-- ============================================================================
-- Airbnb-like Database Schema (DDL)
-- ============================================================================
-- This script creates the complete database schema for an Airbnb clone.
-- It includes all tables, constraints, indexes, and relationships.
-- ============================================================================

-- Create database
CREATE DATABASE IF NOT EXISTS airbnb_db;
USE airbnb_db;

-- ============================================================================
-- USER TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    profile_picture_url VARCHAR(500),
    bio TEXT,
    is_host BOOLEAN DEFAULT FALSE,
    is_guest BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    INDEX idx_email (email),
    INDEX idx_created_at (created_at),
    INDEX idx_is_host (is_host),
    INDEX idx_deleted_at (deleted_at)
);

-- ============================================================================
-- PROPERTY TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS property (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    host_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    address VARCHAR(500) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    property_type VARCHAR(50) NOT NULL,
    bedrooms INT NOT NULL,
    bathrooms INT NOT NULL,
    max_guests INT NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    cancellation_policy TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) REFERENCES user(user_id) ON DELETE CASCADE,
    INDEX idx_host_id (host_id),
    INDEX idx_city (city),
    INDEX idx_country (country),
    INDEX idx_is_active (is_active),
    INDEX idx_price_per_night (price_per_night),
    INDEX idx_created_at (created_at),
    INDEX idx_coordinates (latitude, longitude)
);

-- ============================================================================
-- PROPERTY AMENITY TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS property_amenity (
    amenity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name)
);

-- ============================================================================
-- PROPERTY AMENITY MAPPING TABLE (Many-to-Many Junction)
-- ============================================================================
CREATE TABLE IF NOT EXISTS property_amenity_mapping (
    property_amenity_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    amenity_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pam_property FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_pam_amenity FOREIGN KEY (amenity_id) REFERENCES property_amenity(amenity_id) ON DELETE CASCADE,
    UNIQUE KEY unique_property_amenity (property_id, amenity_id),
    INDEX idx_property_id (property_id),
    INDEX idx_amenity_id (amenity_id)
);

-- ============================================================================
-- BOOKING TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_guests INT NOT NULL,
    booking_status ENUM('Pending', 'Confirmed', 'Checked In', 'Completed', 'Cancelled') DEFAULT 'Pending',
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    cancelled_at TIMESTAMP NULL,
    CONSTRAINT fk_booking_guest FOREIGN KEY (guest_id) REFERENCES user(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
    CONSTRAINT chk_dates CHECK (check_in_date < check_out_date),
    CONSTRAINT chk_guests CHECK (total_guests > 0),
    INDEX idx_guest_id (guest_id),
    INDEX idx_property_id (property_id),
    INDEX idx_check_in_date (check_in_date),
    INDEX idx_check_out_date (check_out_date),
    INDEX idx_booking_status (booking_status),
    INDEX idx_created_at (created_at),
    INDEX idx_guest_property_dates (guest_id, property_id, check_in_date, check_out_date)
);

-- ============================================================================
-- REVIEW TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    host_id INT NOT NULL,
    rating INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_booking FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_guest FOREIGN KEY (guest_id) REFERENCES user(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_host FOREIGN KEY (host_id) REFERENCES user(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_rating CHECK (rating >= 1 AND rating <= 5),
    UNIQUE KEY unique_booking_review (booking_id),
    INDEX idx_property_id (property_id),
    INDEX idx_guest_id (guest_id),
    INDEX idx_host_id (host_id),
    INDEX idx_rating (rating),
    INDEX idx_created_at (created_at)
);

-- ============================================================================
-- PAYMENT TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    guest_id INT NOT NULL,
    host_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Other') NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Pending',
    transaction_id VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE,
    CONSTRAINT fk_payment_guest FOREIGN KEY (guest_id) REFERENCES user(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_payment_host FOREIGN KEY (host_id) REFERENCES user(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_amount CHECK (amount > 0),
    INDEX idx_booking_id (booking_id),
    INDEX idx_guest_id (guest_id),
    INDEX idx_host_id (host_id),
    INDEX idx_payment_status (payment_status),
    INDEX idx_created_at (created_at),
    INDEX idx_transaction_id (transaction_id)
);

-- ============================================================================
-- MESSAGE TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS message (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    subject VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES user(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_message_receiver FOREIGN KEY (receiver_id) REFERENCES user(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_sender_receiver CHECK (sender_id != receiver_id),
    INDEX idx_sender_id (sender_id),
    INDEX idx_receiver_id (receiver_id),
    INDEX idx_is_read (is_read),
    INDEX idx_created_at (created_at),
    INDEX idx_receiver_is_read (receiver_id, is_read)
);

-- ============================================================================
-- VIEWS (Optional - for common queries)
-- ============================================================================

-- View for available properties in a date range
CREATE OR REPLACE VIEW available_properties AS
SELECT 
    p.property_id,
    p.title,
    p.city,
    p.price_per_night,
    p.max_guests,
    u.first_name AS host_first_name,
    u.last_name AS host_last_name
FROM property p
INNER JOIN user u ON p.host_id = u.user_id
WHERE p.is_active = TRUE;

-- View for booking statistics by property
CREATE OR REPLACE VIEW booking_stats_by_property AS
SELECT 
    p.property_id,
    p.title,
    COUNT(b.booking_id) AS total_bookings,
    COUNT(CASE WHEN b.booking_status = 'Completed' THEN 1 END) AS completed_bookings,
    AVG(CASE WHEN r.rating IS NOT NULL THEN r.rating ELSE NULL END) AS avg_rating,
    SUM(CASE WHEN b.booking_status = 'Completed' THEN b.total_price ELSE 0 END) AS total_revenue
FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
LEFT JOIN review r ON b.booking_id = r.booking_id
GROUP BY p.property_id, p.title;

-- View for host revenue summary
CREATE OR REPLACE VIEW host_revenue_summary AS
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(DISTINCT p.property_id) AS property_count,
    COUNT(DISTINCT b.booking_id) AS booking_count,
    SUM(CASE WHEN pay.payment_status = 'Completed' THEN pay.amount ELSE 0 END) AS total_revenue
FROM user u
LEFT JOIN property p ON u.user_id = p.host_id
LEFT JOIN booking b ON p.property_id = b.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id
WHERE u.is_host = TRUE
GROUP BY u.user_id, u.first_name, u.last_name, u.email;

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================
