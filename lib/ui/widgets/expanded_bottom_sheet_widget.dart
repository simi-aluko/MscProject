import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msc_project/ui/widgets/scrolling_graph_widget.dart';
import 'package:msc_project/ui/widgets/util_widgets.dart';
import '../../core/colors.dart';
import '../../data/models/smart_audit_event.dart';
import '../../data/models/time_series.dart';
import '../bloc/scuba_tx_bloc.dart';

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
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Smart Audit Events", style: bottomSheetTitleStyle(), textAlign: TextAlign.start,)),
          heightSizedBox(5),
          buildSmartAuditEventList(),
        ],
      ),
    );
  }

  TextStyle bottomSheetTitleStyle() => const TextStyle(fontSize: 17, color: Color(primaryColor), fontWeight: FontWeight.w600);

  BlocBuilder<SmartAuditGraphBloc, SmartAuditGraphState> buildSmartAuditGraph() {
    return BlocBuilder<SmartAuditGraphBloc, SmartAuditGraphState>(builder: (context, state) {
        if (state is LoadedSmartAuditGraphState) {
          List<TimeSeries>? pressureData = state.smartAuditEvent.channelData.pressure;
          List<TimeSeries>? flowData = state.smartAuditEvent.channelData.flow;
          final channel = state.smartAuditEvent.channel;
          final type = state.smartAuditEvent.event;
          graphTitle = "${state.smartAuditEvent.name} on Channel $channel";

          switch(type){
            case SmartAuditEventType.leak:
              break;
            case SmartAuditEventType.blockage:
              break;
            case SmartAuditEventType.highPressure:
              flowData = null;
              break;
            case SmartAuditEventType.lowPressure:
              flowData = null;
              break;
            case SmartAuditEventType.highFlow:
              pressureData = null;
              break;
            case SmartAuditEventType.lowFlow:
              pressureData = null;
              break;
          }

          return ScrollingGraphWidget(pressureData: pressureData, flowData: flowData, smartAuditEventType: type);
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
                            List<SmartAuditEvent> smartAuditEvents = state.smartAuditEvents;
                            final newSAEvent = smartAuditEvents[selectedSmartAuditEventIndex];

                            BlocProvider.of<SmartAuditGraphBloc>(context)
                                .add(ShowSmartAuditGraph(smartAuditEvent: newSAEvent));
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
    MaterialAccentColor eventSeverityColor = Colors.greenAccent;

    switch(smartAuditEvent.severity){
      case SmartAuditEventSeverity.high:
        eventSeverityColor = Colors.redAccent;
        break;
      case SmartAuditEventSeverity.medium:
        eventSeverityColor = Colors.amberAccent;
        break;
      case SmartAuditEventSeverity.low:
        eventSeverityColor = Colors.greenAccent;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      decoration: BoxDecoration(
        border: selectedSmartAuditEventIndex == position
            ? Border.all(color: const Color(lightPrimaryColor), width: 2) : null,
        borderRadius: BorderRadius.circular(10),
        color: const Color(lightGrey)
      ),
      child: Row(
        children: [
          Text("$eventType on Channel $channel at $startTime",
            style: selectedSmartAuditEventIndex == position
                ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                : const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          const Spacer(),
          Icon(Icons.circle, size: 18, color: eventSeverityColor)
        ],
      ),
    );
  }
}
