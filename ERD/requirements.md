# Entity-Relationship Diagram (ERD) Requirements

## Overview
This document outlines the entities, attributes, and relationships for the Airbnb-like database system. The ERD provides a visual blueprint for the relational database design.

## Entities and Attributes

### 1. User
Represents users of the platform (hosts and guests).

**Attributes:**
- `user_id` (PK): Unique identifier for each user
- `email`: User's email address (UNIQUE)
- `password_hash`: Hashed password for authentication
- `first_name`: User's first name
- `last_name`: User's last name
- `phone_number`: User's contact phone number
- `profile_picture_url`: URL to user's profile picture
- `bio`: User biography
- `is_host`: Boolean flag indicating if user is a host
- `is_guest`: Boolean flag indicating if user is a guest
- `created_at`: Timestamp when user account was created
- `updated_at`: Timestamp when user profile was last updated
- `deleted_at`: Soft delete timestamp (nullable)

### 2. Property
Represents rental properties listed by hosts.

**Attributes:**
- `property_id` (PK): Unique identifier for each property
- `host_id` (FK): Reference to User (host)
- `title`: Property name/title
- `description`: Detailed description of the property
- `address`: Physical address of the property
- `city`: City where property is located
- `country`: Country where property is located
- `latitude`: Geographic latitude coordinate
- `longitude`: Geographic longitude coordinate
- `property_type`: Type of property (e.g., Apartment, House, Villa)
- `bedrooms`: Number of bedrooms
- `bathrooms`: Number of bathrooms
- `max_guests`: Maximum number of guests allowed
- `price_per_night`: Nightly rental price
- `cancellation_policy`: Cancellation policy description
- `is_active`: Boolean indicating if property is available for booking
- `created_at`: Timestamp when property was listed
- `updated_at`: Timestamp when property details were last updated

### 3. Property Amenity
Represents amenities available at properties.

**Attributes:**
- `amenity_id` (PK): Unique identifier for each amenity
- `name`: Name of the amenity (e.g., WiFi, Pool, AC)
- `description`: Description of the amenity
- `created_at`: Timestamp when amenity was created

### 4. Property Amenity Mapping
Junction table linking properties to amenities (many-to-many).

**Attributes:**
- `property_amenity_id` (PK): Unique identifier
- `property_id` (FK): Reference to Property
- `amenity_id` (FK): Reference to PropertyAmenity
- `created_at`: Timestamp when amenity was added to property

### 5. Booking
Represents reservations made by guests for properties.

**Attributes:**
- `booking_id` (PK): Unique identifier for each booking
- `guest_id` (FK): Reference to User (guest)
- `property_id` (FK): Reference to Property
- `check_in_date`: Date when guest checks in
- `check_out_date`: Date when guest checks out
- `total_guests`: Number of guests for this booking
- `booking_status`: Status of booking (Pending, Confirmed, Checked In, Completed, Cancelled)
- `total_price`: Total cost of the booking
- `created_at`: Timestamp when booking was made
- `updated_at`: Timestamp when booking was last modified
- `cancelled_at`: Timestamp when booking was cancelled (nullable)

### 6. Review
Represents guest reviews for properties and hosts.

**Attributes:**
- `review_id` (PK): Unique identifier for each review
- `booking_id` (FK): Reference to Booking
- `guest_id` (FK): Reference to guest User
- `property_id` (FK): Reference to Property
- `host_id` (FK): Reference to host User
- `rating`: Numerical rating (1-5 stars)
- `title`: Review title
- `comment`: Review text
- `created_at`: Timestamp when review was posted
- `updated_at`: Timestamp when review was last modified

### 7. Payment
Represents financial transactions related to bookings.

**Attributes:**
- `payment_id` (PK): Unique identifier for each payment
- `booking_id` (FK): Reference to Booking
- `guest_id` (FK): Reference to User (guest)
- `host_id` (FK): Reference to User (host)
- `amount`: Payment amount
- `payment_method`: Method used for payment (Credit Card, PayPal, etc.)
- `payment_status`: Status of payment (Pending, Completed, Failed, Refunded)
- `transaction_id`: External transaction identifier
- `created_at`: Timestamp when payment was initiated
- `updated_at`: Timestamp when payment status was last updated

### 8. Message
Represents direct messages between users.

**Attributes:**
- `message_id` (PK): Unique identifier for each message
- `sender_id` (FK): Reference to User (sender)
- `receiver_id` (FK): Reference to User (receiver)
- `subject`: Message subject
- `body`: Message content
- `is_read`: Boolean indicating if message has been read
- `created_at`: Timestamp when message was sent

## Relationships

### One-to-Many (1:N)
1. **User → Property**: One user (host) can list many properties
2. **User → Booking**: One user (guest) can make many bookings
3. **Property → Booking**: One property can have many bookings
4. **Booking → Payment**: One booking can have multiple payments
5. **Booking → Review**: One booking generates one review (1:1 in practice, but modeled as 1:N for flexibility)
6. **User → Review**: One user can write multiple reviews (as guest)
7. **User → Message**: One user can send/receive many messages

### Many-to-Many (M:N)
1. **Property ↔ Amenity**: Properties have many amenities; amenities belong to many properties
   - **Junction Table**: PropertyAmenityMapping

### One-to-One (1:1) (Logical)
1. **Booking → Payment**: Each booking typically has one primary payment transaction (though tracked as 1:N for flexibility)

## Cardinality Summary

| Entity 1 | Relationship | Entity 2 | Cardinality |
|----------|--------------|----------|------------|
| User | hosts | Property | 1:N |
| User | makes | Booking | 1:N |
| Property | has | Booking | 1:N |
| Booking | has | Payment | 1:N |
| Booking | receives | Review | 1:1 |
| User | writes | Review | 1:N |
| Property | has | Amenity | M:N |
| User | sends | Message | 1:N |

## Visual Representation

Please refer to the **Draw.io ERD file** (to be created alongside this document) for a comprehensive visual representation of all entities, attributes, and relationships.

## Key Design Notes

1. **Soft Deletes**: The User entity includes a `deleted_at` field for soft deletes, ensuring data integrity and audit trails.
2. **Timestamps**: All entities include `created_at` and `updated_at` for tracking changes.
3. **Foreign Keys**: All FK relationships include referential integrity constraints.
4. **Many-to-Many Junction**: PropertyAmenityMapping serves as a junction table for flexible property amenity associations.
5. **Status Fields**: Booking and Payment entities include status fields for workflow management.
6. **Flexible Review Model**: Reviews are linked to both guests, hosts, properties, and bookings for comprehensive tracking.

## Next Steps

1. Create Draw.io diagram based on this specification
2. Review for normalization compliance (Task 2)
3. Implement DDL schema (Task 3)
4. Seed database with sample data (Task 4)
