-- Sets foreign keys on so that they are enforced
PRAGMA foreign_keys = ON;
-- Drops tables to reset the database
DROP TABLE IF EXISTS CoffeeTastes;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS RoastedCoffee;
DROP TABLE IF EXISTS Roastery;
DROP TABLE IF EXISTS Contains;
DROP TABLE IF EXISTS CoffeeBatch;
DROP TABLE IF EXISTS ProcessingMethod;
DROP TABLE IF EXISTS Grows;
DROP TABLE IF EXISTS CoffeeBean;
DROP TABLE IF EXISTS Farm;
DROP TABLE IF EXISTS Location;
--@Block
-- Create tables
CREATE TABLE User (
    Email nvarchar(50),
    Password nvarchar(50),
    FullName nvarchar(50),
    PRIMARY KEY (Email)
);
CREATE TABLE CoffeeTastes (
    TasteID int,
    Email nvarchar(50) NOT NULL,
    CoffeeName nvarchar(50) NOT NULL,
    RoasteryID int NOT NULL,
    Points tinyint CHECK (
        Points >= 0
        AND Points <= 10
    ),
    Notes text,
    Date date,
    PRIMARY KEY (TasteID),
    FOREIGN KEY (Email) REFERENCES User(Email),
    FOREIGN KEY (CoffeeName, RoasteryID) REFERENCES RoastedCoffee(CoffeeName, RoasteryID)
);
CREATE TABLE Roastery (
    RoasteryID int,
    Name nvarchar(50),
    PRIMARY KEY (RoasteryID)
);
CREATE TABLE RoastedCoffee (
    CoffeeName nvarchar(50),
    RoasteryID int,
    BatchID int NOT NULL,
    RoastDegree nvarchar(30) CHECK (
        RoastDegree = 'light'
        OR RoastDegree = 'medium'
        OR RoastDegree = 'dark'
    ),
    RoastDate date,
    Description text,
    PricePerKilo int,
    PRIMARY KEY (CoffeeName, RoasteryID),
    FOREIGN KEY (RoasteryID) REFERENCES Roastery(RoasteryID) ON DELETE CASCADE,
    FOREIGN KEY (BatchID) REFERENCES CoffeeBatch(BatchID)
);
CREATE TABLE CoffeeBatch (
    BatchID int,
    FarmID int NOT NULL,
    MethodName nvarchar(50) NOT NULL,
    HarvestYear int,
    PricePaidToFarm int,
    PRIMARY KEY (BatchID),
    FOREIGN KEY (FarmID) REFERENCES Farm(FarmID),
    FOREIGN KEY (MethodName) REFERENCES ProcessingMethod(MethodName)
);
CREATE TABLE ProcessingMethod (
    MethodName nvarchar(50),
    Description text,
    PRIMARY KEY (MethodName)
);
CREATE TABLE CoffeeBean (
    BeanID int,
    Name nvarchar(50),
    Species nvarchar(20) CHECK (
        Species = "coffea"
        OR Species = "arabica"
        OR Species = "coffea robusta"
        OR Species = "coffea liberica"
    ),
    PRIMARY KEY (BeanID)
);
CREATE TABLE Farm (
    FarmID int,
    LocationID int NOT NULL,
    Name nvarchar(50),
    MetersAboveSea int,
    PRIMARY KEY (FarmID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);
CREATE TABLE Location (
    LocationID int,
    Country nvarchar(50),
    Region nvarchar(50),
    PRIMARY KEY (LocationID)
);
CREATE TABLE Contains (
    BatchID int,
    BeanID int,
    PRIMARY KEY (BatchID, BeanID),
    FOREIGN KEY (BatchID) REFERENCES CoffeeBatch(BatchID),
    FOREIGN KEY (BeanID) REFERENCES CoffeeBean(BeanID)
);
CREATE TABLE Grows (
    FarmID int,
    BeanID int,
    PRIMARY KEY (FarmID, BeanID),
    FOREIGN KEY (FarmID) REFERENCES Farm(FarmID),
    FOREIGN KEY (BeanID) REFERENCES CoffeeBean(BeanID)
);
--@Block
-- Insert at least one row in every table
INSERT INTO User (Email, Password, FullName)
VALUES (
        "ola.nordman@gmail.com",
        "Password123",
        "Ola Nordman"
    );
INSERT INTO Roastery (RoasteryID, Name)
VALUES (1, "Trondheim brewery Jacobsen & Svart");
INSERT INTO Location (LocationID, Country, Region)
VALUES (1, "El Salvador", "Santa Ana");
INSERT INTO Farm (FarmID, LocationID, Name, MetersAboveSea)
VALUES (1, 1, "Nombre de Dios", 1500);
INSERT INTO ProcessingMethod (MethodName, Description)
VALUES ("Natrual", "Do nothing basically");
INSERT INTO CoffeeBean (BeanID, Name, Species)
VALUES (1, "Bourbon", "arabica");
INSERT INTO CoffeeBatch (
        BatchID,
        FarmID,
        MethodName,
        HarvestYear,
        PricePaidToFarm
    )
VALUES (1, 1, "Natrual", 2021, 8);
INSERT INTO RoastedCoffee (
        CoffeeName,
        RoasteryID,
        BatchID,
        RoastDegree,
        RoastDate,
        Description,
        PricePerKilo
    )
VALUES (
        "Vinterkaffe 2022",
        1,
        1,
        "light",
        "20.01.2022",
        "A tasty and complex coffee for polar nights",
        600
    );
INSERT INTO CoffeeTastes (
        TasteID,
        Email,
        CoffeeName,
        RoasteryID,
        Points,
        Notes,
        Date
    )
VALUES (
        1,
        "ola.nordman@gmail.com",
        "Vinterkaffe 2022",
        1,
        10,
        "Wow an odyssey for the taste buds: citrus peel, milk chocolate, apricot!",
        "14.03.2022"
    );
INSERT INTO Contains (BatchID, BeanID)
VALUES (1, 1);
INSERT INTO Grows (FarmID, BeanID)
VALUES (1, 1);
--@Block
-- Display every value
SELECT *
FROM User;
SELECT *
FROM Roastery;
SELECT *
FROM Location;
SELECT *
FROM Farm;
SELECT *
FROM ProcessingMethod;
SELECT *
FROM CoffeeBean;
SELECT *
FROM CoffeeBatch;
SELECT *
FROM RoastedCoffee;
SELECT *
FROM CoffeeTastes;
SELECT *
FROM Grows;
SELECT *
FROM Contains;