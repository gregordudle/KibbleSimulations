model Translational_stage
  Modelica.Mechanics.Translational.Sources.Speed Geschwindigkeit(exact = true)  annotation(
    Placement(transformation(origin = {-8, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Pulse vel_driver(period = 0.2,amplitude=0.9,offset=-0.45)  annotation(
    Placement(transformation(origin = {-70, 12}, extent = {{-10, -10}, {10, 10}})));
  Coil Spule annotation(
    Placement(transformation(origin = {44, 6}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {48, -20}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(vel_driver.y, Geschwindigkeit.v_ref) annotation(
    Line(points = {{-58, 12}, {-20, 12}}, color = {0, 0, 127}));
  connect(Geschwindigkeit.flange, Spule.pos) annotation(
    Line(points = {{2, 12}, {34, 12}}, color = {0, 127, 0}));
  connect(Spule.n, GRD.p) annotation(
    Line(points = {{48, -4}, {48, -10}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end Translational_stage;
