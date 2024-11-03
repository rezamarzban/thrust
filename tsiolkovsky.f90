program TsiolkovskyEquation
    implicit none
    real :: mf, Isp, delta_v, m0
    real, parameter :: g0 = 9.81  ! Acceleration due to gravity in m/s^2

    ! Example values
    mf = 1000.0   ! Final mass in kg
    Isp = 300.0   ! Specific impulse in seconds
    delta_v = 9500.0  ! Delta V for LEO in m/s

    m0 = calculate_initial_mass(mf, Isp, delta_v)
    print *, 'Initial mass (m0): ', m0, ' kg'
    
contains

    function calculate_initial_mass(mf, Isp, delta_v) result(m0)
        real :: mf, Isp, delta_v, m0
        m0 = mf * exp(delta_v / (Isp * g0))
    end function calculate_initial_mass

end program TsiolkovskyEquation
