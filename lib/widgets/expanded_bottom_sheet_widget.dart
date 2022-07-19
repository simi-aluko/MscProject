import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msc_project/widgets/continous_graph_widget.dart';
import '../app_utils.dart';
import '../bloc/scuba_tx_bloc.dart';
import '../models/smart_audit_event.dart';

class ExpandedBottomSheetWidget extends StatefulWidget {
  final ScrollController sc;
  const ExpandedBottomSheetWidget({super.key, required this.sc});

  @override
  State<ExpandedBottomSheetWidget> createState() => _ExpandedBottomSheetWidgetState();
}

class _ExpandedBottomSheetWidgetState extends State<ExpandedBottomSheetWidget> {
  int selectedSmartAuditEventIndex = 0;
  String graphTitle = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Column(
        children: [
          Text(graphTitle, style: bottomSheetTitleStyle()),
          buildSmartAuditGraph(),
          heightSizedBox(15),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Smart Audit Events", style: bottomSheetTitleStyle(), textAlign: TextAlign.start,)),
          heightSizedBox(10),
          buildSmartAuditEventList(),
        ],
      ),
    );
  }

  TextStyle bottomSheetTitleStyle() => const TextStyle(fontSize: 17, color: Color(primaryColor), fontWeight: FontWeight.w600);

  BlocBuilder<SmartAuditGraphBloc, SmartAuditGraphState> buildSmartAuditGraph() {
    return BlocBuilder<SmartAuditGraphBloc, SmartAuditGraphState>(builder: (context, state) {
        if (state is LoadedSmartAuditGraphState) {
          final pressureData = state.smartAuditEvent.channelData.pressure;
          final flowData = state.smartAuditEvent.channelData.flow;
          final channel = state.smartAuditEvent.channel;
          graphTitle = "${state.smartAuditEvent.name} on Channel $channel";
          return GraphWidget(pressureData: pressureData, flowData: flowData, channel: channel, isContinuous:false);
        }
        return const Center(
            child: Text("Smart Audit event graph would show here. Select an event."));
      });
  }

  BlocConsumer<SmartAuditEventListBloc, SmartAuditEventListState> buildSmartAuditEventList() {
    return BlocConsumer<SmartAuditEventListBloc, SmartAuditEventListState>(
        listener: (context, state) {
          if (state is LoadedSmartAuditEventListState && state.smartAuditEvents.isNotEmpty) {
            List<SmartAuditEvent> smartAuditEvents = state.smartAuditEvents;

            BlocProvider.of<SmartAuditGraphBloc>(context)
                .add(ShowSmartAuditGraph(smartAuditEvent: smartAuditEvents[selectedSmartAuditEventIndex]));
          }
        },
        builder: (context, state) {
          if (state is LoadedSmartAuditEventListState) {
            return Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: widget.sc,
                  itemCount: state.smartAuditEvents.length,
                  itemBuilder: (context, position) {
                    return InkWell(
                        onTap: () {
                          setState(() {
                            selectedSmartAuditEventIndex = position;
                            final currentSmartAuditEvent = state.smartAuditEvents[position];
                            graphTitle = "${currentSmartAuditEvent.name} on Channel ${currentSmartAuditEvent.channel}";
                          });
                        },
                        child: buildSmartAuditEventRow(state.smartAuditEvents[position], position));
                  }),
            );
          }
          return const Center(child: Text("No Smart Audit Events at the moment."));
        },
      );
  }

  Container buildSmartAuditEventRow(SmartAuditEvent smartAuditEvent, int position){
    DateTime startDateTime = smartAuditEvent.channelData.pressure.first.time;
    String startTime = "${startDateTime.hour}:${startDateTime.minute}:${startDateTime.second}";
    String eventType = smartAuditEvent.name;
    int channel = smartAuditEvent.channel;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      decoration: BoxDecoration(
        border: selectedSmartAuditEventIndex == position
            ? Border.all(color: const Color(lightPrimaryColor), width: 2) : null,
        borderRadius: BorderRadius.circular(10),
        color: const Color(lightGrey)
      ),
      child: Text("$eventType on Channel $channel at $startTime",
        style: selectedSmartAuditEventIndex == position
            ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
            : const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
    );
  }
}
