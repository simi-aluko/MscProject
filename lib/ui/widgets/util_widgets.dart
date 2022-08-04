import 'package:flutter/material.dart';



AppBar appBar(String title) => AppBar(
      title: Text(title),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))]
);

SizedBox heightSizedBox(double space) {
  return SizedBox(height: space);
}

SizedBox widthSizedBox(double space) {
  return SizedBox(width: space);
}

