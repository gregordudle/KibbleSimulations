model DynamicPhaseV02
  Modelica.Blocks.Sources.Pulse vel_driver(amplitude = 0.002, offset = -0.001, period = 20, startTime = 0) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Speed Motor(exact = true, s(start = -0.005)) annotation(
    Placement(transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {78, -32}, extent = {{-10, -10}, {10, 10}})));
  BIPMcoil coil(fileName = fileName) annotation(
    Placement(transformation(origin = {48, 0}, extent = {{-15, -15}, {15, 15}})));
  parameter String fileName = "C:/Users/gregor.dudle/OneDrive - OST/aFE/2024_BIPM_Kibble/Simulations/Modelica_Work/Components/BIPM_MagneticField/BIPM_magnetic_field_02.csv";
equation
  connect(vel_driver.y, Motor.v_ref) annotation(
    Line(points = {{-58, 0}, {-14, 0}}, color = {0, 0, 127}));
  connect(Motor.flange, coil.pos_a) annotation(
    Line(points = {{8, 0}, {34, 0}}, color = {0, 127, 0}));
  connect(coil.pos_a, coil.pos_b) annotation(
    Line(points = {{34, 0}, {34, 20}, {64, 20}, {64, 0}}, color = {0, 127, 0}));
  connect(coil.n, GRD.p) annotation(
    Line(points = {{54, -14}, {78, -14}, {78, -22}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
  Documentation(info = "<html><head></head><body><br></body></html>"));
end DynamicPhaseV02;
