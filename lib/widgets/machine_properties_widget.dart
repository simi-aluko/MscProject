import 'package:flutter/material.dart';

import '../app_utils.dart';
import '../models/scuba_box.dart';

class MachinePropertiesWidget extends StatelessWidget {
  final ScubaBox scubaBox;
  const MachinePropertiesWidget({super.key, required this.scubaBox});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildMachinePropertyItem("Machine Id", scubaBox.id),
              ),
              Expanded(child: buildMachinePropertyItem("Temperature", scubaBox.temperature))
            ],
          ),
          heightSizedBox(8),
          Row(
            children: [
              Expanded(child: buildMachinePropertyItem("Gas", scubaBox.gas)),
              Expanded(child: buildMachinePropertyItem("Battery", scubaBox.battery))
            ],
          )
        ],
      ),
    );
  }

  Row buildMachinePropertyItem(String property, String value) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "$property: ",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(primaryColor)),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
        ),
      ],
    );
  }
}
