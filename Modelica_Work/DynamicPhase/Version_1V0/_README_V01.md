# KibbleSimulations V01
Created:    2025-08-07 / Dugr

## Purpose of this repository
This repository contains Version 01 of the model that simulates the behavior of the Kibble balance in Open Modelica.  

## Description of the physical experiment

### Dynamic phase
A coil moves vertically up and down in a magnetic flux with magnetic flux density $B$. Both, coil and flux have finite
spatial extension. Thus, the coil moves in and out of the magnetic flux. As the flux flowing through the coil changes, a voltage will be induced in the wire of the coil. 
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
#### Coil
The model *coil* contains the geometry of the coil :  
- coil_height:  total height of the coil (through which the magnetic flux flows)   Units: m
- coil depth:   "length" of the coil.                                              Units: m  
coil_height * coil_depth is the area $A$ through which the flux flows.  

The position of the coil is referenced by its centre. The position of the coil is an input variable available on a connector (a flange_a carrying position and force)

The terminations of the coil are available as ElectricalPin (p and n). If one of the pins is forced to ground, the other pin will represent the induced voltage. 

**Version 01**: The magnetic flux density $\vec{B}$ is limited in space. The coil moves in and out of the magnetic flux density. When the coil enters (or exits) the zone where the magnetic flux density is $\neq 0$, the magnetic flux $\phi$ changes.  
*Rem:* This is not how the real Kibble balance works.  

#### DynamicPhase
The model *DynamicPhase* represents the dynamic phase of the experiment:  
- a translation stage moves with a velocity proportional to an input signal. 
- a symmetric sqr signal is applied to the control port of the translation stage driver. The stage will thus move back up and forth
- the position of the translation stage is connected to the z position control (pos) of the coil. It must also be connected to the pos_out port.
- a voltage is induced between the two electrical pins (one of the pins must be connected to GRD)
- The force part of the ports pos and pos_out are not involved.

#### StaticPhase
The model *StaticPhase* represents the static phase of the experiment:
- a constant current source is applied to the electrical pins of the coil. 
- a force arises between entry and exit position port (one of the ports must be connected to FIX)

#### ClosedLoop
The model *ClosedLoop* is a trial to simulate the sequence "masse on" - "masse off". 
- a sqr signal is connected to the input port of a constant force component.
- this force is compared with the force produced by the coil in the magnetic field when it is powered with a constant current. 
- the difference of the forces is fed into a PID which drives a controlled current source. 

