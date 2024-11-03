#include <iostream>
#include <cmath>

double calculateInitialMass(double mf, double Isp, double delta_v) {
    const double g0 = 9.81; // Acceleration due to gravity in m/s^2
    double m0 = mf * exp(delta_v / (Isp * g0));
    return m0;
}

int main() {
    // Example values
    double mf = 1000.0; // final mass in kg
    double Isp = 300.0; // specific impulse in seconds
    double delta_v = 9500.0; // delta V for LEO in m/s

    double m0 = calculateInitialMass(mf, Isp, delta_v);
    std::cout << "Initial mass (m0): " << m0 << " kg" << std::endl;

    return 0;
}
