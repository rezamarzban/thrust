clc;
clear all;

% Practical Parameters for a Rocket Engine
p_t = 7000000; % Total Pressure in Pascals (7 MPa, a common value for rocket engines)
T_t = 3300; % Total Temperature in Kelvin (typical for high-performance rockets)
p_0 = 101325; % Free Stream Pressure in Pascals (1 atm)
A_star = 0.05; % Throat Area in square meters (e.g., 50 cm^2)
A_e = 0.1; % Exit Area in square meters (e.g., 100 cm^2)
gamma = 1.3; % Specific Heat Ratio for many rocket propellants
R = 375; % Gas Constant in J/(kg·K) (specific to the propellant)

global term = (gamma + 1) / 2; % This term is used widely in equations 
global exponent = (gamma + 1) / (2 * (gamma - 1)); % This exponent is widely used in equations 

% 1. Calculate Mass Flow Rate
mass_flow_rate = (A_star * p_t) / sqrt(T_t) * sqrt(gamma / R) * (term^(-exponent));

% 2. Calculate Exit Mach Number using bisection method
function ratio = area_ratio(M_e, A_e, A_star, gamma)
    global term;
    global exponent;
    ratio = (term^(-exponent)) * ((1 + (gamma - 1) / 2 * M_e^2)^exponent) / M_e;
end

% Bisection Method to find M_e
M_e_lower = 0.1; % Lower bound for Mach Number
M_e_upper = 20.0; % Upper bound for Mach Number
tolerance = 1e-6; % Tolerance for convergence
max_iterations = 1000; % Maximum number of iterations

for iter = 1:max_iterations
    M_e_mid = (M_e_lower + M_e_upper) / 2;
    ratio_mid = area_ratio(M_e_mid, A_e, A_star, gamma);
    
    if abs(ratio_mid - A_e / A_star) < tolerance
        break;
    elseif ratio_mid < A_e / A_star
        M_e_lower = M_e_mid;
    else
        M_e_upper = M_e_mid;
    end
end

M_e = M_e_mid;

% 3. Calculate Exit Temperature
T_e = T_t / (1 + (gamma - 1) / 2 * M_e^2);

% 4. Calculate Exit Pressure
p_e = p_t * (1 + (gamma - 1) / 2 * M_e^2) ^ (-gamma / (gamma - 1));

% 5. Calculate Exit Velocity
V_e = M_e * sqrt(gamma * R * T_e);

% 6. Calculate Thrust
F = mass_flow_rate * V_e + (p_e - p_0) * A_e;

% Display results
fprintf('Mass Flow Rate (kg/s): %.2f\n', mass_flow_rate);
fprintf('Exit Mach Number: %.2f\n', M_e);
fprintf('Exit Temperature (K): %.2f\n', T_e);
fprintf('Exit Pressure (Pa): %.2f\n', p_e);
fprintf('Exit Velocity (m/s): %.2f\n', V_e);
fprintf('Thrust (N): %.2f\n', F);
