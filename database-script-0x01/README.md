# Database Schema Deployment Guide

## Overview
This directory contains the SQL DDL (Data Definition Language) scripts for creating the Airbnb-like database schema. The schema is fully normalized to 3NF and includes all necessary tables, constraints, indexes, and views.

## Files
- **schema.sql**: Complete DDL script with all tables, constraints, indexes, and views

## Database Structure

### Tables Created
1. **user**: Stores user accounts (hosts and guests)
2. **property**: Rental properties listed by hosts
3. **property_amenity**: Reference table for available amenities
4. **property_amenity_mapping**: Junction table for many-to-many relationship between properties and amenities
5. **booking**: Reservations made by guests
6. **review**: Guest reviews for properties
7. **payment**: Payment transactions
8. **message**: Direct messages between users

### Views Created
1. **available_properties**: Lists active properties with host information
2. **booking_stats_by_property**: Booking and revenue statistics by property
3. **host_revenue_summary**: Revenue and booking summary for each host

## Deployment Instructions

### Option 1: Using MySQL Command Line
```bash
mysql -u username -p < schema.sql
```

### Option 2: Using MySQL Client GUI (MySQL Workbench)
1. Open MySQL Workbench
2. Click **File** → **Open SQL Script**
3. Select `schema.sql`
4. Review the script
5. Click **Execute** (or press Ctrl+Shift+Enter)
6. Confirm database creation and tables are created successfully

### Option 3: Step by Step in MySQL Shell
```bash
mysql -u username -p
```
Then paste the contents of `schema.sql` line by line or execute:
```sql
SOURCE /path/to/schema.sql;
```

## Key Features

### Constraints
- **Primary Keys (PK)**: All tables have surrogate primary keys for efficient indexing
- **Foreign Keys (FK)**: Enforced referential integrity with cascade delete policies
- **Unique Constraints**: Email uniqueness, transaction ID uniqueness, composite uniqueness for property-amenity pairs
- **Check Constraints**: Data validation (e.g., dates, ratings, amounts)

### Indexes
- **Single-column indexes** on frequently queried fields (email, user_id, property_id, etc.)
- **Composite indexes** for common query patterns (guest_id + property_id + dates)
- **Spatial indexes** on coordinates for location-based queries

### Data Types
- **INT**: For IDs and counts
- **VARCHAR(n)**: For text fields with known max length
- **TEXT**: For longer content (descriptions, reviews, bio)
- **DECIMAL(10, 2)**: For monetary values (prices, payments)
- **DATE**: For check-in/check-out dates
- **TIMESTAMP**: For automatic creation/update tracking
- **BOOLEAN**: For flags (is_active, is_read, is_host, etc.)
- **ENUM**: For status fields (booking_status, payment_status, etc.)

### Referential Integrity
All foreign keys use `ON DELETE CASCADE` to maintain data consistency:
- Deleting a user cascades to their properties, bookings, messages, reviews, and payments
- Deleting a property cascades to its bookings, reviews, amenity mappings, and payments
- Deleting a booking cascades to its reviews and payments

### Soft Deletes
- User table includes `deleted_at` field for soft deletes
- Preserves audit trail and referential integrity

## Verification

After deployment, verify the schema was created correctly:

```sql
-- Show all tables
SHOW TABLES;

-- Show table structure
DESCRIBE user;
DESCRIBE property;
DESCRIBE booking;
-- etc.

-- Show indexes
SHOW INDEX FROM user;
SHOW INDEX FROM property;
-- etc.

-- Show views
SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';
```

## Performance Considerations

1. **Indexes**: Strategically placed on filter and join columns for optimal query performance
2. **Composite Keys**: Used for junction tables to prevent duplicate entries
3. **Denormalization**: Timestamp fields are denormalized across tables for query efficiency
4. **Views**: Pre-computed queries available for common reporting needs

## Next Steps

1. ✅ Schema deployment (you are here)
2. 📊 Populate database with seed data (see `database-script-0x02/seed.sql`)
3. 🧪 Test queries and reports
4. 📈 Monitor performance and optimize indexes if needed

## Troubleshooting

### Error: "Database already exists"
- Use `DROP DATABASE IF EXISTS airbnb_db;` before re-running script
- Or modify the schema.sql to use `CREATE DATABASE IF NOT EXISTS`

### Error: "Foreign key constraint fails"
- Ensure parent tables are created before child tables
- Check that referenced user_id values exist in the user table

### Slow Queries
- Run `ANALYZE TABLE` to update index statistics
- Consider adding additional indexes on frequently filtered columns
- Review `EXPLAIN` output for query optimization opportunities

## Support
For issues or questions about the schema, refer to:
- ERD/requirements.md (entity and relationship definitions)
- normalization.md (normalization analysis and design decisions)
