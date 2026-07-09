DROP TABLE IF EXISTS Order_items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Ptype;


CREATE TABLE Payment (
    Payment_Tno CHAR(1) PRIMARY KEY, 
    Payment_Type CHAR(20)
);

CREATE TABLE Ptype (
    Tno CHAR(1) PRIMARY KEY, 
    Tname CHAR(15)
);

CREATE TABLE Product (
    Pno CHAR(4) PRIMARY KEY,
    Pname VARCHAR2 (40),
    Price NUMBER (7, 2),
    Tno CHAR(1),
    Inventory int,
    CONSTRAINT FK_Tno FOREIGN KEY (Tno) REFERENCES Ptype (Tno)
);

CREATE TABLE Customer (
    Cno CHAR(5) PRIMARY KEY,
    Cname VARCHAR2 (20),
    Company VARCHAR2 (30),
    City VARCHAR2 (20),
    Tel CHAR(15)
);

CREATE TABLE Orders (
    Ono CHAR(5) PRIMARY KEY,
    Order_date DATE,
    Cno CHAR(5),
    Freight INT,
    Shipment_date date,
    City CHAR(20),
    Payment_Tno CHAR(1),
    Status CHAR(20),
    CONSTRAINT FK_Payment_Tno FOREIGN KEY (Payment_Tno) REFERENCES Payment (Payment_Tno)
);

CREATE TABLE Order_items (
    Ono CHAR(5),
    Pno CHAR(4),
    Qty int,
    Discount NUMBER (4, 2),
    PRIMARY KEY (Ono, Pno),
    CONSTRAINT FK_Ono FOREIGN KEY (Ono) REFERENCES Orders (Ono),
    CONSTRAINT FK_Pno FOREIGN KEY (Pno) REFERENCES Product (Pno)
);
