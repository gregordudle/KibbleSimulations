model Coil "Coil"
  Modelica.Electrical.Analog.Interfaces.Pin p annotation(
    Placement(transformation(origin = {-40, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-40, -100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.Pin n annotation(
    Placement(transformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a pos annotation(
    Placement(transformation(origin = {-100, 58}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 58}, extent = {{-10, -10}, {10, 10}})));

  parameter Modelica.Units.SI.Length coil_h=0.05;
  parameter Modelica.Units.SI.Length coil_d=1;

  function MagneticFlux "Returns the magnetic flux for a coil that is positioned in a flux density B which has finite extension in space."
    input Modelica.Units.SI.Length pos_z;
    input Modelica.Units.SI.Length coil_heigth;
    input Modelica.Units.SI.Length coil_depth;
    
    output Modelica.Units.SI.MagneticFlux phi;
  protected
    Modelica.Units.SI.Length field_heigth = 0.01 "B is different from zero in [-field_heigth,+field_heigth]";
    Modelica.Units.SI.MagneticFluxDensity B = 1 "Flux density B in Tesla";
    Modelica.Units.SI.Length sup = min(pos_z + (coil_heigth/2),field_heigth) "upper limit of integral";
    Modelica.Units.SI.Length inf = max(pos_z - (coil_heigth/2),-field_heigth)"lower limit of integral";
    
  algorithm
    phi := if (sup > inf) then coil_depth * (sup-inf) * B else 0;
  annotation(
      uses(Modelica(version = "4.0.0")));
  end MagneticFlux;


equation
  der(MagneticFlux(pos.s,coil_h,coil_d))= p.v - n.v;
  p.i + n.i = 0;
  pos.f  = 0;
  
annotation(
    Diagram(graphics = {Text(origin = {0, 81}, extent = {{-100, 11}, {100, -11}}, textString = "%name"), Rectangle(origin = {0, -10}, fillPattern = FillPattern.Solid, extent = {{-20, 70}, {20, -70}}), Line(origin = {-30, -85}, points = {{-10, -15}, {-10, 5}, {10, 5}, {10, 15}, {10, 15}}), Line(origin = {30.2071, -90.2071}, points = {{-10.2071, 10.2071}, {9.79289, 10.2071}, {9.79289, -7.79289}, {7.79289, -7.79289}, {9.79289, -9.79289}}), Line(origin = {-54, 32}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -8}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -48}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -28}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, 12}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5)}),
    version = "",
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {0, 82}, extent = {{-98, 10}, {98, -10}}, textString = "%name"), Rectangle(origin = {0, -10}, fillPattern = FillPattern.Solid, extent = {{-20, 70}, {20, -70}}), Line(origin = {-30, -85}, points = {{-10, -15}, {-10, 5}, {10, 5}, {10, 15}, {10, 15}}), Line(origin = {30.2071, -90.2071}, points = {{-10.2071, 10.2071}, {9.79289, 10.2071}, {9.79289, -7.79289}, {7.79289, -7.79289}, {9.79289, -9.79289}}), Line(origin = {-54, 32}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -8}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -48}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -28}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, 12}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Text(origin = {-87, 21}, textColor = {0, 200, 0}, extent = {{-9, -9}, {9, 9}}, textString = "phi in"), Text(origin = {-58, -89}, textColor = {0, 85, 255}, extent = {{-18, -9}, {18, 9}}, textString = "p"), Text(origin = {58, -91}, textColor = {0, 85, 255}, extent = {{-18, -9}, {18, 9}}, textString = "n")}));
end Coil;
