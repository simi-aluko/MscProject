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
import '../widgets/channel_control_widget.dart';
import '../widgets/machine_properties_widget.dart';
import '../widgets/no_scuba_boxes_widget.dart';
import '../widgets/organ_dropdown_widget.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  int currentPage = 0;
  void updateState() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.title),
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
                  currentGlobalScubaBox = state.scubaBoxes[0];
                  return Column(
                    children: [
                      DropDownWidget(state: state, updateState: updateState),
                      ChannelControlWidget(controller: controller),
                      GraphPagerWidget(controller: controller, context: context, scubaBox: currentGlobalScubaBox!),
                      buildGraphPagerIndicator(),
                      MachinePropertiesWidget(scubaBox: currentGlobalScubaBox!)
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

  Container buildGraphPagerIndicator() {
    print("indicator changes");
    return Container(
      height: 20,
      margin: const EdgeInsets.only(top: 10),
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
}

ScubaBox? currentGlobalScubaBox;
