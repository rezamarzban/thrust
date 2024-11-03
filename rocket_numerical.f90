program rocket_engine
    implicit none

    ! Practical Parameters for a Rocket Engine
    real(8) :: p_t, T_t, p_0, A_star, A_e, gamma, R
    real(8) :: term, exponent
    real(8) :: mass_flow_rate, M_e, T_e, p_e, V_e, F
    real(8) :: tolerance, ratio_mid, M_e_lower, M_e_upper, M_e_mid
    integer :: max_iterations, iter

    ! Assign values
    p_t = 7000000.0d0    ! Total Pressure in Pascals (7 MPa)
    T_t = 3300.0d0       ! Total Temperature in Kelvin
    p_0 = 101325.0d0     ! Free Stream Pressure in Pascals (1 atm)
    A_star = 0.05d0      ! Throat Area in square meters
    A_e = 0.1d0          ! Exit Area in square meters
    gamma = 1.3d0        ! Specific Heat Ratio for propellants
    R = 375.0d0          ! Gas Constant in J/(kg·K)

    ! Calculate common terms
    term = (gamma + 1.0d0) / 2.0d0
    exponent = (gamma + 1.0d0) / (2.0d0 * (gamma - 1.0d0))

    ! 1. Calculate Mass Flow Rate
    mass_flow_rate = (A_star * p_t) / sqrt(T_t) * sqrt(gamma / R) * term**(-exponent)

    ! 2. Calculate Exit Mach Number using bisection method
    tolerance = 1.0d-6
    max_iterations = 1000
    M_e_lower = 0.1d0
    M_e_upper = 20.0d0

    do iter = 1, max_iterations
        M_e_mid = (M_e_lower + M_e_upper) / 2.0d0
        ratio_mid = area_ratio(M_e_mid, A_e, A_star, gamma)

        if (abs(ratio_mid - A_e / A_star) < tolerance) then
            M_e = M_e_mid
            exit
        elseif (ratio_mid < A_e / A_star) then
            M_e_lower = M_e_mid
        else
            M_e_upper = M_e_mid
        end if
    end do

    ! 3. Calculate Exit Temperature
    T_e = T_t / (1.0d0 + (gamma - 1.0d0) / 2.0d0 * M_e**2)

    ! 4. Calculate Exit Pressure
    p_e = p_t * (1.0d0 + (gamma - 1.0d0) / 2.0d0 * M_e**2)**(-gamma / (gamma - 1.0d0))

    ! 5. Calculate Exit Velocity
    V_e = M_e * sqrt(gamma * R * T_e)

    ! 6. Calculate Thrust
    F = mass_flow_rate * V_e + (p_e - p_0) * A_e

    ! Display results
    print *, 'Mass Flow Rate (kg/s): ', mass_flow_rate
    print *, 'Exit Mach Number: ', M_e
    print *, 'Exit Temperature (K): ', T_e
    print *, 'Exit Pressure (Pa): ', p_e
    print *, 'Exit Velocity (m/s): ', V_e
    print *, 'Thrust (N): ', F

contains

    ! Function to calculate the area ratio based on Mach number
    real(8) function area_ratio(M_e, A_e, A_star, gamma)
        implicit none
        real(8), intent(in) :: M_e, A_e, A_star, gamma
        real(8) :: term, exponent

        term = (gamma + 1.0d0) / 2.0d0
        exponent = (gamma + 1.0d0) / (2.0d0 * (gamma - 1.0d0))

        area_ratio = (term**(-exponent)) * ((1.0d0 + (gamma - 1.0d0) / 2.0d0 * M_e**2)**exponent) / M_e
    end function area_ratio

end program rocket_engine
