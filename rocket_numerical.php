<?php
// Function to calculate the area ratio
function areaRatio($M_e, $A_e, $A_star, $gamma) {
    $term = ($gamma + 1) / 2;
    $exponent = ($gamma + 1) / (2 * ($gamma - 1));
    return pow($term, -$exponent) * pow(1 + ($gamma - 1) / 2 * $M_e * $M_e, $exponent) / $M_e;
}

// Practical Parameters for a Rocket Engine
$p_t = 7000000.0;   // Total Pressure in Pascals (7 MPa)
$T_t = 3300.0;      // Total Temperature in Kelvin
$p_0 = 101325.0;    // Free Stream Pressure in Pascals (1 atm)
$A_star = 0.05;     // Throat Area in square meters
$A_e = 0.1;         // Exit Area in square meters
$gamma = 1.3;       // Specific Heat Ratio for propellants
$R = 375.0;         // Gas Constant in J/(kg·K)

// Calculate common terms
$term = ($gamma + 1) / 2;
$exponent = ($gamma + 1) / (2 * ($gamma - 1));

// 1. Calculate Mass Flow Rate
$mass_flow_rate = ($A_star * $p_t) / sqrt($T_t) * sqrt($gamma / $R) * pow($term, -$exponent);

// 2. Calculate Exit Mach Number using bisection method
$M_e_lower = 0.1;   // Lower bound for Mach Number
$M_e_upper = 20.0;  // Upper bound for Mach Number
$tolerance = 1e-6;  // Tolerance for convergence
$max_iterations = 1000;

for ($iter = 1; $iter <= $max_iterations; $iter++) {
    $M_e_mid = ($M_e_lower + $M_e_upper) / 2;
    $ratio_mid = areaRatio($M_e_mid, $A_e, $A_star, $gamma);

    if (abs($ratio_mid - $A_e / $A_star) < $tolerance) {
        break;
    } elseif ($ratio_mid < $A_e / $A_star) {
        $M_e_lower = $M_e_mid;
    } else {
        $M_e_upper = $M_e_mid;
    }
}

$M_e = ($M_e_lower + $M_e_upper) / 2;

// 3. Calculate Exit Temperature
$T_e = $T_t / (1 + ($gamma - 1) / 2 * $M_e * $M_e);

// 4. Calculate Exit Pressure
$p_e = $p_t * pow(1 + ($gamma - 1) / 2 * $M_e * $M_e, -$gamma / ($gamma - 1));

// 5. Calculate Exit Velocity
$V_e = $M_e * sqrt($gamma * $R * $T_e);

// 6. Calculate Thrust
$F = $mass_flow_rate * $V_e + ($p_e - $p_0) * $A_e;

// Display results
printf("Mass Flow Rate (kg/s): %.2f\n", $mass_flow_rate);
printf("Exit Mach Number: %.2f\n", $M_e);
printf("Exit Temperature (K): %.2f\n", $T_e);
printf("Exit Pressure (Pa): %.2f\n", $p_e);
printf("Exit Velocity (m/s): %.2f\n", $V_e);
printf("Thrust (N): %.2f\n", $F);
?>
