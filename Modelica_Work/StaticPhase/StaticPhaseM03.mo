model StaticPhaseM03
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {34, -32}, extent = {{-10, -10}, {10, 10}})));
  BIPMcoil coil(tableFileName = magTableFileName, B_l = -420) annotation(
    Placement(transformation(origin = {28, 0}, extent = {{-15, -15}, {15, 15}})));
  parameter String magTableFileName = "C:/Users/gregor.dudle/OneDrive - OST/aFE/2026_Kibble/Modelica_Work/Components/BIPM_MagneticField/BIPM_magnetic_field_02.csv";
  Modelica.Mechanics.Translational.Sensors.ForceSensor ForceSensor annotation(
    Placement(transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 1000)  annotation(
    Placement(transformation(origin = {54, -46}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {90, -84}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Force Masse annotation(
    Placement(transformation(origin = {26, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent PrgCurrentSource annotation(
    Placement(transformation(origin = {30, -46}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Blocks.Continuous.PID PID(Td=10, Ti = 10, k = 0.1)  annotation(
    Placement(transformation(origin = {56, -68}, extent = {{6, -6}, {-6, 6}})));
  Modelica.Blocks.Sources.Trapezoid Driver(amplitude = 9.81, rising = 0.2, width = 4.9, falling = 0.2, period = 10)  annotation(
    Placement(transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(coil.pos_b, ForceSensor.flange_a) annotation(
    Line(points = {{43, 0}, {70, 0}}, color = {0, 127, 0}));
  connect(coil.n, GRD.p) annotation(
    Line(points = {{34, -15}, {34, -22}}, color = {0, 0, 255}));
  connect(fixed.flange, ForceSensor.flange_b) annotation(
    Line(points = {{90, -84}, {90, 0}}, color = {0, 127, 0}));
  connect(fixed.flange, coil.pos_a) annotation(
    Line(points = {{90, -84}, {-18, -84}, {-18, 0}, {13, 0}}, color = {0, 127, 0}));
  connect(coil.n, R1.n) annotation(
    Line(points = {{34, -15}, {64, -15}, {64, -46}}, color = {0, 0, 255}));
  connect(Masse.flange, ForceSensor.flange_a) annotation(
    Line(points = {{36, 30}, {70, 30}, {70, 0}}, color = {0, 127, 0}));
  connect(PrgCurrentSource.n, R1.p) annotation(
    Line(points = {{40, -46}, {44, -46}}, color = {0, 0, 255}));
  connect(coil.p, PrgCurrentSource.p) annotation(
    Line(points = {{24, -14}, {10, -14}, {10, -46}, {20, -46}}, color = {0, 0, 255}));
  connect(ForceSensor.f, PID.u) annotation(
    Line(points = {{72, -10}, {72, -68}, {63, -68}}, color = {0, 0, 127}));
  connect(PID.y, PrgCurrentSource.i) annotation(
    Line(points = {{49, -68}, {30, -68}, {30, -58}}, color = {0, 0, 127}));
  connect(Driver.y, Masse.f) annotation(
    Line(points = {{-39, 30}, {14, 30}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
  Documentation(info = "<html><head></head><body><div><br></div><div>Experiment to simulate the static phase of the Kibble Balance experiment</div><div>Relies on the following components<h3>Driver</h3>allows to periodically lift up and put down the weight</div><div><br><h3>Coil </h3></div><div><br></div><div><br></div></body></html>", __OpenModelica_infoHeader = "<html><head></head><body><b>Kibble Balance Simulation</b><div><b><br></b></div></body></html>", revisions = "<html><head></head><body>Version 3<div><br></div></body></html>"),
  Diagram(graphics = {Text(origin = {3, 76}, extent = {{-33, 14}, {33, -14}}, textString = "Kibble Balance", fontSize = 24, textStyle = {TextStyle.Bold, TextStyle.UnderLine}), Text(origin = {3, 67}, extent = {{-27, 3}, {27, -3}}, textString = "Static phase", fontSize = 12, horizontalAlignment = TextAlignment.Left)}));
end StaticPhaseM03;
