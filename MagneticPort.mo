connector MagneticPort "Generic magnetic port"
  Modelica.Units.SI.MagneticPotential V_m "Magnetic potential at the port";
  flow Modelica.Units.SI.MagneticFlux Phi "Magnetic flux flowing into the port";
  annotation(
    defaultComponentName = "mag",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 255, 0}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(lineColor = {0, 200, 0}, fillColor = {0, 200, 0}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}), Text(origin = {60, -2}, textColor = {0, 200, 0}, extent = {{-160, 110}, {40, 50}}, textString = "%name")}),
    Documentation(revisions = "<html>
<ul>
<li><em> 2025   </em>
       by Gregor Dudle <br>(based on initial implementation by Christoph Clauss)
       </li>
</ul>
</html>", info = "<html>
<p>MagneticPort is the basic magnetic connector.</p>
</html>"));
end MagneticPort;
