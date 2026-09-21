model StaticPhaseV01
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {34, -32}, extent = {{-10, -10}, {10, 10}})));
  BIPMcoil coil(tableFileName = magTableFileName) annotation(
    Placement(transformation(origin = {28, 0}, extent = {{-15, -15}, {15, 15}})));
  parameter String magTableFileName = "C:/Users/gregor.dudle/OneDrive - OST/aFE/2026_Kibble/Modelica_Work/Components/BIPM_MagneticField/BIPM_magnetic_field_02.csv";
  Modelica.Electrical.Analog.Sources.ConstantCurrent CurrentSource(I = 0.1)  annotation(
    Placement(transformation(origin = {30, -46}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sensors.ForceSensor ForceSensor annotation(
    Placement(transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 1000)  annotation(
    Placement(transformation(origin = {54, -46}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {90, -84}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(coil.pos_b, ForceSensor.flange_a) annotation(
    Line(points = {{43, 0}, {70, 0}}, color = {0, 127, 0}));
  connect(coil.p, CurrentSource.p) annotation(
    Line(points = {{24, -14}, {4, -14}, {4, -46}, {20, -46}}, color = {0, 0, 255}));
  connect(CurrentSource.n, R1.p) annotation(
    Line(points = {{40, -46}, {44, -46}}, color = {0, 0, 255}));
  connect(coil.n, R1.n) annotation(
    Line(points = {{34, -14}, {64, -14}, {64, -46}}, color = {0, 0, 255}));
  connect(coil.n, GRD.p) annotation(
    Line(points = {{34, -14}, {34, -22}}, color = {0, 0, 255}));
  connect(coil.pos_a, ForceSensor.flange_b) annotation(
    Line(points = {{14, 0}, {-24, 0}, {-24, -80}, {90, -80}, {90, 0}}, color = {0, 127, 0}));
  connect(fixed.flange, ForceSensor.flange_b) annotation(
    Line(points = {{90, -84}, {90, 0}}, color = {0, 127, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),
  Documentation(info = "<html><head></head><body><div><br></div><div>Experiment to simulate the dynamic phase of the Kibble Balance experiment</div><div>Relies on the following components<h3>Driver</h3></div><div><br></div><div><br></div><div><br></div></body></html>", __OpenModelica_infoHeader = "<html><head></head><body><b>Kibble Balance Simulation</b><div><b><br></b></div></body></html>", revisions = "<html><head></head><body>Version 3<div><br></div></body></html>"),
  Diagram(graphics = {Text(origin = {1, 56}, extent = {{-33, 14}, {33, -14}}, textString = "Kibble Balance", fontSize = 24, textStyle = {TextStyle.Bold, TextStyle.UnderLine}), Text(origin = {1, 47}, extent = {{-27, 3}, {27, -3}}, textString = "Static phase", fontSize = 12, horizontalAlignment = TextAlignment.Left)}));
end StaticPhaseV01;
