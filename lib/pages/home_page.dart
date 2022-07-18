import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msc_project/app_utils.dart';
import 'package:msc_project/widgets/graph_widget.dart';
import 'package:msc_project/widgets/loading_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../bloc/scuba_tx_bloc.dart';
import '../injection_container.dart';
import '../models/scuba_box.dart';
import '../widgets/app_drawer.dart';
import '../widgets/channel_control_widget.dart';
import '../widgets/expanded_bottom_sheet_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrgansListBloc>(create: (_) => sl<OrgansListBloc>()..add(GetAllOrgansEvent())),
        BlocProvider<CurrentChannelBloc>(create: (_) => sl<CurrentChannelBloc>()),
        BlocProvider<CurrentOrganBloc>(create: (_) => sl<CurrentOrganBloc>()),
        BlocProvider<SmartAuditEventListBloc>(create: (_) => sl<SmartAuditEventListBloc>()..add(ShowSmartAuditEventList())),
        BlocProvider<SmartAuditGraphBloc>(create: (_) => sl<SmartAuditGraphBloc>())
      ],
      child: Scaffold(
        appBar: appBar(widget.title),
        body: buildBody(context),
        drawer: const AppDrawer(),
      ),
    );
  }

  buildBody(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 70,
      maxHeight: MediaQuery.of(context).size.height / 1.2,
      borderRadius: radius,
      backdropEnabled: true,
      panelBuilder: (ScrollController sc) => buildExpandedBottomSheet(sc),
      collapsed: buildCollapsedSlideUpPanel(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height + 70,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              OrganSelectionBlocConsumer(),
              ChannelControlsBlocBuilder(),
              GraphAndMachinePropertiesBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer<OrgansListBloc, OrgansListState> OrganSelectionBlocConsumer() {
    return BlocConsumer<OrgansListBloc, OrgansListState>(
      builder: (context, state) {
        if (state is OrgansList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Organs List: ${state.listType}",
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                heightSizedBox(5),
                DropDownWidget(scubaBoxes: state.scubaBoxes),
              ],
            );
        }
        return const DropDownWidget(scubaBoxes: []);
        },
      listener: (context, state) {
        if (state is OrgansList && state.scubaBoxes.isNotEmpty) {
          String organId = state.scubaBoxes.first.id;
          BlocProvider.of<CurrentOrganBloc>(context).add(GetCurrentOrganEvent(organId));
        }
      },
    );
  }

  BlocBuilder<CurrentChannelBloc, ChannelControlsState> ChannelControlsBlocBuilder() {
    return BlocBuilder<CurrentChannelBloc, ChannelControlsState>(
              builder: (context, state) {
                if (state is CurrentChannel) {
                  return ChannelControlWidget(
                    controller: controller,
                    currentChannel: state.channel,
                  );
                }
                return ChannelControlWidget(
                  controller: controller,
                  currentChannel: 1,
                );
              },
            );
  }

  BlocBuilder<CurrentOrganBloc, CurrentOrganState> GraphAndMachinePropertiesBlocBuilder() {
    return BlocBuilder<CurrentOrganBloc, CurrentOrganState>(
              builder: (context, state) {
                if (state is CurrentOrgan) {
                  return Column(
                    children: [
                      GraphPagerWidget(controller: controller, context: context, scubaBox: state.scubaBox),
                      buildGraphPagerIndicator(),
                      MachinePropertiesWidget(scubaBox: state.scubaBox)
                    ],
                  );
                }
                return const SizedBox();
              },
            );
  }

  Container buildCollapsedSlideUpPanel() {
    return Container(
      decoration: BoxDecoration(color: const Color(primaryColor), borderRadius: radius),
      child: Column(
        children: [
          heightSizedBox(10),
          const Image(image: AssetImage(imgUpDirection), color: Colors.white, height: 20),
          heightSizedBox(5),
          const Text("Swipe up to view Smart Audit event logs", style: TextStyle(color: Colors.white)),
          heightSizedBox(10),
        ],
      ),
    );
  }

  Container buildGraphPagerIndicator() {
    return Container(
      height: 20,
      margin: const EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      child: SmoothPageIndicator(
        controller: controller,
        count: 3,
        effect: ScrollingDotsEffect(dotHeight: 8, dotWidth: 8, dotColor: Colors.grey, activeDotColor: Colors.accents[1]),
      ),
    );
  }

  Column buildExpandedBottomSheet(ScrollController scrollController) {
    return Column(
      children: [
        heightSizedBox(10),
        const Image(image: AssetImage(imgDownDirection), color: Colors.black, height: 20),
        Expanded(
          child: ExpandedBottomSheetWidget(sc: scrollController),
        ),
      ],
    );
  }
}



