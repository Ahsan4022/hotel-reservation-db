-- Sample data for the Hotel Reservation System
-- Run this file after 01_schema.sql

USE hotel_reservation_db;

-- Adding customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('Julia',   'Smith',       'julia.smith@mail.com',    '+491511234567', 'Berlin, Germany'),
('Muhammad','Ali',         'muhammad.ali@mail.com',   '+353877654321', 'Dublin, Ireland'),
('Ahsan',   'Tahir',       'ahsan.tahir@mail.com',    '+923409876543', 'Pakistan'),
('Ayesha',  'Tanaka',      'ayesha.tanaka@mail.com',  '+81901122334',  'Osaka, Japan'),
('Maria',   'Garcia',      'maria.garcia@mail.com',   '+34619345678',  'Madrid, Spain'),
('Khalid',  'Bin Waleed',  'khalid.waleed@mail.com',  '+94233333334',  'Riyadh, Saudi Arabia');

-- Adding staff members
INSERT INTO Staff (FirstName, LastName, Role, Phone, Email, HireDate) VALUES
('Muhammad', 'Ahsan',    'Receptionist', '+491234567899', 'asn.1233@hotel.com',        '2021-03-01'),
('Ahmad',    'Waleed',   'Manager',      '+49302223344',  'ahmad.waleed@hotel.com',    '2019-06-15'),
('Harpareet','Singh',    'Receptionist', '+49303334455',  'harpareet.singh@hotel.com', '2022-09-10'),
('Alia',     'Waleed',   'Manager',      '+493023323344', 'alia.waleed@hotel.com',     '2019-06-15');

-- Adding room types
INSERT INTO RoomTypes (TypeName, Description, BaseRate, MaxOccupancy) VALUES
('Standard', 'Comfortable room with city view',         99.00,  2),
('Deluxe',   'Spacious room with king bed and lounge',  130.00, 3),
('Suite',    'Two-room suite with separate living area', 220.00, 4);

-- Adding rooms
INSERT INTO Rooms (RoomNumber, RoomTypeID, Floor, Status) VALUES
('101', 1, 1, 'Available'),
('102', 1, 1, 'Available'),
('103', 1, 1, 'Maintenance'),
('201', 2, 2, 'Available'),
('202', 2, 2, 'Occupied'),
('301', 3, 3, 'Available'),
('302', 3, 3, 'Available');

-- Adding services the hotel offers
INSERT INTO Services (ServiceName, Price) VALUES
('Breakfast',        15.00),
('Airport Transfer', 35.00),
('Spa Access',       25.00),
('Gym Access',       25.00),
('Late Checkout',    20.00);

-- Adding bookings
INSERT INTO Bookings (CustomerID, StaffID, CheckInDate, CheckOutDate, NumGuests, Status) VALUES
(1, 1, '2026-07-01', '2026-07-04', 2, 'Confirmed'),
(2, 1, '2026-07-03', '2026-07-05', 1, 'Confirmed'),
(3, 2, '2026-06-10', '2026-06-12', 4, 'CheckedOut'),
(4, 3, '2026-07-15', '2026-07-20', 3, 'Confirmed'),
(5, NULL, '2026-08-01', '2026-08-02', 2, 'Cancelled');

-- Linking rooms to bookings
INSERT INTO BookingRooms (BookingID, RoomID, RatePerNight) VALUES
(1, 4, 130.00),
(2, 1, 80.00),
(3, 6, 220.00),
(3, 7, 220.00),
(4, 5, 130.00),
(5, 2, 80.00);

-- Adding services to bookings
INSERT INTO BookingServices (BookingID, ServiceID, Quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(3, 1, 4),
(3, 3, 2),
(4, 1, 3);

-- Adding payments
INSERT INTO Payments (BookingID, Amount, PaymentMethod, PaymentStatus) VALUES
(1, 440.00, 'CreditCard', 'Completed'),
(2, 160.00, 'Online',     'Completed'),
(3, 880.00, 'Cash',       'Completed'),
(4, 650.00, 'DebitCard',  'Pending'),
(5, 80.00,  'Online',     'Refunded');
