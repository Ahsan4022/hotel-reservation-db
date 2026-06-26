# Hotel Reservation Management System

A relational database for managing rooms, customers, bookings, services, and payments in a hotel.

## Setup


mysql -u root -p < sql/01_schema.sql
mysql -u root -p < sql/02_sample_data.sql
mysql -u root -p < sql/03_queries.sql

## Schema overview

Nine tables: `Customers`, `Staff`, `RoomTypes`, `Rooms`, `Bookings`, `BookingRooms`(JUNCTION)
(junction), `Services`, `BookingServices` (junction), `Payments`. See `docs/erd.png`
and `docs/report.pdf` (Section 2) for the full entity-relationship diagram and design
rationale, and Section 3 of the report for the constraint and indexing strategy.

## Demonstration video

[INSERT YOUR VIDEO LINK HERE]

## Author
MUHAMMAD AHSAN TAHIR
GH1050837
