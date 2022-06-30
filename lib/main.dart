import 'package:flutter/material.dart';
import 'package:msc_project/app_utils.dart';
import 'injection_container.dart' as di;
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'ScubaTx';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: HomePage(title: appTitle),
      theme: appThemeData,
    );
  }
}
