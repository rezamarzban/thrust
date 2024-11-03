function m0 = calculate_initial_mass(mf, Isp, delta_v)
    g0 = 9.81; % Acceleration due to gravity in m/s^2
    m0 = mf * exp(delta_v / (Isp * g0));
end

% Example values
mf = 1000; % final mass in kg
Isp = 300; % specific impulse in seconds
delta_v = 9500; % delta V for LEO in m/s

m0 = calculate_initial_mass(mf, Isp, delta_v);
fprintf('Initial mass (m0): %.2f kg\n', m0);
