// Class FluxGenerator 
model FluxGenerator "Source of magnetic flux through a coil of given geometry. B field ist fix in space. A coil with a given geometry moves in space. The mouvement is described by a function 
Currently there are two velocities implemented [constant and sinusoidal]."

// functions returning a position as function of time
//
// -> constant velocity
  function displ_const_vel "returns a position for a constant velocity mouvement"
    input Modelica.Units.SI.Time x;
    input Modelica.Units.SI.Length ampli;
    input Modelica.Units.SI.Frequency freq;
      
    output Modelica.Units.SI.Length position;
      
    protected
        Real t_prime = mod(x,1/freq);
    algorithm
       position := if ((t_prime < (1/(2*freq))) and (t_prime >= 0)) then ampli * (4 * t_prime * freq - 1) else ampli * (3 - (4 * t_prime * freq));
    
  end displ_const_vel;
// -> sinusoidal velocity
  function displ_sin_vel "returns a position for a sinusoidal velocity mouvement"
    input Modelica.Units.SI.Time x;
    input Modelica.Units.SI.Length ampli;
    input Modelica.Units.SI.Frequency freq;
      
    output Modelica.Units.SI.Length position;
    algorithm
       position := ampli* cos(2*Modelica.Constants.pi*freq*x);

  end displ_sin_vel;


// function calculating the magnetic flux for a given position
  function MagneticFlux "Returns the magnetic flux for a coil that is positioned in a flux density"
    input Modelica.Units.SI.Length pos_z;
    input Modelica.Units.SI.Length coil_heigth;
    input Modelica.Units.SI.Length coil_depth;
    
    output Modelica.Units.SI.MagneticFlux phi;
  protected
    Modelica.Units.SI.Length field_heigth = 1 "B is different from zero in [-field_heigth,+field_heigth]";
    Modelica.Units.SI.MagneticFluxDensity B = 1 "Flux density B in Tesla";
    Modelica.Units.SI.Length sup = min(pos_z + (coil_heigth/2),field_heigth) "upper limit of integral";
    Modelica.Units.SI.Length inf = max(pos_z - (coil_heigth/2),-field_heigth)"lower limit of integral";
    
  algorithm
    phi := if (sup > inf) then coil_depth * (sup-inf) * B else 0;
  annotation(
      uses(Modelica(version = "4.0.0")));
  end MagneticFlux;


//
// begin definition of class FluxGenerator
// ***************************************

  parameter Real ampli=1;
  parameter Real freq=1;
  parameter Real coil_h=1;
  parameter Real coil_d=1; 
  //Modelica.Magnetic.FluxTubes.Interfaces.MagneticPort phi_out;
  
  Modelica.Units.SI.Length pos_z;
  output MagneticPort phi_out annotation(
    Placement(transformation(origin = {72, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {74, 0}, extent = {{-10, -10}, {10, 10}})));  equation
  pos_z = displ_const_vel(time,ampli,freq);
  phi_out.Phi = MagneticFlux(pos_z,coil_h,coil_d);

annotation(
    Diagram(graphics = {Rectangle(origin = {1, 1}, extent = {{-71, 73}, {71, -73}})}),
  Icon(graphics = {Text(origin = {1, 60}, extent = {{-71, 10}, {71, -10}}, textString = "%name"), Rectangle(origin = {1, 1}, extent = {{-71, 73}, {71, -73}}), Text(origin = {88, 18}, textColor = {0, 255, 0}, extent = {{-8, 6}, {8, -6}}, textString = "Phi out")}));
end FluxGenerator;
