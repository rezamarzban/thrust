<?php
function calculateInitialMass($mf, $Isp, $delta_v) {
    $g0 = 9.81; // Acceleration due to gravity in m/s^2
    $m0 = $mf * exp($delta_v / ($Isp * $g0));
    return $m0;
}

// Example values
$mf = 1000.0; // final mass in kg
$Isp = 300.0; // specific impulse in seconds
$delta_v = 9500.0; // delta V for LEO in m/s

$m0 = calculateInitialMass($mf, $Isp, $delta_v);
printf("Initial mass (m0): %.2f kg\n", $m0);
?>
