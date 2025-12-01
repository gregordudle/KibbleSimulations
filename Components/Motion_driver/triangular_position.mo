model triangular_pos "triangular_pos"
  Modelica.Mechanics.Translational.Interfaces.Flange_a x_a annotation(
    Placement(transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}})));
  parameter Real period = 1 "Period of the triangular wave";
  parameter Real amplitude = 0.02 "Half peak-to-peak amplitude";
  parameter Real offset = 0.0 "Offset with respect to the centre height of the coil";
  Real velocity = 4*amplitude/period;
protected
  Real phase;
public
equation
  phase = mod(time, period);
  if phase < period/2 then
    x_a.s = velocity*phase - amplitude + offset;
  else
    x_a.s = -velocity*(phase - period/2) + amplitude + offset;
  end if;
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(graphics = {Rectangle(extent = {{-68, 60}, {68, -60}}), Line(origin = {0, 9.6465}, points = {{-60, -9.64645}, {-60, -9.64645}, {-40, 10.3536}, {-20, -9.64645}, {0, 10.3536}, {20, -9.64645}, {40, 10.3536}, {60, -9.64645}, {60, -9.64645}}), Text(origin = {4, 78}, extent = {{-46, 12}, {46, -12}}, textString = "%name")}),
    Icon(graphics = {Rectangle(extent = {{-68, 60}, {68, -60}}), Line(origin = {0, 9.64645}, points = {{-60, -9.64645}, {-60, -9.64645}, {-40, 10.3536}, {-20, -9.64645}, {0, 10.3536}, {20, -9.64645}, {40, 10.3536}, {60, -9.64645}, {60, -9.64645}}), Text(origin = {0, 82}, textColor = {0, 0, 255}, extent = {{-54, 12}, {54, -12}}, textString = "%name")}));
end triangular_pos;
