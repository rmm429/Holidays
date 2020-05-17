<?php

// Connect to the database
require_once 'db.php';
 
// Check connection
if (mysqli_connect_errno())
{
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

// month value sent from the client with a POST request
$month = $link->real_escape_string($_POST['month']); 
$stmt = $link->prepare("SELECT * FROM Holidays WHERE month = ?");
$stmt->bind_param("s", $month);
$stmt->execute();
$result = $stmt->get_result();
$json_array = array();

// Prepares all the results to be encoded in a JSON
while ($row = $result->fetch_assoc())
{
    $hokiday_id = $row['hid'];
    $holiday_month= $row['month'];
    $holiday_description =$row['description'];
    $holiday_day = $row['day'];
    $holiday_year = $row['year'];
    $holiday = array("hid" => $hokiday_id, 'month' => $holiday_month, 'day' => $holiday_day, 'year' => $holiday_year, 'description'=> $holiday_description);
    array_push($json_array, $holiday);
}

// encodes array with results from database
echo json_encode($json_array); 
mysqli_close($link);
?>