CREATE DATABASE Assesment05Db
use Assesment05Db


CREATE SCHEMA bank

-- Create the Customer table with a unique constraint on the combination of columns
CREATE TABLE bank.Customer (
    CId INT PRIMARY KEY IDENTITY(1000, 1),
    CName NVARCHAR(50) NOT NULL,
    CEmail NVARCHAR(50) NOT NULL ,
    Contact NVARCHAR(50) NOT NULL ,
    CPwd AS RIGHT(CName + CAST(CId AS NVARCHAR(MAX)) + LEFT(Contact, 2), 4) PERSISTED,
    CONSTRAINT UQ_Customer UNIQUE (CName, CId, Contact)
);

-- Create the MailInfo table
CREATE TABLE bank.MailInfo (
    MailTo NVARCHAR(MAX),
    CEmail NVARCHAR(MAX),
    MailDate DATETIME,
    MailMessage NVARCHAR(MAX)
);


CREATE TRIGGER bank.trgMailToCust
ON bank.Customer
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO bank.MailInfo (MailTo, CEmail, MailDate, MailMessage)
    SELECT 'Customer', i.CEmail, GETDATE(), 'Your net banking password is: ' + i.CPwd + '. It is valid up to 2 days only.'
    FROM inserted i;
END;

-- Insert at least 3 records into the Customer table
INSERT INTO bank.Customer (CName, CEmail, Contact) VALUES ('SivaReddy', 'Sivareddy@gmail.com', '123456789');
INSERT INTO bank.Customer (CName, CEmail, Contact) VALUES ('Ramya Reddy', 'RamyaReddy@gmail.com', '987654321');
INSERT INTO bank.Customer (CName, CEmail, Contact) VALUES ('LikiReddy', 'Liki.Reddy@email.com', '555666777');
INSERT INTO bank.Customer (CName, CEmail, Contact) VALUES ('Lahari Reddy', 'LahariReddy@gmail.com', '123456789');
INSERT INTO bank.Customer (CName, CEmail, Contact) VALUES ('Pandu', 'Pandu.1156@gmail.com', '123456789');


SELECT * FROM bank.Customer;
SELECT * FROM bank.MailInfo;











