# End-to-End Data Pipeline: Postgres to Snowflake

## Project Overview
This project demonstrates a complete ELT pipeline. It ingests data from a containerized PostgreSQL instance, streams it into a Snowflake Data Warehouse using CDC (via Hevo), and transforms it into a materialized "Customer 360" table using dbt-style modeling.

## Tech Stack
* **Source:** PostgreSQL (Docker)
* **Ingestion:** Hevo + Ngrok Tunneling
* **Warehouse:** Snowflake
* **Transformation:** dbt (SQL CTEs)
* **Testing:** dbt Schema Tests

## Data Transformation Logic
The final `customers` table is built using several CTEs to aggregate:
1. **Order History:** Calculates `first_order`, `most_recent_order`, and `number_of_orders`.
2. **Financials:** Sums all successful payments to calculate `customer_lifetime_value`.

## How to Run
1. Run `docker-compose up -d` to start the source DB.
2. Ensure the Ngrok tunnel is active for Hevo access.
3. Execute the transformation SQL in Snowflake or via `dbt run`.
4. Validate data quality using `dbt test`.