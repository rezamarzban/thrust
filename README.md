![NASA](rktthsum.gif)

Source: [NASA](https://www.grc.nasa.gov/WWW/BGH/rktthsum.html)

## Rocket Thrust Summary

### Known Parameters:
- **p<sub>t</sub>** = Total Pressure
- **T<sub>t</sub>** = Total Temperature
- **p<sub>0</sub>** = Free Stream Pressure
- **A<sup>*</sup>** = Throat Area
- **A<sub>e</sub>** = Exit Area
- **&gamma;** = Specific Heat Ratio
- **R** = Gas Constant

### Calculated Parameters:
- **M<sub>e</sub>** = Exit Mach Number
- **T<sub>e</sub>** = Exit Temperature
- **p<sub>e</sub>** = Exit Pressure
- **V<sub>e</sub>** = Exit Velocity
- **&dot;m** = Mass Flow Rate
- **F** = Thrust

### Key Equations:

#### Mass Flow Rate:
$$
\dot{m} = \frac{A^* p_t}{\sqrt{T_t}} \sqrt{\frac{\gamma}{R}} \left( \frac{\gamma + 1}{2} \right)^{-\frac{\gamma + 1}{2(\gamma - 1)}}
$$

#### Exit Mach Number:
$$
\frac{A_e}{A^*} = \left( \frac{\gamma + 1}{2} \right)^{-\frac{\gamma + 1}{2(\gamma - 1)}} \frac{\left(1 + \frac{\gamma - 1}{2} M_e^2 \right)^{\frac{\gamma + 1}{2(\gamma - 1)}}}{M_e} 
$$

#### Exit Temperature:
$$
\frac{T_e}{T_t} = \left( 1 + \frac{\gamma - 1}{2} M_e^2 \right)^{-1}
$$

#### Exit Pressure:
$$
\frac{p_e}{p_t} = \left( 1 + \frac{\gamma - 1}{2} M_e^2 \right)^{\frac{-\gamma}{\gamma - 1}}
$$

#### Exit Velocity:
$$
V_e = M_e \sqrt{\gamma R T_e}
$$

#### Thrust:
$$
F = \dot{m} V_e + (p_e - p_0) A_e
$$
