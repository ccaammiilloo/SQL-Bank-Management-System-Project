-- Create the schema
CREATE SCHEMA BankManagement;

-- Create tables within the schema
CREATE TABLE BankManagement.Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Address TEXT
);

CREATE TABLE BankManagement.Accounts (
    AccountID SERIAL PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountType VARCHAR(20) CHECK (AccountType IN ('Checking', 'Savings')),
    Balance NUMERIC(15, 2) CHECK (Balance >= 0),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES BankManagement.Customers(CustomerID) ON DELETE CASCADE
);

CREATE TABLE BankManagement.Transactions (
    TransactionID SERIAL PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionType VARCHAR(20) CHECK (TransactionType IN ('Deposit', 'Withdrawal', 'Transfer')),
    Amount NUMERIC(15, 2) CHECK (Amount > 0),
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountID) REFERENCES BankManagement.Accounts(AccountID) ON DELETE CASCADE
);

-- Insert sample data
INSERT INTO BankManagement.Customers (FirstName, LastName, Email, PhoneNumber, Address)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm Street'),
    ('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak Avenue');

INSERT INTO BankManagement.Accounts (CustomerID, AccountType, Balance)
VALUES
    (1, 'Checking', 1500.00),
    (1, 'Savings', 2500.00),
    (2, 'Checking', 3000.00);

INSERT INTO BankManagement.Transactions (AccountID, TransactionType, Amount)
VALUES
    (1, 'Deposit', 500.00),
    (2, 'Withdrawal', 200.00),
    (3, 'Transfer', 1000.00);

-- Example query using the schema
SELECT 
    c.FirstName, 
    c.LastName, 
    a.AccountID, 
    a.AccountType, 
    a.Balance
FROM BankManagement.Customers c
JOIN BankManagement.Accounts a ON c.CustomerID = a.CustomerID;