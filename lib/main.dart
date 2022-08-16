import 'package:flutter/material.dart';
import 'package:msc_project/core/strings.dart';
import 'core/sl.dart' as sl;
import 'core/styles.dart';
import 'ui/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = stringAppName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: appTitle, home: const HomePage(title: appTitle), theme: appThemeData);
  }
}
