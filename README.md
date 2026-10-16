# 💅 Cosmetology Clinic Database

A PostgreSQL database for a cosmetology clinic management system. The database supports client management, appointment scheduling, service and product catalogs, inventory tracking, callback requests, and customer reviews.

## Technologies

- **PostgreSQL** — relational database management system
- **SQL** — schema definition, constraints, relationships, and views
- **PL/pgSQL** — database functions and triggers
- **Django database tables** — authentication, permissions, admin logs, and sessions

## Database Structure

The database includes the following application tables:

| Table | Description |
|---|---|
| `user` | User-related records |
| `client` | Client profiles and contact information |
| `doctor` | Specialist profiles, qualifications, and experience |
| `call_requests` | Callback requests submitted by users |
| `service_categories` | Service categories and their hierarchy |
| `services` | Available clinic services, prices, and durations |
| `product_categories` | Product categories and their hierarchy |
| `products` | Product catalog, prices, and stock quantities |
| `records` | Appointment records, statuses, and payment information |
| `used_products` | Products used during appointments |
| `reviews` | Client reviews and ratings |

The dump also contains Django-related tables for authentication, permissions, administrative activity, migrations, and sessions.

## Database Features

### Functions and Triggers

The database implements three trigger functions:

- `deduct_product_quantity()` — decreases product stock when a product usage record is inserted.
- `set_request_date()` — automatically sets the date of a callback request.
- `update_last_modified()` — updates the modification timestamp of a user record.

Three triggers invoke these functions to automate database operations.

### Views

- `view_record_summary` — combines appointment information with client, specialist, and service details.
- `view_reviews_detailed` — combines reviews with client and service information.

### Integrity and Relationships

The schema defines primary keys, foreign keys, unique constraints, check constraints, and indexes to support relational integrity and data retrieval.

## Getting Started

### Requirements

- PostgreSQL
- A PostgreSQL client, such as pgAdmin or `psql`

### Restore the Database Schema

1. Create a new, empty PostgreSQL database.
2. Open the SQL file in pgAdmin's Query Tool or execute it using `psql`.
3. Run the script against the newly created database.
4. Verify that the tables, views, functions, triggers, and constraints have been created successfully.

The SQL dump contains database definitions rather than application records. Django-specific tables are included in the schema.

## Repository Contents

- `cosmetology_clinic.sql` — SQL dump containing the database schema, functions, triggers, views, indexes, and constraints.
- `README.md` — project overview and setup instructions.

## Notes

This repository documents the database component of a cosmetology clinic management project. It is intended for educational and portfolio purposes.
The SQL dump should be tested against a compatible PostgreSQL installation before being used in a production environment.

