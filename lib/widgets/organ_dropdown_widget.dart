import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msc_project/bloc/scuba_tx_bloc.dart';
import 'package:msc_project/models/scuba_box.dart';
import 'package:msc_project/pages/home_page.dart';

import '../app_utils.dart';

class OrganDropDown extends StatefulWidget {
  final List<ScubaBox> scubaBoxes;
  List<String> organs = [];

  OrganDropDown({super.key, required this.scubaBoxes}) {
    organs = scubaBoxes.map((e) => "${e.organ.name} ${e.id}").toList();
  }

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
            value: dropdownValue.isNotEmpty ? dropdownValue : widget.organs.first,
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
              String currentScubaId = newValue!.split(" ")[1];
              BlocProvider.of<CurrentOrganBloc>(context).add(GetCurrentOrganEvent(currentScubaId));
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
            image: AssetImage(getIcon(value.toLowerCase())),
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

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.scubaBoxes,
  }) : super(key: key);
  final List<ScubaBox> scubaBoxes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: OrganDropDown(
        scubaBoxes: scubaBoxes,
      ),
    );
  }
}
