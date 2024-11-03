import kotlin.math.*

fun areaRatio(M_e: Double, A_e: Double, A_star: Double, gamma: Double): Double {
    val term = (gamma + 1) / 2
    val exponent = (gamma + 1) / (2 * (gamma - 1))
    return term.pow(-exponent) * (1 + (gamma - 1) / 2 * M_e.pow(2)).pow(exponent) / M_e
}

fun main() {
    // Practical Parameters for a Rocket Engine
    val p_t = 7000000.0   // Total Pressure in Pascals (7 MPa)
    val T_t = 3300.0      // Total Temperature in Kelvin
    val p_0 = 101325.0    // Free Stream Pressure in Pascals (1 atm)
    val A_star = 0.05     // Throat Area in square meters
    val A_e = 0.1         // Exit Area in square meters
    val gamma = 1.3       // Specific Heat Ratio for propellants
    val R = 375.0         // Gas Constant in J/(kg·K)

    // Common terms
    val term = (gamma + 1) / 2
    val exponent = (gamma + 1) / (2 * (gamma - 1))

    // 1. Calculate Mass Flow Rate
    val massFlowRate = (A_star * p_t) / sqrt(T_t) * sqrt(gamma / R) * term.pow(-exponent)

    // 2. Calculate Exit Mach Number using bisection method
    var M_eLower = 0.1   // Lower bound for Mach Number
    var M_eUpper = 20.0  // Upper bound for Mach Number
    val tolerance = 1e-6  // Tolerance for convergence
    var M_eMid: Double
    var ratioMid: Double

    for (iter in 1..1000) {
        M_eMid = (M_eLower + M_eUpper) / 2.0
        ratioMid = areaRatio(M_eMid, A_e, A_star, gamma)

        if (abs(ratioMid - A_e / A_star) < tolerance) {
            break
        } else if (ratioMid < A_e / A_star) {
            M_eLower = M_eMid
        } else {
            M_eUpper = M_eMid
        }
    }

    val M_e = (M_eLower + M_eUpper) / 2.0

    // 3. Calculate Exit Temperature
    val T_e = T_t / (1 + (gamma - 1) / 2 * M_e.pow(2))

    // 4. Calculate Exit Pressure
    val p_e = p_t * (1 + (gamma - 1) / 2 * M_e.pow(2)).pow(-gamma / (gamma - 1))

    // 5. Calculate Exit Velocity
    val V_e = M_e * sqrt(gamma * R * T_e)

    // 6. Calculate Thrust
    val F = massFlowRate * V_e + (p_e - p_0) * A_e

    // Display results
    println("Mass Flow Rate (kg/s): %.2f".format(massFlowRate))
    println("Exit Mach Number: %.2f".format(M_e))
    println("Exit Temperature (K): %.2f".format(T_e))
    println("Exit Pressure (Pa): %.2f".format(p_e))
    println("Exit Velocity (m/s): %.2f".format(V_e))
    println("Thrust (N): %.2f".format(F))
}
