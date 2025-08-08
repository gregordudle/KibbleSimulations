model StaticPhase
  Coil coil01 annotation(
    Placement(transformation(origin = {0, 10}, extent = {{-15, -15}, {15, 15}})));
  Modelica.Electrical.Analog.Sources.ConstantCurrent CurrentSource(I = 0.01)  annotation(
    Placement(transformation(origin = {-22, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Resistor R1(R = 1000)  annotation(
    Placement(transformation(origin = {22, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground GRD annotation(
    Placement(transformation(origin = {6, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Sensors.ForceSensor LoadCell annotation(
    Placement(transformation(origin = {0, 44}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Components.Fixed FIX annotation(
    Placement(transformation(origin = {64, -8}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(CurrentSource.n, coil01.p) annotation(
    Line(points = {{-22, -32}, {-22, -5}, {-4, -5}}, color = {0, 0, 255}));
  connect(coil01.n, R1.p) annotation(
    Line(points = {{6, -5}, {6, -5.5}, {22, -5.5}, {22, -20}}, color = {0, 0, 255}));
  connect(CurrentSource.p, R1.n) annotation(
    Line(points = {{-22, -52}, {22, -52}, {22, -40}}, color = {0, 0, 255}));
  connect(coil01.n, GRD.p) annotation(
    Line(points = {{6, -4}, {6, -10}}, color = {0, 0, 255}));
  connect(coil01.pos, LoadCell.flange_a) annotation(
    Line(points = {{-14, 10}, {-26, 10}, {-26, 44}, {-10, 44}}, color = {0, 127, 0}));
  connect(LoadCell.flange_b, coil01.pos_out) annotation(
    Line(points = {{10, 44}, {26, 44}, {26, 10}, {16, 10}}, color = {0, 127, 0}));
  connect(coil01.pos_out, FIX.flange) annotation(
    Line(points = {{16, 10}, {64, 10}, {64, -8}}, color = {0, 127, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),
  Diagram(graphics = {Text(origin = {-62, 63}, extent = {{20, -3}, {-20, 3}}, textString = "Static phase", fontSize = 18), Text(origin = {-30, 84}, extent = {{-54, 10}, {54, -10}}, textString = "Kibble Balance Project", fontSize = 26, textStyle = {TextStyle.Bold, TextStyle.Bold})}));
end StaticPhase;
