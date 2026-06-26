-- Hotel Reservation System
-- Creates all the tables needed for the database

DROP DATABASE IF EXISTS hotel_reservation_db;
CREATE DATABASE hotel_reservation_db;
USE hotel_reservation_db;

-- Customers table stores all guest information
CREATE TABLE Customers (
    CustomerID     INT AUTO_INCREMENT PRIMARY KEY,
    FirstName      VARCHAR(50)  NOT NULL,
    LastName       VARCHAR(50)  NOT NULL,
    Email          VARCHAR(100) NOT NULL UNIQUE,
    Phone          VARCHAR(20)  NOT NULL,
    Address        VARCHAR(255),
    RegisteredDate DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- Staff table stores hotel employee information
CREATE TABLE Staff (
    StaffID    INT AUTO_INCREMENT PRIMARY KEY,
    FirstName  VARCHAR(50)  NOT NULL,
    LastName   VARCHAR(50)  NOT NULL,
    Role       VARCHAR(50)  NOT NULL,
    Phone      VARCHAR(20),
    Email      VARCHAR(100) UNIQUE,
    HireDate   DATE NOT NULL
);

-- RoomTypes table defines  the different types of rooms available
CREATE TABLE RoomTypes (
    RoomTypeID   INT AUTO_INCREMENT PRIMARY KEY,
    TypeName     VARCHAR(50)   NOT NULL UNIQUE,
    Description  VARCHAR(255),
    BaseRate     DECIMAL(10,2) NOT NULL,
    MaxOccupancy INT NOT NULL
);

-- Rooms table stores  each individual room in the hotel
CREATE TABLE Rooms (
    RoomID     INT AUTO_INCREMENT PRIMARY KEY,
    RoomNumber VARCHAR(10) NOT NULL UNIQUE,
    RoomTypeID INT NOT NULL,
    Floor      INT NOT NULL,
    Status     VARCHAR(20) NOT NULL DEFAULT 'Available',
    FOREIGN KEY (RoomTypeID) REFERENCES RoomTypes(RoomTypeID)
);

-- Bookings table stores  each reservation made by a customer
CREATE TABLE Bookings (
    BookingID    INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID   INT NOT NULL,
    StaffID      INT,
    BookingDate  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CheckInDate  DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    NumGuests    INT NOT NULL,
    Status       VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- BookingRooms links bookings to rooms (a booking can have more than one room)
CREATE TABLE BookingRooms (
    BookingID    INT NOT NULL,
    RoomID       INT NOT NULL,
    RatePerNight DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (BookingID, RoomID),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

-- Services table stores extra services the hotel offers
CREATE TABLE Services (
    ServiceID   INT AUTO_INCREMENT PRIMARY KEY,
    ServiceName VARCHAR(50)  NOT NULL UNIQUE,
    Price       DECIMAL(8,2) NOT NULL
);

-- BookingServices links bookings to services ordered
CREATE TABLE BookingServices (
    BookingID INT NOT NULL,
    ServiceID INT NOT NULL,
    Quantity  INT NOT NULL DEFAULT 1,
    PRIMARY KEY (BookingID, ServiceID),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID)
);

-- Payments table stores  payment information for each booking
CREATE TABLE Payments (
    PaymentID     INT AUTO_INCREMENT PRIMARY KEY,
    BookingID     INT NOT NULL,
    Amount        DECIMAL(10,2) NOT NULL,
    PaymentDate   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod VARCHAR(20) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);
