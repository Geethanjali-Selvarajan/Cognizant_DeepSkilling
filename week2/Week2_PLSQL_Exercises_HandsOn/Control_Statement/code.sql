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

-- Discount for Customers Above 60
DELIMITER $$

CREATE PROCEDURE ApplySeniorDiscount()
BEGIN
    UPDATE Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    SET l.InterestRate = l.InterestRate - 1
    WHERE TIMESTAMPDIFF(YEAR, c.DOB, CURDATE()) > 60;
END$$

DELIMITER ;

CALL ApplySeniorDiscount();
SELECT * FROM Customers;
SELECT * FROM Loans;
-- Mark VIP Customers
DELIMITER $$
CREATE PROCEDURE MarkVIPCustomers()
BEGIN
    UPDATE Customers
    SET IsVIP = TRUE
    WHERE Balance > 10000;

    UPDATE Customers
    SET IsVIP = FALSE
    WHERE Balance <= 10000;
END$$
DELIMITER ;

CALL MarkVIPCustomers();

DELIMITER $$
CREATE PROCEDURE SendLoanReminders()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE vLoanID INT;
    DECLARE vCustomerName VARCHAR(100);
    DECLARE vEndDate DATE;
    DECLARE loan_cursor CURSOR FOR
        SELECT l.LoanID, c.Name, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN loan_cursor;

    read_loop: LOOP
        FETCH loan_cursor INTO vLoanID, vCustomerName, vEndDate;

        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT CONCAT('Reminder: Loan ID ', vLoanID, ' for customer ', vCustomerName, ' is due on ', vEndDate) AS ReminderMessage;
        
    END LOOP;

    CLOSE loan_cursor;
END$$

DELIMITER ;

CALL SendLoanReminders();


