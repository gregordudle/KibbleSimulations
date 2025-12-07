# KibbleSimulations V02
Created:    2025-09-06 / Dugr

## Purpose of this repository
This repository contains Version 02 of the model that simulates the behavior of the Kibble balance in Open Modelica.  

## Description of the physical experiment

### Dynamic phase
A coil moves vertically up and down in a magnetic flux with magnetic flux density $B$. The magnetic field is purely radial $B_r$. The coil always in the magnetic field. A voltage is induced in the coil because the coil moves with velocity $v_z$ (cf below).
$$
  \phi = \iint_{\Sigma} \vec{B}\cdot \vec{n} \cdot dA
$$ 
with $A$ the area of the coil (see below) and $B$ the magnetic flux density ([$B$] = Tesla, [$\phi$]=Weber)
$$
  U = - \frac{d \phi}{dt} = ... = v \oint_C \vec{B} \times\vec{dl}
$$

### Static phase
The coil is maintained at a fixed position and a constant current is sent through the coil. As the coil is positioned in a magnetic field $B$, the coil is subject to a force. This force can be measured (or compensated with a mass in the gravitational field).
$$
  F = I \cdot \oint_C \vec{B} \times\vec{dl}
$$

## Description of the developed code
#### Magnetic circuit
The model *MagneticCircuit* contains the geometry of the coil and values of the magnetic field in certain points:  
- coil_height:  total height of the coil (through which the magnetic flux flows)   Units: m
- coil depth:   "length" of the coil.                                              Units: m  
coil_height * coil_depth is the area $A$ through which the flux flows.  

The position of the coil is referenced by its centre. The position of the coil is an input variable available on a connector (a flange_a carrying position and force)

The terminations of the coil are available as ElectricalPin (p and n). If one of the pins is forced to ground, the other pin will represent the induced voltage. 

#### DynamicPhase
The model *DynamicPhase* represents the dynamic phase of the experiment:  
- a translation stage moves with a velocity proportional to an input signal. 
- a symmetric sqr signal is applied to the control port of the translation stage driver. The stage will thus move up and down
- the position of the translation stage is connected to the z position control (pos_a) of the coil. It must also be connected to the pos_b port.
- the strength of the magnetic field is provided as table and interpolation is used to calculate the magnetic field between these points. For the moment only a table for $B_r(r,z)$ is provided.
- a voltage is induced between the two electrical pins (one of the pins must be connected to GRD)
- The force part of the ports pos and pos_out are not involved.


