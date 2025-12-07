model BIPMcoil "BIPMcoil"
  Modelica.Electrical.Analog.Interfaces.Pin p annotation(
    Placement(transformation(origin = {-52, -92}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-40, -150}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Interfaces.Pin n annotation(
    Placement(transformation(origin = {0, -92}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {60, -150}, extent = {{-10, -10}, {10, 10}})));
 
  Modelica.Mechanics.Translational.Interfaces.Flange_a pos_a annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-148, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b pos_b annotation(
    Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {150, 0}, extent = {{-10, -10}, {10, 10}})));
  
  parameter Real r = 0.125;
  parameter Real N = 1057;
  
  parameter String fileName = "C:/Users/gregor.dudle/OneDrive - OST/aFE/2024_BIPM_Kibble/Simulations/Modelica_Work/Components/BIPM_MagneticField/BIPM_magnetic_field_02.csv";
  final parameter String tableName = "Tabelle";
 
   Modelica.Blocks.Tables.CombiTable2Ds magneticFieldTable(
    tableOnFile = true,
    fileName = fileName,
    tableName = tableName,
    smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments,
    u1 = pos_a.s,
    u2 = r
  );
  
equation
    (p.v - n.v) = der(pos_a.s) * magneticFieldTable.y * r * 2 * 3.14 * N;
    p.i + n.i = 0;
    pos_a.f + pos_b.f = 0;
    pos_a.f = 0;
    annotation(
    Diagram(graphics = {Text(origin = {15, 81}, extent = {{-81, 13}, {81, -13}}, textString = "%name"), Rectangle(origin = {26, 50}, fillPattern = FillPattern.Solid, extent = {{-66, 4}, {66, -4}}), Line(origin = {-42, -77}, points = {{-10, -15}, {-10, 5}, {10, 5}, {10, 15}, {10, 15}}), Line(origin = {-9.7929, -82.2071}, points = {{-10.2071, 10.2071}, {9.79289, 10.2071}, {9.79289, -7.79289}, {7.79289, -7.79289}, {9.79289, -9.79289}}), Line(origin = {-54, 32}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -8}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -48}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, -28}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-54, 12}, points = {{-12, 0}, {12, 0}}, color = {0, 200, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-80, 57}, points = {{0, 27}, {0, -27}, {0, -27}}, thickness = 1, arrow = {Arrow.Filled, Arrow.Filled}), Rectangle(origin = {26, -60}, fillPattern = FillPattern.Solid, extent = {{-66, 4}, {66, -4}}), Line(origin = {90, -5}, points = {{0, 51}, {0, -51}, {0, -51}, {0, -51}}), Line(origin = {-38, -5}, points = {{0, 53}, {0, -53}}), Line(origin = {-20, -67}, points = {{0, 5}, {0, -5}, {0, -5}})}),
    version = "",
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {-2, 118},textColor = {0, 0, 255}, extent = {{-144, 22}, {144, -22}}, textString = "%name"), Line(origin = {-78, 38}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-78, 0}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-78, -40}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-78, -20}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Line(origin = {-78, 20}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 5), Text(origin = {-119, 29}, textColor = {170, 0, 127}, extent = {{-9, -9}, {9, 9}}, textString = "pos"), Text(origin = {-66, -125}, textColor = {0, 85, 255}, extent = {{-18, -9}, {18, 9}}, textString = "p"), Text(origin = {86, -123}, textColor = {0, 85, 255}, extent = {{-18, -9}, {18, 9}}, textString = "n"), Line(origin = {-118, -9}, points = {{0, 27}, {0, -27}, {0, -27}}, color = {170, 0, 127}, thickness = 3, arrow = {Arrow.Filled, Arrow.Filled}, arrowSize = 7), Rectangle(origin = {10, -56}, fillPattern = FillPattern.Solid, extent = {{-70, 4}, {70, -4}}), Line(origin = {76, -1}, points = {{0, 55}, {0, -51}, {0, -51}, {0, -51}}), Line(origin = {-56, -1}, points = {{0, 53}, {0, -53}}), Line(origin = {104, 40}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Line(origin = {104, 0}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Line(origin = {104, -40}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Line(origin = {104, -20}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Line(origin = {104, 20}, points = {{-12, 0}, {12, 0}}, color = {0, 170, 0}, thickness = 1.5, arrow = {Arrow.Filled, Arrow.None}, arrowSize = 5), Rectangle(origin = {10, 56}, fillPattern = FillPattern.Solid, extent = {{-70, 4}, {70, -4}}), Line(origin = {62, -103.777}, points = {{-2, 43.7774}, {-2, -38.2226}, {2, -44.2226}, {2, -42.2226}, {2, -40.2226}, {-2, -40.2226}}), Line(origin = {-40, -102}, points = {{0, 42}, {0, -42}})}, coordinateSystem(extent = {{-150, 150}, {150, -150}})),
 Documentation(info = "<html><head></head><body>Description of the BIPM coil.&nbsp;<div>Dugr, 2025-09-01<br><div><br><div><br></div></div></div></body></html>", revisions = "<html><head></head><body>2.1</body></html>", __OpenModelica_infoHeader = "<html><head></head><body><br></body></html>"));
end BIPMcoil;
