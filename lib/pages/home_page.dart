import 'package:flutter/material.dart';
import 'package:msc_project/app_utils.dart';

import '../widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title),
      body: const Center(
        child: Text('My Page!'),
      ),
      drawer: const AppDrawer(),
    );
  }
}
