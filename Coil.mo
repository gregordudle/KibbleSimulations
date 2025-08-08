model Coil "Coil"
  Modelica.Electrical.Analog.Interfaces.Pin p annotation(
    Placement(transformation(origin = {-52, -92}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-40, -150}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.Pin n annotation(
    Placement(transformation(origin = {0, -92}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {60, -150}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a pos annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-148, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b pos_out annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {150, 0}, extent = {{-10, -10}, {10, 10}})));
  
  parameter Modelica.Units.SI.Length coil_h = 0.05 "height of the coil";
  parameter Modelica.Units.SI.Length coil_r = 0.15 "radius of the coil";
  parameter Integer coil_nbr = 1000 "number of tours of the coil";

  protected 
  Real coil_l = coil_nbr*2*Modelica.Constants.pi*coil_r;

  function MagneticFlux "Returns the magnetic flux for a coil that is positioned in a flux density B which has finite extension in space."
    input Modelica.Units.SI.Length pos_z;
    input Modelica.Units.SI.Length coil_height;
    input Modelica.Units.SI.Length coil_length;
    output Modelica.Units.SI.MagneticFlux phi;
    protected
      Modelica.Units.SI.Length field_height = 0.05 "B is different from zero in [-field_height,+field_height]";
      Modelica.Units.SI.MagneticFluxDensity B = 1 "Flux density B in Tesla";
      Modelica.Units.SI.Length sup = min(pos_z + (coil_height/2), field_height) "upper limit of integral";
      Modelica.Units.SI.Length inf = max(pos_z - (coil_height/2), -field_height) "lower limit of integral";
    algorithm
      phi := if (sup > inf) then coil_length*(sup - inf)*B else 0;
      annotation(
      uses(Modelica(version = "4.0.0")));
  end MagneticFlux;

  
  equation
    der(MagneticFlux(pos.s, coil_h, coil_l)) = p.v - n.v;
    p.i + n.i = 0;
    pos.f + pos_out.f = 0;
    pos_out.f = p.i * MagneticFlux(pos.s,coil_h,coil_l);
    annotation(
    Diagram(graphics = {Text(origin = {15, 81}, extent = {{-81, 13}, {81, -13}}, textString = "%name"), Rectangle(origin = {26, 50}, fillPattern = FillPattern.Solid, extent = {{-66, 4}, {66, -4}}), Line(origin = {-42, -77}, points = {{-10, -15}, {-10, 5}, {10, 5}, {10, 15}, {10, 15}}), Line(origin = {-9.7929, -82.2071}, points = {{-10.2071, 10.2071}, {9.79289, 10.2071}, {9.79289, -7.79289}, {7.79289, -7.79289}, {9.79289, -9.79289}}), Line(origin = {-54, 32}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -8}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -48}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -28}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, 12}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-80, 57}, points = {{0, 27}, {0, -27}, {0, -27}}, thickness = 1, arrow = {Arrow.Filled, Arrow.Filled}), Rectangle(origin = {26, -60}, fillPattern = FillPattern.Solid, extent = {{-66, 4}, {66, -4}}), Line(origin = {90, -5}, points = {{0, 51}, {0, -51}, {0, -51}, {0, -51}}), Line(origin = {-38, -5}, points = {{0, 53}, {0, -53}}), Line(origin = {-20, -67}, points = {{0, 5}, {0, -5}, {0, -5}})}),
    version = "",
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {-2, 118},textColor = {0, 0, 255}, extent = {{-144, 22}, {144, -22}}, textString = "%name"), Line(origin = {-78, 40}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-78, 0}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-78, -40}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-78, -20}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-78, 20}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Text(origin = {-119, 29}, textColor = {170, 0, 127}, extent = {{-9, -9}, {9, 9}}, textString = "pos"), Text(origin = {-66, -125}, textColor = {0, 85, 255}, extent = {{-18, -9}, {18, 9}}, textString = "p"), Text(origin = {86, -123}, textColor = {0, 85, 255}, extent = {{-18, -9}, {18, 9}}, textString = "n"), Line(origin = {-118, -9}, points = {{0, 27}, {0, -27}, {0, -27}}, color = {170, 0, 127}, thickness = 3, arrow = {Arrow.Filled, Arrow.Filled}, arrowSize = 7), Rectangle(origin = {10, -56}, fillPattern = FillPattern.Solid, extent = {{-70, 4}, {70, -4}}), Line(origin = {76, -1}, points = {{0, 55}, {0, -51}, {0, -51}, {0, -51}}), Line(origin = {-56, -1}, points = {{0, 53}, {0, -53}}), Line(origin = {104, 40}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Line(origin = {104, 0}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Line(origin = {104, -40}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Line(origin = {104, -20}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Line(origin = {104, 20}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Rectangle(origin = {10, 56}, fillPattern = FillPattern.Solid, extent = {{-70, 4}, {70, -4}}), Line(origin = {62, -103.777}, points = {{-2, 43.7774}, {-2, -38.2226}, {2, -44.2226}, {2, -42.2226}, {2, -40.2226}, {-2, -40.2226}}), Line(origin = {-40, -102}, points = {{0, 42}, {0, -42}})}, coordinateSystem(extent = {{-150, 150}, {150, -150}})));
end Coil;
