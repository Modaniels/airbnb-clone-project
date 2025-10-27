-- ============================================================================
-- Airbnb-like Database Seed Script (DML)
-- ============================================================================
-- This script populates the airbnb_db database with realistic sample data.
-- Execute this after running schema.sql
-- ============================================================================

USE airbnb_db;

-- ============================================================================
-- SEED: USERS
-- ============================================================================
INSERT INTO user (email, password_hash, first_name, last_name, phone_number, profile_picture_url, bio, is_host, is_guest)
VALUES
('john_doe@email.com', 'hashed_password_1', 'John', 'Doe', '+1-555-0101', 'https://api.example.com/users/1/profile.jpg', 'Passionate traveler exploring the world', TRUE, TRUE),
('jane_smith@email.com', 'hashed_password_2', 'Jane', 'Smith', '+1-555-0102', 'https://api.example.com/users/2/profile.jpg', 'Love to host and meet new people', TRUE, TRUE),
('michael_jones@email.com', 'hashed_password_3', 'Michael', 'Jones', '+1-555-0103', 'https://api.example.com/users/3/profile.jpg', 'Adventure seeker', FALSE, TRUE),
('emily_wilson@email.com', 'hashed_password_4', 'Emily', 'Wilson', '+1-555-0104', 'https://api.example.com/users/4/profile.jpg', 'Host with multiple properties', TRUE, FALSE),
('david_brown@email.com', 'hashed_password_5', 'David', 'Brown', '+1-555-0105', 'https://api.example.com/users/5/profile.jpg', 'Frequent traveler', FALSE, TRUE),
('sarah_taylor@email.com', 'hashed_password_6', 'Sarah', 'Taylor', '+1-555-0106', 'https://api.example.com/users/6/profile.jpg', 'Beach resort enthusiast', FALSE, TRUE),
('robert_anderson@email.com', 'hashed_password_7', 'Robert', 'Anderson', '+1-555-0107', 'https://api.example.com/users/7/profile.jpg', 'Luxury apartment host', TRUE, FALSE),
('alice_martinez@email.com', 'hashed_password_8', 'Alice', 'Martinez', '+1-555-0108', 'https://api.example.com/users/8/profile.jpg', 'Budget traveler', FALSE, TRUE),
('christopher_lee@email.com', 'hashed_password_9', 'Christopher', 'Lee', '+1-555-0109', 'https://api.example.com/users/9/profile.jpg', 'City explorer', FALSE, TRUE),
('jessica_white@email.com', 'hashed_password_10', 'Jessica', 'White', '+1-555-0110', 'https://api.example.com/users/10/profile.jpg', 'Boutique property manager', TRUE, TRUE);

-- ============================================================================
-- SEED: AMENITIES
-- ============================================================================
INSERT INTO property_amenity (name, description)
VALUES
('WiFi', 'High-speed wireless internet connection'),
('Kitchen', 'Fully equipped kitchen with appliances'),
('Air Conditioning', 'Climate control air conditioning'),
('Heating', 'Central heating system'),
('Washer', 'In-unit laundry washing machine'),
('Dryer', 'In-unit laundry dryer'),
('Parking', 'Dedicated or available parking space'),
('Pool', 'Swimming pool access'),
('Hot Tub', 'Heated hot tub or jacuzzi'),
('Gym', 'Fitness center or gym equipment'),
('TV', 'Flat-screen television'),
('Workspace', 'Dedicated work desk and chair'),
('Alarm System', 'Security alarm system'),
('Smoke Detector', 'Smoke detection system'),
('Fire Extinguisher', 'Fire safety equipment'),
('First Aid Kit', 'Emergency first aid supplies'),
('Essentials', 'Linens, towels, and toiletries'),
('Hair Dryer', 'Bathroom hair dryer'),
('Iron', 'Clothing iron available'),
('Crib', 'Baby crib for infants');

-- ============================================================================
-- SEED: PROPERTIES
-- ============================================================================
INSERT INTO property (host_id, title, description, address, city, country, latitude, longitude, property_type, bedrooms, bathrooms, max_guests, price_per_night, cancellation_policy, is_active)
VALUES
(1, 'Cozy Downtown Apartment', 'Charming 1-bedroom apartment in the heart of downtown with stunning city views', '123 Main St', 'New York', 'USA', 40.7128, -74.0060, 'Apartment', 1, 1, 2, 150.00, 'Flexible', TRUE),
(2, 'Beachfront Villa', 'Luxurious 4-bedroom villa with direct beach access and ocean views', '456 Beach Ave', 'Miami', 'USA', 25.7907, -80.1300, 'Villa', 4, 3, 8, 350.00, 'Moderate', TRUE),
(4, 'Mountain Cabin Retreat', 'Peaceful 3-bedroom cabin surrounded by nature with hiking trails', '789 Forest Rd', 'Denver', 'USA', 39.7392, -104.9903, 'House', 3, 2, 6, 200.00, 'Strict', TRUE),
(1, 'Urban Studio Loft', 'Modern studio loft with high ceilings and artistic decor in trendy neighborhood', '321 Art St', 'Los Angeles', 'USA', 34.0522, -118.2437, 'Apartment', 1, 1, 2, 120.00, 'Flexible', TRUE),
(4, 'Suburban Family Home', 'Spacious 5-bedroom family home with backyard and pool', '555 Oak Lane', 'Houston', 'USA', 29.7604, -95.3698, 'House', 5, 3, 10, 250.00, 'Moderate', TRUE),
(7, 'Luxury Downtown Penthouse', 'High-end 3-bedroom penthouse with panoramic city views and smart home features', '999 Tower Pl', 'Chicago', 'USA', 41.8781, -87.6298, 'Apartment', 3, 2, 6, 400.00, 'Strict', TRUE),
(2, 'Lakeside Cottage', 'Charming 2-bedroom cottage with lake views and private dock access', '111 Lake Shore Dr', 'Seattle', 'USA', 47.6062, -122.3321, 'House', 2, 1, 4, 180.00, 'Flexible', TRUE),
(7, 'Historic Victorian Mansion', 'Elegant 4-bedroom Victorian mansion with antique furnishings', '222 Heritage Ave', 'Boston', 'USA', 42.3601, -71.0589, 'House', 4, 2, 8, 320.00, 'Moderate', TRUE);

-- ============================================================================
-- SEED: PROPERTY AMENITY MAPPINGS
-- ============================================================================
INSERT INTO property_amenity_mapping (property_id, amenity_id)
VALUES
-- Property 1: Cozy Downtown Apartment
(1, 1), (1, 2), (1, 3), (1, 11), (1, 12), (1, 14), (1, 17),
-- Property 2: Beachfront Villa
(2, 1), (2, 2), (2, 3), (2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 14), (2, 17),
-- Property 3: Mountain Cabin Retreat
(3, 1), (3, 2), (3, 4), (3, 14), (3, 15), (3, 17),
-- Property 4: Urban Studio Loft
(4, 1), (4, 2), (4, 3), (4, 11), (4, 12), (4, 14), (4, 17),
-- Property 5: Suburban Family Home
(5, 1), (5, 2), (5, 3), (5, 5), (5, 6), (5, 7), (5, 8), (5, 11), (5, 14), (5, 17),
-- Property 6: Luxury Downtown Penthouse
(6, 1), (6, 2), (6, 3), (6, 10), (6, 11), (6, 12), (6, 14), (6, 17),
-- Property 7: Lakeside Cottage
(7, 1), (7, 2), (7, 4), (7, 11), (7, 14), (7, 17),
-- Property 8: Historic Victorian Mansion
(8, 1), (8, 2), (8, 3), (8, 11), (8, 14), (8, 15), (8, 17);

-- ============================================================================
-- SEED: BOOKINGS
-- ============================================================================
INSERT INTO booking (guest_id, property_id, check_in_date, check_out_date, total_guests, booking_status, total_price)
VALUES
(3, 1, '2025-11-01', '2025-11-05', 2, 'Confirmed', 600.00),
(5, 2, '2025-11-10', '2025-11-15', 4, 'Confirmed', 1750.00),
(6, 3, '2025-11-05', '2025-11-08', 3, 'Completed', 600.00),
(8, 1, '2025-10-28', '2025-10-31', 2, 'Completed', 450.00),
(9, 4, '2025-11-15', '2025-11-18', 2, 'Pending', 360.00),
(3, 5, '2025-11-20', '2025-11-25', 6, 'Confirmed', 1250.00),
(5, 6, '2025-11-12', '2025-11-14', 4, 'Pending', 800.00),
(6, 7, '2025-11-08', '2025-11-12', 2, 'Completed', 720.00),
(8, 8, '2025-11-03', '2025-11-07', 4, 'Completed', 1280.00),
(9, 2, '2025-11-22', '2025-11-27', 6, 'Confirmed', 1750.00),
(3, 4, '2025-10-25', '2025-10-29', 2, 'Completed', 480.00),
(5, 3, '2025-11-18', '2025-11-22', 4, 'Pending', 800.00);

-- ============================================================================
-- SEED: REVIEWS
-- ============================================================================
INSERT INTO review (booking_id, guest_id, property_id, host_id, rating, title, comment)
VALUES
(3, 6, 3, 4, 5, 'Amazing mountain escape!', 'The cabin was perfect for our getaway. Beautiful views, well-maintained, and the host was very responsive.'),
(4, 8, 1, 1, 4, 'Great location and comfortable', 'Very clean apartment in a convenient location. The neighborhood is lively with lots of restaurants nearby. Only wish the shower pressure was stronger.'),
(8, 6, 7, 2, 5, 'Peaceful lakeside retreat', 'Absolutely wonderful experience! The cottage is cozy, the lake views are stunning, and the dock access is a great bonus.'),
(9, 8, 8, 7, 5, 'Historical elegance and comfort', 'The Victorian mansion is a dream! Beautifully decorated with authentic antiques. Host provided excellent local recommendations.'),
(11, 3, 4, 1, 4, 'Nice studio, good value', 'Clean and modern studio with everything needed. Host was friendly and check-in was smooth. Would stay again.');

-- ============================================================================
-- SEED: PAYMENTS
-- ============================================================================
INSERT INTO payment (booking_id, guest_id, host_id, amount, payment_method, payment_status, transaction_id)
VALUES
(1, 3, 1, 600.00, 'Credit Card', 'Completed', 'TXN-2025-001-12345'),
(2, 5, 2, 1750.00, 'Credit Card', 'Completed', 'TXN-2025-002-12346'),
(3, 6, 4, 600.00, 'Debit Card', 'Completed', 'TXN-2025-003-12347'),
(4, 8, 1, 450.00, 'PayPal', 'Completed', 'TXN-2025-004-12348'),
(5, 9, 1, 360.00, 'Credit Card', 'Pending', 'TXN-2025-005-12349'),
(6, 3, 4, 1250.00, 'Bank Transfer', 'Completed', 'TXN-2025-006-12350'),
(7, 5, 7, 800.00, 'Credit Card', 'Pending', 'TXN-2025-007-12351'),
(8, 6, 2, 720.00, 'Debit Card', 'Completed', 'TXN-2025-008-12352'),
(9, 8, 7, 1280.00, 'Credit Card', 'Completed', 'TXN-2025-009-12353'),
(10, 9, 2, 1750.00, 'Credit Card', 'Completed', 'TXN-2025-010-12354'),
(11, 3, 1, 480.00, 'PayPal', 'Completed', 'TXN-2025-011-12355'),
(12, 5, 4, 800.00, 'Credit Card', 'Pending', 'TXN-2025-012-12356');

-- ============================================================================
-- SEED: MESSAGES
-- ============================================================================
INSERT INTO message (sender_id, receiver_id, subject, body, is_read)
VALUES
(1, 3, 'Question about apartment', 'Hi! I have a question about the check-in time. Can I arrive at 2 PM instead of 3 PM? Thanks!', FALSE),
(3, 1, 'Re: Question about apartment', 'Sure! Early check-in is possible. Just let me know your arrival time. Looking forward to hosting you!', TRUE),
(2, 5, 'Booking confirmation for villa', 'Great! Your booking is confirmed. Here are the WiFi credentials and house rules.', TRUE),
(5, 2, 'Re: Booking confirmation', 'Thanks so much! Everything looks perfect. See you soon!', TRUE),
(4, 6, 'Property inquiry', 'Hi! I noticed your property has a pool. Are there any additional fees for using it?', FALSE),
(6, 4, 'Re: Property inquiry', 'Hi! The pool is included in the nightly rate with no extra fees. Towels are provided in the pool house.', TRUE),
(7, 8, 'Review request', 'Thank you for staying at our penthouse! We would love to hear about your experience.', FALSE),
(8, 7, 'Re: Review request', 'Just left a 5-star review! Your place is amazing. Thanks for being such a great host!', TRUE);

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Count records in each table
SELECT 'users' AS table_name, COUNT(*) AS record_count FROM user
UNION ALL
SELECT 'properties', COUNT(*) FROM property
UNION ALL
SELECT 'amenities', COUNT(*) FROM property_amenity
UNION ALL
SELECT 'property_amenity_mappings', COUNT(*) FROM property_amenity_mapping
UNION ALL
SELECT 'bookings', COUNT(*) FROM booking
UNION ALL
SELECT 'reviews', COUNT(*) FROM review
UNION ALL
SELECT 'payments', COUNT(*) FROM payment
UNION ALL
SELECT 'messages', COUNT(*) FROM message;

-- ============================================================================
-- END OF SEED DATA
-- ============================================================================
