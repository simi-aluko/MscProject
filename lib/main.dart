import 'package:flutter/material.dart';
import 'package:msc_project/app_utils.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'ScubaTx';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: const HomePage(title: appTitle),
      theme: appThemeData,
    );
  }
}
