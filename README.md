# Hotel Reservation Management System

A relational database I built to manage hotel rooms, customers, bookings, services, and payments.

---

## What does it do?

I chose a hotel reservation system because it has lots of real relationships between  data and  customers make  bookings, bookings are linked to rooms ,  rooms have types, and payments are tracked  separately. It felt like a good  real-world  example to work with.

The database can:

- Store customer and staff information
- Manage different room types and individual rooms
- Handle bookings with check-in and check-out dates
- Track extra services like breakfast or airport transfers
- Record payments for each booking

---

## File Structure

```
hotel-reservation-db/
│
├── sql/
│   ├── 01_schema.sql        #--Creates all the tables
│   ├── 02_sample_data.sql   # --Adds sample data to the tables
│   └── 03_queries.sql       #  --SQL queries for all operations
│
├── docs/
│   ├── erd.png              # --Entity Relationship Diagram
│   ├── report.pdf           #  --Project report
│   └── report.docx          #   --Project report (Word version)
│
└── README.md
```

---

## How to run it

You need MySQL installed on your computer.

```bash
mysql -u root -p < sql/01_schema.sql
mysql -u root -p < sql/02_sample_data.sql
mysql -u root -p < sql/03_queries.sql
```

---

## Tables

| Table | What it stores |
|---|---|
| Customers | Guest name, email, phone, address |
| Staff | Hotel employee details and role |
| RoomTypes | Types of rooms and their base price |
| Rooms | Individual rooms with floor and status |
| Bookings | Reservations with check-in and check-out dates |
| BookingRooms | Links bookings to rooms |
| Services | Extra services like breakfast or spa |
| BookingServices | Services added to each booking |
| Payments | Payment records for each booking |

---

## Queries included

| Type | What it does |
|---|---|
| SELECT | Retrieve customers, rooms, bookings, payments |
| INSERT | Add new customers, bookings, rooms, staff |
| UPDATE | Change room status, booking status, payment status |
| DELETE | Remove services or cancel bookings |
| JOIN | Combine data from multiple tables |
| GROUP BY / SUM / COUNT | Calculate totals and statistics |

---

## Video Demonstration



---

## Author

Muhammad Ahsan Tahir
Roll Number: GH1050837
Module: B103 Databases & Big Data
Gisma University of Applied Sciences