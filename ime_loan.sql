-- CustomerDetails table
CREATE TABLE IF NOT EXISTS CustomerDetails (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    Name VARCHAR(255),
    FatherHusbandName VARCHAR(255),
    EducationalDetails VARCHAR(255),
    NumberOfDependents INT,
    Status VARCHAR(255),
    Religion VARCHAR(255),
    PanNumber VARCHAR(255),
    Gender VARCHAR(255),
    PresentAddress VARCHAR(255),
    PermanentAddress VARCHAR(255)
);

-- OccupationalDetails table
CREATE TABLE IF NOT EXISTS OccupationalDetails (
    OccupationalID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CompanyName VARCHAR(255),
    EmployerAddress VARCHAR(255),
    Country VARCHAR(255),
    MailingAddress VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES CustomerDetails(CustomerID)
);

-- IncomeAndBankingDetails table
CREATE TABLE IF NOT EXISTS IncomeAndBankingDetails (
    IncomeAndBankingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    MonthlySalary DECIMAL(10, 2),
    AnnualTurnover DECIMAL(10, 2),
    NetProfit DECIMAL(10, 2),
    CustID INT,
    Branch VARCHAR(255),
    AccountOpenedIn VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES CustomerDetails(CustomerID)
);
DELIMITER //

CREATE PROCEDURE ApproveLoan(IN p_FarmerID INT, IN p_Age INT, IN p_LoanAmount DECIMAL(10, 2), IN p_KVKAssistance BOOLEAN, OUT p_ApprovalStatus VARCHAR(10))
BEGIN
    -- Rule 1: If the applicant is below 30 years old and the loan amount is less than 5000, approve the loan.
    IF p_Age < 30 AND p_LoanAmount < 5000 THEN
        SET p_ApprovalStatus = 'Approved';
    
    -- Rule 2: If the applicant is between 30 and 50 years old, and the loan amount is between 5000 and 10000, and they have KVK assistance, approve the loan.
    ELSEIF p_Age BETWEEN 30 AND 50 AND p_LoanAmount BETWEEN 5000 AND 10000 AND p_KVKAssistance = 1 THEN
        SET p_ApprovalStatus = 'Approved';
    
    -- Rule 3: For all other cases, reject the loan.
    ELSE
        SET p_ApprovalStatus = 'Rejected';
    END IF;
END //

DELIMITER ;

