model DynamicPhaseV03
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {58, -32}, extent = {{-10, -10}, {10, 10}})));
  BIPMcoil coil(fileName = fileName) annotation(
    Placement(transformation(origin = {28, 0}, extent = {{-15, -15}, {15, 15}})));
  parameter String fileName = "C:/Users/gregor.dudle/OneDrive - OST/aFE/2024_BIPM_Kibble/Simulations/Modelica_Work/Components/BIPM_MagneticField/BIPM_magnetic_field_02.csv";
  triangular_pos x_pos_driver annotation(
    Placement(transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(coil.pos_a, coil.pos_b) annotation(
    Line(points = {{13.2, 0}, {13.2, 20}, {43.2, 20}, {43.2, 0}}, color = {0, 127, 0}));
  connect(coil.n, GRD.p) annotation(
    Line(points = {{34, -15}, {58, -15}, {58, -23}}, color = {0, 0, 255}));
  connect(x_pos_driver.x_a, coil.pos_a) annotation(
    Line(points = {{-13, 0}, {13, 0}}, color = {0, 127, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),
  Documentation(info = "<html><head></head><body><div><br></div><div>Experiment to simulate the dynamic phase of the Kibble Balance experiment</div><div>Relies on the following components<h3>Driver</h3></div><div><br></div><div><br></div><div><br></div></body></html>", __OpenModelica_infoHeader = "<html><head></head><body><b>Kibble Balance Simulation</b><div><b><br></b></div></body></html>", revisions = "<html><head></head><body>Version 3<div><br></div></body></html>"),
  Diagram(graphics = {Text(origin = {1, 56}, extent = {{-33, 14}, {33, -14}}, textString = "Kibble Balance", fontSize = 24, textStyle = {TextStyle.Bold, TextStyle.UnderLine}), Text(origin = {1, 47}, extent = {{-27, 3}, {27, -3}}, textString = "Dynamic phase", fontSize = 12, horizontalAlignment = TextAlignment.Left)}));
end DynamicPhaseV03;
