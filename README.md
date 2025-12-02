# 💅 Cosmetology Clinic Database

This is a training database project for a cosmetology clinic, implemented in PostgreSQL.

## 🧐 Structure
- **Clients** – information about clients
- **Doctors** – information about doctors
- **Services** – clinic services
- **Call_requests** – consultation requests
- **Products** – list of products used or offered by the clinic
- **Service_categories** – allows you to group services by categories
- **Records** – information about each appointment
- **Reviews** – contains texts, ratings and publication dates that clients leave after procedures
- **Used_products** – displays which cosmetic products were used during a specific appointment
- **User** – basic for many other tables and allows you to centrally store information about participants in interaction with the system

## 😶‍🌫️ Triggers and functions
- **update_last_modified + trg_update_user**
Automatically updates the 'last_update' field in the users table when data changes. Allows you to track the latest activity.

- **set_request_date + trg_set_request_date**
Used in the 'call_requests' table. When adding a new request, it automatically sets the current date and time.

- **deduct_product_quantity + trg_deduct_product_quantity**
Used to control product balances. When adding a record to 'used_products', the quantity of the corresponding product in 'products' is automatically reduced.

## 🤔 Views
- **view_record_summary**
Combines data from 'records', 'clients', 'doctors', 'services'. Allows you to conveniently see: who and when made an appointment, to which doctor, which service was chosen, status and payment.

- **view_reviews_detailed**
Combines 'reviews', 'records', 'clients', 'services'. Allows you to analyze reviews - see the service, client, review text and rating.

## 🙃 How to restore the database
```bash
createdb cosmetology_clinic
psql -U postgres -d cosmetology_clinic -f cosmetology_clinic.sql

