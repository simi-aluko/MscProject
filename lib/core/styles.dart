import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData appThemeData = ThemeData(
  primarySwatch: appMaterialColor,
  brightness: Brightness.light,
);

BorderRadiusGeometry radius = const BorderRadius.only(
  topLeft: Radius.circular(12.0),
  topRight: Radius.circular(12.0),
);
