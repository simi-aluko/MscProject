import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scuba_tx_bloc.dart';

class NoScubaBoxes extends StatefulWidget {
  const NoScubaBoxes({
    Key? key,
  }) : super(key: key);

  @override
  State<NoScubaBoxes> createState() => _NoScubaBoxesState();
}

class _NoScubaBoxesState extends State<NoScubaBoxes> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage("assets/images/hyperlink.png"),
            height: MediaQuery.of(context).size.height / 6,
          ),
          const SizedBox(height: 10),
          const Text(
            "You do not have any connected ScubaTx machine",
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: getScubaBoxes, child: const Text("Add ScubaTx Machine")),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  void getScubaBoxes() {
    BlocProvider.of<OrgansListBloc>(context).add(GetAllOrgansEvent());
  }
}
