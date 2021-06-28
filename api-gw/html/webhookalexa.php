<?php
$data = json_decode(file_get_contents('php://input'), true);
header('content-type: application/json');
$location = "Salon";
exec('/scripts/alexa-remote-control.sh -d "'.$location.'" -e speak:"'.$data["message"].'"');
?>

