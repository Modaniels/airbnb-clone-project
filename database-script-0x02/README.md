# Database Seed Data Deployment Guide

## Overview
This directory contains the SQL DML (Data Manipulation Language) script for populating the Airbnb-like database with realistic sample data. The seed script creates test data for all entities, demonstrating real-world usage scenarios.

## Files
- **seed.sql**: Complete DML script with INSERT statements for all tables

## Sample Data Overview

### Users (10 total)
- 5 hosts (users with is_host = TRUE)
- 8 guests (users with is_guest = TRUE)
- 3 users who are both hosts and guests
- Realistic contact information and profile data

### Amenities (20 total)
- WiFi, Kitchen, AC, Heating, Washer/Dryer
- Parking, Pool, Hot Tub, Gym
- TV, Workspace, Alarm System, Security features
- Essential items (linens, toiletries, etc.)

### Properties (8 total)
Diverse property types:
- **Cozy Downtown Apartment** (New York) - 1 bed, $150/night
- **Beachfront Villa** (Miami) - 4 bed, $350/night
- **Mountain Cabin Retreat** (Denver) - 3 bed, $200/night
- **Urban Studio Loft** (Los Angeles) - 1 bed, $120/night
- **Suburban Family Home** (Houston) - 5 bed, $250/night
- **Luxury Downtown Penthouse** (Chicago) - 3 bed, $400/night
- **Lakeside Cottage** (Seattle) - 2 bed, $180/night
- **Historic Victorian Mansion** (Boston) - 4 bed, $320/night

### Bookings (12 total)
- Mix of statuses: Pending, Confirmed, Completed, Cancelled
- Realistic date ranges (November 2025 and October 2025)
- Various guest counts and total prices

### Reviews (5 total)
- Ratings from 4-5 stars
- Authentic-sounding feedback
- Linked to completed bookings

### Payments (12 total)
- Multiple payment methods: Credit Card, Debit Card, PayPal, Bank Transfer
- Various statuses: Pending, Completed, Refunded
- Transaction IDs for tracking

### Messages (8 total)
- Realistic host-guest communication
- Mix of read and unread messages
- Common inquiry and confirmation patterns

## Deployment Instructions

### Prerequisites
1. Schema must be deployed first (run `database-script-0x01/schema.sql`)
2. Database `airbnb_db` must exist
3. All tables must be created with foreign key relationships

### Option 1: Using MySQL Command Line
```bash
mysql -u username -p airbnb_db < seed.sql
```

### Option 2: Using MySQL Client GUI (MySQL Workbench)
1. Open MySQL Workbench
2. Click **File** → **Open SQL Script**
3. Select `seed.sql`
4. Review the script
5. Click **Execute** (or press Ctrl+Shift+Enter)
6. Verify data insertion with verification queries at end of script

### Option 3: Step by Step in MySQL Shell
```bash
mysql -u username -p airbnb_db
```
Then execute:
```sql
SOURCE /path/to/seed.sql;
```

### Option 4: Direct Copy-Paste
1. Open MySQL Workbench
2. Connect to `airbnb_db`
3. Open a new SQL editor tab
4. Copy and paste contents of `seed.sql`
5. Execute all or in sections

## Data Quality Assurance

### Verification Queries
The seed script includes verification queries at the end. Run these to confirm data insertion:

```sql
-- Count total records
SELECT COUNT(*) FROM user;              -- Should return 10
SELECT COUNT(*) FROM property;          -- Should return 8
SELECT COUNT(*) FROM property_amenity;  -- Should return 20
SELECT COUNT(*) FROM booking;           -- Should return 12
SELECT COUNT(*) FROM review;            -- Should return 5
SELECT COUNT(*) FROM payment;           -- Should return 12
SELECT COUNT(*) FROM message;           -- Should return 8
```

### Sample Queries to Test
```sql
-- Find all properties in a specific city
SELECT * FROM property WHERE city = 'New York';

-- Get bookings for a specific property
SELECT b.*, u.first_name, u.last_name 
FROM booking b
JOIN user u ON b.guest_id = u.user_id
WHERE b.property_id = 1;

-- View available properties view
SELECT * FROM available_properties;

-- Get booking statistics
SELECT * FROM booking_stats_by_property;

-- Host revenue summary
SELECT * FROM host_revenue_summary;
```

## Data Relationships

### User Relationships
- Users can be hosts, guests, or both
- Each property has one host (but hosts can have multiple properties)
- Each booking has one guest and one property
- Users can send/receive messages

### Property Relationships
- Each property has one or more amenities (many-to-many via junction table)
- Each property has zero or more bookings
- Each booking can have zero or more reviews

### Booking Workflow
1. Guest creates booking → Status: Pending
2. Host confirms → Status: Confirmed
3. Guest checks in → Status: Checked In
4. Guest checks out → Status: Completed
5. Guest can review → Creates review record
6. Payment processed → Links booking to payment

### Payment States
- **Pending**: Awaiting processing
- **Completed**: Successfully processed
- **Failed**: Transaction failed
- **Refunded**: Money returned to guest

## Real-World Scenarios Covered

1. **Complete Booking Flow**: Guest books → Payment → Check-in → Review
2. **Host Management**: Hosts with multiple properties, revenue tracking
3. **Communication**: Pre-booking inquiries, confirmations, requests
4. **Review System**: Multi-criteria reviews linked to completed bookings
5. **Payment Diversity**: Various payment methods and statuses
6. **Amenity Mapping**: Different properties with different amenity combinations

## Customization

To customize seed data:

1. **Add More Users**:
```sql
INSERT INTO user (email, password_hash, first_name, last_name, phone_number, is_host, is_guest)
VALUES ('newuser@email.com', 'hashed_pw', 'First', 'Last', '+1-555-0111', TRUE, TRUE);
```

2. **Add More Properties**:
```sql
INSERT INTO property (host_id, title, description, address, city, country, latitude, longitude, property_type, bedrooms, bathrooms, max_guests, price_per_night)
VALUES (1, 'New Property', 'Description', 'Address', 'City', 'Country', 40.7128, -74.0060, 'Apartment', 2, 1, 4, 200.00);
```

3. **Add More Bookings**:
```sql
INSERT INTO booking (guest_id, property_id, check_in_date, check_out_date, total_guests, booking_status, total_price)
VALUES (3, 1, '2025-12-01', '2025-12-05', 2, 'Confirmed', 600.00);
```

## Performance Notes

- Seed script includes ~50 INSERT statements
- Foreign key constraints are checked during insertion
- Indexes are updated automatically
- Total execution time: typically < 1 second

## Rollback

To remove all seeded data (WARNING: This deletes all data):

```sql
DELETE FROM message;
DELETE FROM payment;
DELETE FROM review;
DELETE FROM booking;
DELETE FROM property_amenity_mapping;
DELETE FROM property;
DELETE FROM property_amenity;
DELETE FROM user;
```

Or drop and recreate database:
```sql
DROP DATABASE airbnb_db;
-- Then re-run schema.sql
```

## Next Steps

1. ✅ Deploy schema (`database-script-0x01/schema.sql`)
2. ✅ Seed data (you are here)
3. 🧪 Write and test queries
4. 📊 Generate reports using views
5. 🚀 Connect application code to database

## Support

For issues:
- Check that schema was deployed first
- Verify foreign key constraints are not violated
- Ensure data types match table definitions
- Review normalization.md for schema design rationale
