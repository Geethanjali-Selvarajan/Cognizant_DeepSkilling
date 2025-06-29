CREATE DATABASE BANK_DB;
USE BANK_DB;

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    Balance DECIMAL(10,2),
    LastModified DATETIME
);

-- Accounts Table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2),
    LastModified DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATETIME,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Loans Table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    HireDate DATE
);

-- Customers
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Doe', '1985-05-15', 1000.00, NOW());

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Jane Smith', '1990-07-20', 1500.00, NOW());

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (3, 'Robert Senior', '1950-03-10', 20000.00, NOW());

-- Accounts
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000.00, NOW());

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 1500.00, NOW());

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 3, 'Savings', 20000.00, NOW());

-- Transactions
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, NOW(), 200.00, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, NOW(), 300.00, 'Withdrawal');

-- Loans
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000.00, 5.00, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 60 MONTH));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 3, 10000.00, 7.00, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 25 DAY));

-- Employees
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000.00, 'HR', '2015-06-15');

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000.00, 'IT', '2017-03-20');

ALTER TABLE Customers ADD IsVIP BOOLEAN;

DELIMITER $$
CREATE PROCEDURE ProcessMonthlyInterest()
BEGIN
    UPDATE Accounts
    SET Balance = Balance * 1.01
    WHERE AccountType = 'Savings';
END$$
DELIMITER ;

CALL ProcessMonthlyInterest();
SELECT * FROM Accounts WHERE AccountType = 'Savings';

DELIMITER $$
CREATE PROCEDURE UpdateEmployeeBonus(
    IN dept VARCHAR(50),
    IN bonusPercent DECIMAL(5,2)
)
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * bonusPercent / 100)
    WHERE Department = dept;
END$$
DELIMITER ;

CALL UpdateEmployeeBonus('IT', 10);
SELECT * FROM Employees WHERE Department = 'IT';

DELIMITER $$
CREATE PROCEDURE TransferFunds(
    IN fromAccountID INT,
    IN toAccountID INT,
    IN transferAmount DECIMAL(10,2)
)
BEGIN
    DECLARE fromBalance DECIMAL(10,2);
    DECLARE nextTransactionID INT;

    SELECT Balance INTO fromBalance
    FROM Accounts
    WHERE AccountID = fromAccountID;

    IF fromBalance >= transferAmount THEN

        UPDATE Accounts
        SET Balance = Balance - transferAmount
        WHERE AccountID = fromAccountID;

        UPDATE Accounts
        SET Balance = Balance + transferAmount
        WHERE AccountID = toAccountID;

        SELECT IFNULL(MAX(TransactionID), 0) + 1 INTO nextTransactionID FROM Transactions;

        INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
        VALUES (nextTransactionID, fromAccountID, NOW(), transferAmount, 'Out');

        SET nextTransactionID = nextTransactionID + 1;

        INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
        VALUES (nextTransactionID, toAccountID, NOW(), transferAmount, 'In');

    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient funds in source account';
    END IF;
END$$
DELIMITER ;


CALL TransferFunds(3, 2, 500);
SELECT * FROM Accounts WHERE AccountID IN (2, 3);
SELECT * FROM Transactions WHERE AccountID IN (2, 3);


