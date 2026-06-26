-- Hotel Reservation System - SQL Queries
-- Run this file after 01_schema.sql and 02_sample_data.sql

USE hotel_reservation_db;

-- -------------------------------------------------------
-- SELECT QUERIES
-- -------------------------------------------------------

-- Show all customers
SELECT * FROM Customers;

-- Show all rooms and what type they are
SELECT Rooms.RoomNumber, RoomTypes.TypeName, RoomTypes.BaseRate, Rooms.Status
FROM Rooms
JOIN RoomTypes ON Rooms.RoomTypeID = RoomTypes.RoomTypeID;

-- Show only available rooms
SELECT RoomNumber, Floor
FROM Rooms
WHERE Status = 'Available';

-- Show all bookings with customer names
SELECT Bookings.BookingID, Customers.FirstName, Customers.LastName,
       Bookings.CheckInDate, Bookings.CheckOutDate, Bookings.Status
FROM Bookings
JOIN Customers ON Bookings.CustomerID = Customers.CustomerID;

-- Show full booking details including room information
SELECT Bookings.BookingID, Customers.FirstName, Customers.LastName,
       Rooms.RoomNumber, RoomTypes.TypeName,
       Bookings.CheckInDate, Bookings.CheckOutDate, Bookings.Status
FROM Bookings
JOIN Customers ON Bookings.CustomerID = Customers.CustomerID
JOIN BookingRooms ON Bookings.BookingID = BookingRooms.BookingID
JOIN Rooms ON BookingRooms.RoomID = Rooms.RoomID
JOIN RoomTypes ON Rooms.RoomTypeID = RoomTypes.RoomTypeID;

-- Show which staff member handled each booking
SELECT Bookings.BookingID, Bookings.Status,
       Staff.FirstName, Staff.LastName
FROM Bookings
LEFT JOIN Staff ON Bookings.StaffID = Staff.StaffID;

-- Show services added to each booking
SELECT Bookings.BookingID, Services.ServiceName,
       BookingServices.Quantity, Services.Price
FROM BookingServices
JOIN Bookings ON BookingServices.BookingID = Bookings.BookingID
JOIN Services ON BookingServices.ServiceID = Services.ServiceID;

-- Show all payments
SELECT Payments.PaymentID, Customers.FirstName, Customers.LastName,
       Payments.Amount, Payments.PaymentMethod, Payments.PaymentStatus
FROM Payments
JOIN Bookings ON Payments.BookingID = Bookings.BookingID
JOIN Customers ON Bookings.CustomerID = Customers.CustomerID;

-- -------------------------------------------------------
-- INSERT QUERIES
-- -------------------------------------------------------

-- Add a new customer
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Hannah', 'Fischer', 'hannah.fischer@mail.com', '+49-151-9988776', 'Hamburg, Germany');

-- Add a new booking for the customer
INSERT INTO Bookings (CustomerID, StaffID, CheckInDate, CheckOutDate, NumGuests, Status)
VALUES (7, 2, '2026-09-10', '2026-09-13', 2, 'Confirmed');

-- Link a room to the new booking
INSERT INTO BookingRooms (BookingID, RoomID, RatePerNight)
VALUES (6, 1, 99.00);

-- Add a new staff member
INSERT INTO Staff (FirstName, LastName, Email, Phone, Role, HireDate)
VALUES ('John', 'Doe', 'john.doe@hotel.com', '+49-151-1234567', 'Receptionist', '2024-01-15');

-- -------------------------------------------------------
-- UPDATE QUERIES
-- -------------------------------------------------------

-- Mark a room as occupied when a guest checks in
UPDATE Rooms
SET Status = 'Occupied'
WHERE RoomID = 4;

-- Update a booking status to checked out
UPDATE Bookings
SET Status = 'CheckedOut'
WHERE BookingID = 2;

-- Mark a payment as completed
UPDATE Payments
SET PaymentStatus = 'Completed'
WHERE BookingID = 4 AND PaymentStatus = 'Pending';

-- -------------------------------------------------------
-- DELETE QUERIES
-- -------------------------------------------------------

-- Remove a service from a booking
DELETE FROM BookingServices
WHERE BookingID = 1 AND ServiceID = 2;

-- Cancel a booking and remove it
DELETE FROM Bookings
WHERE BookingID = 5;

-- -------------------------------------------------------
-- AGGREGATION QUERIES
-- -------------------------------------------------------

-- Total amount paid by each customer
SELECT Customers.FirstName, Customers.LastName,
       SUM(Payments.Amount) AS TotalPaid
FROM Customers
JOIN Bookings ON Customers.CustomerID = Bookings.CustomerID
JOIN Payments ON Bookings.BookingID = Payments.BookingID
WHERE Payments.PaymentStatus = 'Completed'
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName;

-- How many times each room type has been booked
SELECT RoomTypes.TypeName, COUNT(BookingRooms.RoomID) AS TimesBooked
FROM RoomTypes
JOIN Rooms ON RoomTypes.RoomTypeID = Rooms.RoomTypeID
JOIN BookingRooms ON Rooms.RoomID = BookingRooms.RoomID
GROUP BY RoomTypes.TypeName;

-- Most popular service ordered by guests
SELECT Services.ServiceName, SUM(BookingServices.Quantity) AS TotalOrdered
FROM BookingServices
JOIN Services ON BookingServices.ServiceID = Services.ServiceID
GROUP BY Services.ServiceName
ORDER BY TotalOrdered DESC;

-- Total revenue from all completed payments
SELECT SUM(Amount) AS TotalRevenue
FROM Payments
WHERE PaymentStatus = 'Completed';
