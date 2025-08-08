model DynamicPhase
  Modelica.Blocks.Sources.Pulse vel_driver(period = 10,amplitude=0.04,offset=-0.02)  annotation(
    Placement(transformation(origin = {-70, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {40, -28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Speed Motor(exact = true)  annotation(
    Placement(transformation(origin = {-30, 12}, extent = {{-10, -10}, {10, 10}})));
  Coil Coil01 annotation(
    Placement(transformation(origin = {34, 12}, extent = {{-15, -15}, {15, 15}})));
equation
  connect(vel_driver.y, Motor.v_ref) annotation(
    Line(points = {{-58, 12}, {-42, 12}}, color = {0, 0, 127}));
  connect(Coil01.n, GRD.p) annotation(
    Line(points = {{40, -2}, {40, -18}}, color = {0, 0, 255}));
  connect(Motor.flange, Coil01.pos) annotation(
    Line(points = {{-20, 12}, {20, 12}}, color = {0, 127, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),experiment(StartTime=0,StopTime=20,Interval=0.001));
end DynamicPhase;
