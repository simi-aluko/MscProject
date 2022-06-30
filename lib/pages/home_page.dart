import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msc_project/app_utils.dart';
import 'package:msc_project/widgets/graph_widget.dart';
import 'package:msc_project/widgets/loading_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../bloc/scuba_tx_bloc.dart';
import '../injection_container.dart';
import '../models/scuba_box.dart';
import '../widgets/app_drawer.dart';
import '../widgets/no_scuba_boxes_widget.dart';
import '../widgets/organ_dropdown_widget.dart';

class HomePage extends StatelessWidget {
  final String title;
  final PageController controller = PageController();
  int currentPage = 0;

  HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title),
      body: buildBody(context),
      drawer: const AppDrawer(),
    );
  }

  BlocProvider<ScubaTxBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ScubaTxBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              BlocBuilder<ScubaTxBloc, ScubaTxState>(builder: (context, state) {
                if (state is Loading) {
                  return const LoadingWidget();
                } else if (state is Loaded) {
                  return Column(
                    children: [
                      buildDropDown(context, state),
                      buildChannelControls(),
                      buildGraphPager(context, state),
                      buildGraphPagerIndicator(),
                      buildMachineProperties(state.scubaBoxes[0])
                    ],
                  );
                } else if (state is Empty) {
                  return const NoScubaBoxes();
                } else {
                  return const LoadingWidget();
                }
              }),
            ],
          ),
        ),
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

  Padding buildMachineProperties(ScubaBox scubaBox) {
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

  Container buildGraphPagerIndicator() {
    return Container(
      height: 20,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      child: SmoothPageIndicator(
        controller: controller,
        count: 3,
        effect: ScrollingDotsEffect(dotHeight: 8, dotWidth: 8, dotColor: Colors.grey, activeDotColor: Colors.accents[1]
            // strokeWidth: 5,
            ),
      ),
    );
  }

  SizedBox buildGraphPager(BuildContext context, Loaded state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: PageView(
        controller: controller,
        children: [
          GraphWidget(
            pressureData: state.scubaBoxes[0].channel1.pressure,
            flowData: state.scubaBoxes[0].channel1.flow,
            channel: 1,
          ),
          GraphWidget(
            pressureData: state.scubaBoxes[0].channel2.pressure,
            flowData: state.scubaBoxes[0].channel2.flow,
            channel: 2,
          ),
          GraphWidget(
            pressureData: state.scubaBoxes[0].channel3.pressure,
            flowData: state.scubaBoxes[0].channel3.flow,
            channel: 3,
          ),
        ],
      ),
    );
  }

  Row buildChannelControls() {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.arrow_left, size: 50), onPressed: () {}),
        const Spacer(),
        const Text(
          "Channel",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        IconButton(icon: const Icon(Icons.arrow_right, size: 50), onPressed: () {}),
      ],
    );
  }

  SizedBox buildDropDown(BuildContext context, Loaded state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: OrganDropDown(organs: state.scubaBoxes.map((e) => "${e.organ.name} ${e.id}").toList()),
    );
  }
}
