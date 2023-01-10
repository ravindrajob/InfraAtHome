<?php
require('UserInfo.php');
// client-ip.php : Demo script by nixCraft <www.cyberciti.biz>
// get an IP address
$ip = $_SERVER['REMOTE_ADDR'];
// display it back
echo "<center><h2>Private access Warning !</h2></center>";
echo "Your IP address : " . $ip;
echo "<br>Your hostname : ". gethostbyaddr($ip) ;
echo "<br>Your OS : ". UserInfo::get_os();
echo "<br>Your browser : ". UserInfo::get_browser();
echo "<br>Your device : ". UserInfo::get_device();
?>
