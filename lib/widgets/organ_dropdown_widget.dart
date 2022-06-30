import 'package:flutter/material.dart';

import '../app_utils.dart';

class OrganDropDown extends StatefulWidget {
  final List<String> organs;

  const OrganDropDown({super.key, required this.organs});

  @override
  State<OrganDropDown> createState() => _OrganDropDownState();
}

class _OrganDropDownState extends State<OrganDropDown> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Color(0xffD3D3D3)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: DropdownButton<String>(
            value: dropdownValue.isNotEmpty ? dropdownValue : null,
            hint: const Text('-- Select Organ --'),
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            underline: const SizedBox(),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: widget.organs.map<DropdownMenuItem<String>>((String value) {
              return buildDropdownMenuItem(value);
            }).toList(),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Image(
            image: AssetImage(getIcon(value)),
            height: 20,
            alignment: Alignment.centerRight,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value.toUpperCase(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String getIcon(String organ) {
    String organName = organ.split(" ")[0];
    switch (organName) {
      case "liver":
        return imgLiver;
      case "pancreas":
        return imgPancreas;
      case "heart":
        return imgHeart;
      default:
        return "";
    }
  }
}
