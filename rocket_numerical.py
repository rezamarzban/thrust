import numpy as np

# Practical Parameters for a Rocket Engine
p_t = 7000000  # Total Pressure in Pascals
T_t = 3300     # Total Temperature in Kelvin
p_0 = 101325   # Free Stream Pressure in Pascals
A_star = 0.05  # Throat Area in square meters
A_e = 0.1      # Exit Area in square meters
gamma = 1.3    # Specific Heat Ratio
R = 375        # Gas Constant in J/(kg·K)

# Global terms
term = (gamma + 1) / 2
exponent = (gamma + 1) / (2 * (gamma - 1))

# 1. Calculate Mass Flow Rate
mass_flow_rate = (A_star * p_t) / np.sqrt(T_t) * np.sqrt(gamma / R) * term**(-exponent)

# 2. Define function for area ratio
def area_ratio(M_e, A_e, A_star, gamma, term, exponent):
    ratio = term**(-exponent) * ((1 + (gamma - 1) / 2 * M_e**2)**exponent) / M_e
    return ratio

# Bisection Method to find M_e
M_e_lower = 0.1
M_e_upper = 20.0
tolerance = 1e-6
max_iterations = 1000

for _ in range(max_iterations):
    M_e_mid = (M_e_lower + M_e_upper) / 2
    ratio_mid = area_ratio(M_e_mid, A_e, A_star, gamma, term, exponent)
    
    if abs(ratio_mid - A_e / A_star) < tolerance:
        break
    elif ratio_mid < A_e / A_star:
        M_e_lower = M_e_mid
    else:
        M_e_upper = M_e_mid

M_e = M_e_mid

# 3. Calculate Exit Temperature
T_e = T_t / (1 + (gamma - 1) / 2 * M_e**2)

# 4. Calculate Exit Pressure
p_e = p_t * (1 + (gamma - 1) / 2 * M_e**2) ** (-gamma / (gamma - 1))

# 5. Calculate Exit Velocity
V_e = M_e * np.sqrt(gamma * R * T_e)

# 6. Calculate Thrust
F = mass_flow_rate * V_e + (p_e - p_0) * A_e

# Display results
print(f"Mass Flow Rate (kg/s): {mass_flow_rate:.2f}")
print(f"Exit Mach Number: {M_e:.2f}")
print(f"Exit Temperature (K): {T_e:.2f}")
print(f"Exit Pressure (Pa): {p_e:.2f}")
print(f"Exit Velocity (m/s): {V_e:.2f}")
print(f"Thrust (N): {F:.2f}")
