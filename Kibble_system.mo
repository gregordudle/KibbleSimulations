model Kibble_system
  parameter Modelica.Units.SI.Length ampli0 =1;
  parameter Modelica.Units.SI.Frequency freq0 = 1;
  parameter Modelica.Units.SI.Length coil_h0 = 1;
  parameter Modelica.Units.SI.Length coil_d0 = 1;
  Coil Spule annotation(
    Placement(transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {20, -52}, extent = {{-10, -10}, {10, 10}})));
  FluxGenerator machine annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(Spule.n, GRD.p) annotation(
    Line(points = {{20, -10}, {20, -42}}, color = {0, 0, 255}));
  connect(machine.phi_out, Spule.phi_in) annotation(
    Line(points = {{-62, 0}, {6, 0}}, color = {0, 255, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end Kibble_system;
