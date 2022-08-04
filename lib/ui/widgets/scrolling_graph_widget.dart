import 'dart:core';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/smart_audit_event.dart';
import '../../data/models/time_series.dart';

class ScrollingGraphWidget extends StatelessWidget {
  List<TimeSeries> pressureData = [];
  List<TimeSeries> flowData = [];
  final SmartAuditEventType smartAuditEventType;
  bool showPressure = false;
  bool showFlow = false;

  ScrollingGraphWidget({super.key, required pressureData, required flowData, required this.smartAuditEventType}){
    if(pressureData != null) {
      this.pressureData = pressureData;
    }

    if(flowData != null) {
      this.flowData = flowData;
    }

    switch(smartAuditEventType){
      case SmartAuditEventType.leak:
        setUpGraph(true, true);
        break;
      case SmartAuditEventType.blockage:
        setUpGraph(true, true);
        break;
      case SmartAuditEventType.highPressure:
        setUpGraph(false, true);
        break;
      case SmartAuditEventType.lowPressure:
        setUpGraph(false, true);
        break;
      case SmartAuditEventType.highFlow:
        setUpGraph(true, false);
        break;
      case SmartAuditEventType.lowFlow:
        setUpGraph(true, false);
        break;
    }
  }

  void setUpGraph(bool showFlow, bool showPressure){
    this.showFlow = showFlow;
    this.showPressure = showPressure;
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: SfCartesianChart(
        enableAxisAnimation: true,
        primaryXAxis: buildDateTimeAxis(),
        primaryYAxis: buildPressureNumericAxis(),
        legend: Legend(isVisible: true, position: LegendPosition.top),
        axes: <ChartAxis>[
          buildFlowNumericAxis()
        ],
        zoomPanBehavior: buildZoomPanBehavior(),
        series: <CartesianSeries<TimeSeries, DateTime>>[
          LineSeries(
            dataSource: showPressure ? pressureData : [],
            xValueMapper: (TimeSeries timeSeries, _) => timeSeries.time,
            yValueMapper: (TimeSeries timeSeries, _) => timeSeries.parameter,
            name: 'Pressure',
            yAxisName: "yAxisPressure",
          ),
          LineSeries(
            dataSource: showFlow ? flowData : [],
            xValueMapper: (TimeSeries timeSeries, _) => timeSeries.time,
            yValueMapper: (TimeSeries timeSeries, _) => timeSeries.parameter,
            name: 'Flow',
            yAxisName: "yAxisFlow",)
        ],
      ),
    );
  }

  ZoomPanBehavior buildZoomPanBehavior() {
    return ZoomPanBehavior(enablePinching: true, enablePanning: true, enableSelectionZooming: true);
  }

  NumericAxis buildPressureNumericAxis() {
    return NumericAxis(
        name: "yAxisPressure",
        decimalPlaces: 1,
        anchorRangeToVisiblePoints: false,
        title: AxisTitle(
            text: "Pressure",
            textStyle:
            const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 12)));
  }

  NumericAxis buildFlowNumericAxis() {
    return NumericAxis(
        name: "yAxisFlow",
        decimalPlaces: 1,
        opposedPosition: true,
        anchorRangeToVisiblePoints: false,
        title: AxisTitle(
            text: "Flow",
            textStyle:
            const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 12)));
  }

  DateTimeAxis buildDateTimeAxis() {
    return DateTimeAxis(
        title: AxisTitle(
          text: "Time (Hour:min:sec)",
            textStyle: const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 12),
        ),
        intervalType: DateTimeIntervalType.seconds,
        visibleMinimum: showPressure ? pressureData[pressureData.length - 29].time : flowData[flowData.length - 29].time,
        visibleMaximum: showPressure ? pressureData[pressureData.length - 1].time : flowData[flowData.length - 1].time,
          axisLabelFormatter: (AxisLabelRenderDetails args) {
            late String text;
            text =
            '${DateTime.fromMillisecondsSinceEpoch(args.value.toInt()).hour}:${DateTime.fromMillisecondsSinceEpoch(args.value.toInt()).minute}:${DateTime.fromMillisecondsSinceEpoch(args.value.toInt()).second}';
            return ChartAxisLabel(text, args.textStyle);
          });
  }
}
