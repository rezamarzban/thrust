#include <iostream>
#include <cmath>
#include <iomanip>

using namespace std;

// Function to calculate the area ratio based on Mach number
double area_ratio(double M_e, double A_e, double A_star, double gamma) {
    double term = (gamma + 1.0) / 2.0;
    double exponent = (gamma + 1.0) / (2.0 * (gamma - 1.0));
    return pow(term, -exponent) * pow((1.0 + (gamma - 1.0) / 2.0 * M_e * M_e), exponent) / M_e;
}

int main() {
    // Practical Parameters for a Rocket Engine
    double p_t = 7000000.0;   // Total Pressure in Pascals (7 MPa)
    double T_t = 3300.0;      // Total Temperature in Kelvin
    double p_0 = 101325.0;    // Free Stream Pressure in Pascals (1 atm)
    double A_star = 0.05;     // Throat Area in square meters
    double A_e = 0.1;         // Exit Area in square meters
    double gamma = 1.3;       // Specific Heat Ratio for propellants
    double R = 375.0;         // Gas Constant in J/(kg·K)

    // Calculate common terms
    double term = (gamma + 1.0) / 2.0;
    double exponent = (gamma + 1.0) / (2.0 * (gamma - 1.0));

    // 1. Calculate Mass Flow Rate
    double mass_flow_rate = (A_star * p_t) / sqrt(T_t) * sqrt(gamma / R) * pow(term, -exponent);

    // 2. Calculate Exit Mach Number using bisection method
    double M_e_lower = 0.1;   // Lower bound for Mach Number
    double M_e_upper = 20.0;  // Upper bound for Mach Number
    double tolerance = 1e-6;  // Tolerance for convergence
    int max_iterations = 1000;
    double M_e_mid, ratio_mid;

    for (int iter = 0; iter < max_iterations; ++iter) {
        M_e_mid = (M_e_lower + M_e_upper) / 2.0;
        ratio_mid = area_ratio(M_e_mid, A_e, A_star, gamma);

        if (fabs(ratio_mid - A_e / A_star) < tolerance) {
            break;
        } else if (ratio_mid < A_e / A_star) {
            M_e_lower = M_e_mid;
        } else {
            M_e_upper = M_e_mid;
        }
    }

    double M_e = M_e_mid;

    // 3. Calculate Exit Temperature
    double T_e = T_t / (1.0 + (gamma - 1.0) / 2.0 * M_e * M_e);

    // 4. Calculate Exit Pressure
    double p_e = p_t * pow(1.0 + (gamma - 1.0) / 2.0 * M_e * M_e, -gamma / (gamma - 1.0));

    // 5. Calculate Exit Velocity
    double V_e = M_e * sqrt(gamma * R * T_e);

    // 6. Calculate Thrust
    double F = mass_flow_rate * V_e + (p_e - p_0) * A_e;

    // Display results
    cout << fixed << setprecision(2);
    cout << "Mass Flow Rate (kg/s): " << mass_flow_rate << endl;
    cout << "Exit Mach Number: " << M_e << endl;
    cout << "Exit Temperature (K): " << T_e << endl;
    cout << "Exit Pressure (Pa): " << p_e << endl;
    cout << "Exit Velocity (m/s): " << V_e << endl;
    cout << "Thrust (N): " << F << endl;

    return 0;
}
