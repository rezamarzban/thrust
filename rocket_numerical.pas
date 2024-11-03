program RocketEngineCalculation;

uses
  Math, SysUtils;

function AreaRatio(M_e, A_e, A_star, gamma: Double): Double;
var
  term, exponent: Double;
begin
  term := (gamma + 1) / 2;
  exponent := (gamma + 1) / (2 * (gamma - 1));
  AreaRatio := Power(term, -exponent) * Power(1 + (gamma - 1) / 2 * M_e * M_e, exponent) / M_e;
end;

var
  p_t, T_t, p_0, A_star, A_e, gamma, R: Double;
  term, exponent: Double;
  mass_flow_rate, M_e, T_e, p_e, V_e, F: Double;
  M_e_lower, M_e_upper, M_e_mid, ratio_mid: Double;
  tolerance: Double;
  iter: Integer;
  max_iterations: Integer;

begin
  // Practical Parameters for a Rocket Engine
  p_t := 7000000.0;   // Total Pressure in Pascals (7 MPa)
  T_t := 3300.0;      // Total Temperature in Kelvin
  p_0 := 101325.0;    // Free Stream Pressure in Pascals (1 atm)
  A_star := 0.05;     // Throat Area in square meters
  A_e := 0.1;         // Exit Area in square meters
  gamma := 1.3;       // Specific Heat Ratio for propellants
  R := 375.0;         // Gas Constant in J/(kg·K)

  // Calculate common terms
  term := (gamma + 1) / 2;
  exponent := (gamma + 1) / (2 * (gamma - 1));

  // 1. Calculate Mass Flow Rate
  mass_flow_rate := (A_star * p_t) / Sqrt(T_t) * Sqrt(gamma / R) * Power(term, -exponent);

  // 2. Calculate Exit Mach Number using bisection method
  M_e_lower := 0.1;   // Lower bound for Mach Number
  M_e_upper := 20.0;  // Upper bound for Mach Number
  tolerance := 1e-6;  // Tolerance for convergence
  max_iterations := 1000;

  for iter := 1 to max_iterations do
  begin
    M_e_mid := (M_e_lower + M_e_upper) / 2;
    ratio_mid := AreaRatio(M_e_mid, A_e, A_star, gamma);

    if Abs(ratio_mid - A_e / A_star) < tolerance then
    begin
      Break;
    end
    else if ratio_mid < A_e / A_star then
    begin
      M_e_lower := M_e_mid;
    end
    else
    begin
      M_e_upper := M_e_mid;
    end;
  end;

  M_e := (M_e_lower + M_e_upper) / 2;

  // 3. Calculate Exit Temperature
  T_e := T_t / (1 + (gamma - 1) / 2 * M_e * M_e);

  // 4. Calculate Exit Pressure
  p_e := p_t * Power(1 + (gamma - 1) / 2 * M_e * M_e, -gamma / (gamma - 1));

  // 5. Calculate Exit Velocity
  V_e := M_e * Sqrt(gamma * R * T_e);

  // 6. Calculate Thrust
  F := mass_flow_rate * V_e + (p_e - p_0) * A_e;

  // Display results
  WriteLn(Format('Mass Flow Rate (kg/s): %.2f', [mass_flow_rate]));
  WriteLn(Format('Exit Mach Number: %.2f', [M_e]));
  WriteLn(Format('Exit Temperature (K): %.2f', [T_e]));
  WriteLn(Format('Exit Pressure (Pa): %.2f', [p_e]));
  WriteLn(Format('Exit Velocity (m/s): %.2f', [V_e]));
  WriteLn(Format('Thrust (N): %.2f', [F]));
end.
