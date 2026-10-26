model StaticPhaseM02
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {14, -32}, extent = {{-10, -10}, {10, 10}})));
  parameter String magTableFileName = "C:/Users/gregor.dudle/OneDrive - OST/aFE/2026_Kibble/Modelica_Work/Components/BIPM_MagneticField/BIPM_magnetic_field_02.csv";
  parameter Real B_l_para = -400;
 

  BIPMcoil coil(tableFileName = magTableFileName, B_l = B_l_para) annotation(
    Placement(transformation(origin = {8, 0}, extent = {{-15, -15}, {15, 15}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 1000)  annotation(
    Placement(transformation(origin = {34, -46}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent(I = 0.1)  annotation(
    Placement(transformation(origin = {44, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
 Modelica.Mechanics.Translational.Sensors.ForceSensor forceSensor annotation(
    Placement(transformation(origin = {6, 34}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(f_constant = 10, useSupport = true)  annotation(
    Placement(transformation(origin = {-50, 2}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(transformation(origin = {-50, -16}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(coil.n, GRD.p) annotation(
    Line(points = {{14, -15}, {14, -23}}, color = {0, 0, 255}));
  connect(R1.p, coil.p) annotation(
    Line(points = {{24, -46}, {-6, -46}, {-6, -14}, {4, -14}}, color = {0, 0, 255}));
  connect(coil.n, constantCurrent.p) annotation(
    Line(points = {{14, -14}, {44, -14}, {44, -16}}, color = {0, 0, 255}));
  connect(constantCurrent.n, R1.n) annotation(
    Line(points = {{44, -36}, {44, -46}}, color = {0, 0, 255}));
  connect(coil.pos_a, forceSensor.flange_a) annotation(
    Line(points = {{-6, 0}, {-4, 0}, {-4, 34}}, color = {0, 127, 0}));
  connect(forceSensor.flange_b, coil.pos_b) annotation(
    Line(points = {{16, 34}, {24, 34}, {24, 0}}, color = {0, 127, 0}));
 connect(constantForce.flange, coil.pos_a) annotation(
    Line(points = {{-40, 2}, {-6, 2}, {-6, 0}}, color = {0, 127, 0}));
 connect(constantForce.support, fixed.flange) annotation(
    Line(points = {{-50, -8}, {-50, -16}}, color = {0, 127, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),
  Documentation(info = "<html><head></head><body><div><br></div><div>Experiment to simulate the dynamic phase of the Kibble Balance experiment</div><div>Relies on the following components<h3>Driver</h3></div><div><br></div><div><br></div><div><br></div></body></html>", __OpenModelica_infoHeader = "<html><head></head><body><b>Kibble Balance Simulation</b><div><b><br></b></div></body></html>", revisions = "<html><head></head><body>Version 3<div><br></div></body></html>"),
  Diagram(graphics = {Text(origin = {1, 80}, extent = {{-33, 14}, {33, -14}}, textString = "Kibble Balance", fontSize = 24, textStyle = {TextStyle.Bold, TextStyle.UnderLine}), Text(origin = {1, 71}, extent = {{-27, 3}, {27, -3}}, textString = "Static phase", fontSize = 12, horizontalAlignment = TextAlignment.Left)}));
end StaticPhaseM02;
