model DynamicPhase
  Modelica.Blocks.Sources.Pulse vel_driver(period = 10,amplitude=0.04,offset=-0.02)  annotation(
    Placement(transformation(origin = {-70, 12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {46, -48}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Speed Motor(exact = true)  annotation(
    Placement(transformation(origin = {-30, 12}, extent = {{-10, -10}, {10, 10}})));
  Coil Coil01 annotation(
    Placement(transformation(origin = {34, 12}, extent = {{-15, -15}, {15, 15}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor V_sensor annotation(
    Placement(transformation(origin = {36, -22}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(vel_driver.y, Motor.v_ref) annotation(
    Line(points = {{-58, 12}, {-42, 12}}, color = {0, 0, 127}));
  connect(Motor.flange, Coil01.pos) annotation(
    Line(points = {{-20, 12}, {20, 12}}, color = {0, 127, 0}));
  connect(Coil01.pos_out, Coil01.pos) annotation(
    Line(points = {{50, 12}, {48, 12}, {48, 32}, {20, 32}, {20, 12}}, color = {0, 127, 0}));
  connect(Coil01.p, V_sensor.p) annotation(
    Line(points = {{30, -2}, {0, -2}, {0, -22}, {26, -22}}, color = {0, 0, 255}));
  connect(V_sensor.n, Coil01.n) annotation(
    Line(points = {{46, -22}, {66, -22}, {66, -2}, {40, -2}}, color = {0, 0, 255}));
  connect(V_sensor.n, GRD.p) annotation(
    Line(points = {{46, -22}, {46, -38}}, color = {0, 0, 255}));
  connect(GRD.p, Coil01.aux_a) annotation(
    Line(points = {{46, -38}, {76, -38}, {76, 4}, {50, 4}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),experiment(StartTime=0,StopTime=20,Interval=0.001),
  Diagram(graphics = {Text(origin = {-59, 63}, extent = {{-33, 5}, {33, -5}}, textString = "Dynamic phase", fontSize = 18), Text(origin = {-30, 84}, extent = {{-54, 10}, {54, -10}}, textString = "Kibble Balance Project", fontSize = 26, textStyle = {TextStyle.Bold})}));
end DynamicPhase;
