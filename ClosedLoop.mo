model ClosedLoop
  Modelica.Electrical.Analog.Sources.SignalCurrent ForceCurrentConverter annotation(
    Placement(transformation(origin = {-70, -42}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Coil Coil1 annotation(
    Placement(transformation(origin = {-76, 26}, extent = {{-15, -15}, {15, 15}})));
  Modelica.Mechanics.Translational.Sensors.ForceSensor pos_out annotation(
    Placement(transformation(origin = {-74, 56}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Fixed FIX annotation(
    Placement(transformation(origin = {90, 16}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 100)  annotation(
    Placement(transformation(origin = {-70, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {-70, -76}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sensors.ForceSensor Compensation annotation(
    Placement(transformation(origin = {44, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add DIFF(k1 = +1, k2 = -1)  annotation(
    Placement(transformation(origin = {-2, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation(
    Placement(transformation(origin = {14, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LimPID PID( k = 5, yMax = 5, yMin = -5, Ti = 0.1)  annotation(
    Placement(transformation(origin = {68, -4}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = 0) annotation(
    Placement(transformation(origin = {42, -4}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Pulse PulseGenerator(amplitude = 10, offset = -5,period=3)  annotation(
    Placement(transformation(origin = {-26, 36}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(Coil1.n, R1.p) annotation(
    Line(points = {{-70, 11}, {-70, -4}}, color = {0, 0, 255}));
  connect(pos_out.flange_b, FIX.flange) annotation(
    Line(points = {{-64, 56}, {90, 56}, {90, 16}}, color = {0, 127, 0}));
  connect(force.flange, Compensation.flange_a) annotation(
    Line(points = {{24, 36}, {34, 36}}, color = {0, 127, 0}));
  connect(Coil1.pos, pos_out.flange_a) annotation(
    Line(points = {{-90, 26}, {-92, 26}, {-92, 56}, {-84, 56}}, color = {0, 127, 0}));
  connect(Coil1.pos_out, pos_out.flange_b) annotation(
    Line(points = {{-60, 26}, {-64, 26}, {-64, 56}}, color = {0, 127, 0}));
  connect(DIFF.y, PID.u_m) annotation(
    Line(points = {{9, -20}, {68, -20}, {68, -16}}, color = {0, 0, 127}));
  connect(realExpression1.y, PID.u_s) annotation(
    Line(points = {{53, -4}, {56, -4}}, color = {0, 0, 127}));
  connect(PulseGenerator.y, force.f) annotation(
    Line(points = {{-15, 36}, {2, 36}}, color = {0, 0, 127}));
  connect(Compensation.flange_b, FIX.flange) annotation(
    Line(points = {{54, 36}, {90, 36}, {90, 16}}, color = {0, 127, 0}));
  connect(R1.n, ForceCurrentConverter.p) annotation(
    Line(points = {{-70, -24}, {-70, -32}}, color = {0, 0, 255}));
  connect(ForceCurrentConverter.n, Coil1.p) annotation(
    Line(points = {{-70, -52}, {-80, -52}, {-80, 12}}, color = {0, 0, 255}));
  connect(ForceCurrentConverter.n, GRD.p) annotation(
    Line(points = {{-70, -52}, {-70, -66}}, color = {0, 0, 255}));
  connect(ForceCurrentConverter.i, PID.y) annotation(
    Line(points = {{-58, -42}, {86, -42}, {86, -4}, {80, -4}}, color = {0, 0, 127}));
  connect(Compensation.f, DIFF.u1) annotation(
    Line(points = {{36, 26}, {36, 12}, {-38, 12}, {-38, -14}, {-14, -14}}, color = {0, 0, 127}));
  connect(pos_out.f, DIFF.u2) annotation(
    Line(points = {{-82, 46}, {-50, 46}, {-50, -26}, {-14, -26}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),experiment(StartTime=0,StopTime=20,Interval=0.001));
end ClosedLoop;
