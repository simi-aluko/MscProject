import 'package:flutter/material.dart';

const primaryColor = 0xff223143;
const lightGrey = 0xffF5F5F5;
const lightGrey2 = 0xffDEDEDE;
const lightPrimaryColor = 0xFF223143;
MaterialColor appMaterialColor = const MaterialColor(primaryColor, {
  50: Color(0xFF223143),
  100: Color(0xFF1f2c3c),
  200: Color(0xFF1b2736),
  300: Color(0xFF18222f),
  400: Color(0xFF141d28),
  500: Color(0xFF111922),
  600: Color(0xFF0e141b),
  700: Color(0xFF0a0f14),
  800: Color(0xFF070a0d),
  900: Color(0xff030507),
});

ThemeData appThemeData = ThemeData(
  primarySwatch: appMaterialColor,
  brightness: Brightness.light,
);

AppBar appBar(String title) => AppBar(
      title: Text(title),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
    );

// Strings
const liver = "Liver";
const pancreas = "Pancreas";
const heart = "Heart";
const addScubaBox = "Add ScubaTx Box";
const organs = "Organs";
const settings = "Settings";
const allOrgans = "All";

// Assets
const imgBox = 'assets/images/box.png';
const imgHeart = 'assets/images/heart.png';
const imgPancreas = 'assets/images/pancreas.png';
const imgLiver = 'assets/images/liver.png';
const imgHospBuilding = 'assets/images/hospital-building.png';
const imgAll = 'assets/images/select-all.png';
const imgUpDirection = "assets/images/up-direction.png";
const imgDownDirection = "assets/images/down-direction.png";

// UI
SizedBox heightSizedBox(double space) {
  return SizedBox(height: space);
}

SizedBox widthSizedBox(double space) {
  return SizedBox(width: space);
}

BorderRadiusGeometry radius = const BorderRadius.only(
  topLeft: Radius.circular(12.0),
  topRight: Radius.circular(12.0),
);
