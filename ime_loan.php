<?php
// Assuming you have already established a database connection
// Replace "your_db_connection_code_here" with your actual code to connect to the database
$conn = new mysqli("localhost", "root", "", "ime624");

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve form data
$title = $_POST['title'];
$name = $_POST['name'];
$fatherHusbandName = $_POST['father-husband-name'];
$educationalDetails = $_POST['educational-details'];
$numberOfDependents = $_POST['number-of-dependents'];
$status = $_POST['status'];
$religion = $_POST['religion'];
$panNumber = $_POST['pan-number'] ?? null;
$gender = $_POST['gender'] ?? null;
$presentAddress = $_POST['present-address'];
$permanentAddress = $_POST['permanent-address'] ?? null;

// Insert data into CustomerDetails table
$sql = "INSERT INTO CustomerDetails (Title, Name, FatherHusbandName, EducationalDetails, NumberOfDependents, Status, Religion, PanNumber, Gender, PresentAddress, PermanentAddress) VALUES ('$title', '$name', '$fatherHusbandName', '$educationalDetails', $numberOfDependents, '$status', '$religion', '$panNumber', '$gender', '$presentAddress', '$permanentAddress')";

if ($conn->query($sql) === TRUE) {
    $customerID = $conn->insert_id;

    // ... (Insert data into other tables as needed)

    echo "Data inserted successfully!";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
// Call the stored procedure to make a loan approval decision
$sql = "CALL ApproveLoan(?, ?, ?, ?, @approvalStatus)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("iidi", $farmerID, $age, $loanAmount, $kvkAssistance);
$stmt->execute();

// Retrieve the approval status
$result = $conn->query("SELECT @approvalStatus AS ApprovalStatus");
$row = $result->fetch_assoc();
$approvalStatus = $row['ApprovalStatus'];

// Output the decision
echo "Loan Approval Status: " . $approvalStatus;
// Close the database connection
$conn->close();
?>
