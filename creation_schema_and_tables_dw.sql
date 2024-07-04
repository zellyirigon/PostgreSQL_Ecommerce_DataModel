-- Study Case 1 - Building and Implementing Data Model for E-commerce Portal
-- Physical Model

-- Creating the schema in the database
CREATE SCHEMA dw AUTHORIZATION zellyirigondata;

-- Creating customer dimension
CREATE TABLE dw.Customer (
    CustomerID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    CustomerCity VARCHAR(255),
    CustomerCountry VARCHAR(255)
);

-- Creating Product Dimension
CREATE TABLE dw.Product (
    ProductID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Description VARCHAR(255),
    Price DECIMAL(10, 2),
    CategoryName VARCHAR(255)
);

-- Creating Shipping Dimension
CREATE TABLE dw.Shipping (
    ShippingID SERIAL PRIMARY KEY,
    ShippingName VARCHAR(255),
    ShippingCity VARCHAR(255),
    ShippingCountry VARCHAR(255)
);

-- Creating Date Dimension
CREATE TABLE dw.Date (
    DateID SERIAL PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Year INT,
    Weekday VARCHAR(255)
);

-- Creating Sales Fact Table
CREATE TABLE dw.Sales (
    CustomerID INT,
    ProductID INT,
    ShippingID INT,
    DateID INT,
    SoldQuantity INT,
    Revenue DECIMAL(10, 2),
    ShippingCost DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES dw.Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES dw.Product(ProductID),
    FOREIGN KEY (ShippingID) REFERENCES dw.Shipping(ShippingID),
    FOREIGN KEY (DateID) REFERENCES dw.Date(DateID)
);


