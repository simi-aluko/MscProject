import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/time_series.dart';

class GraphWidget extends StatefulWidget {
  final List<TimeSeries> pressureData;
  final List<TimeSeries> flowData;
  List<TimeSeries> pressureGraphData = <TimeSeries>[];
  List<TimeSeries> flowGraphData = <TimeSeries>[];
  final int channel;

  GraphWidget({super.key, required this.pressureData, required this.flowData, required this.channel}) {
    pressureGraphData = pressureData.take(20).toList();
    flowGraphData = flowData.take(20).toList();
  }

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> with AutomaticKeepAliveClientMixin<GraphWidget> {
  ChartSeriesController? pressureSeriesController;
  ChartSeriesController? flowSeriesController;
  Timer? timer;
  int startIndex = 0;
  int endIndex = 19;

  @override
  Widget build(BuildContext context) {
    return buildSfCartesianChart();
  }

  @override
  bool get wantKeepAlive => true;

  SfCartesianChart buildSfCartesianChart() {
    return SfCartesianChart(
        enableAxisAnimation: true,
        backgroundColor: Colors.white,
        legend: Legend(isVisible: true, position: LegendPosition.top),
        zoomPanBehavior: buildZoomPanBehavior(),
        primaryXAxis: buildDateTimeAxis(),
        primaryYAxis: buildNumericAxis(),
        series: <ChartSeries<TimeSeries, DateTime>>[
          LineSeries<TimeSeries, DateTime>(
              dataSource: widget.flowGraphData,
              xValueMapper: (TimeSeries sales, _) => sales.time,
              yValueMapper: (TimeSeries sales, _) => sales.parameter,
              name: 'Flow',
              onRendererCreated: (ChartSeriesController controller) {
                flowSeriesController = controller;
              },
              animationDuration: 1000),
          LineSeries<TimeSeries, DateTime>(
              dataSource: widget.pressureGraphData,
              xValueMapper: (TimeSeries sales, _) => sales.time,
              yValueMapper: (TimeSeries sales, _) => sales.parameter,
              name: 'Pressure',
              onRendererCreated: (ChartSeriesController controller) {
                pressureSeriesController = controller;
              },
              animationDuration: 1000),
        ]);
  }

  ZoomPanBehavior buildZoomPanBehavior() {
    return ZoomPanBehavior(enablePinching: true, enablePanning: true, enableSelectionZooming: true);
  }

  NumericAxis buildNumericAxis() {
    return NumericAxis(
        decimalPlaces: 1,
        title: AxisTitle(
            text: "Flow and Pressure",
            textStyle:
                const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 12)));
  }

  DateTimeAxis buildDateTimeAxis() {
    return DateTimeAxis(
        title: AxisTitle(
            text: "Time (Hour:min:sec)",
            textStyle:
                const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 12)),
        majorGridLines: const MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        intervalType: DateTimeIntervalType.seconds,
        axisLabelFormatter: (AxisLabelRenderDetails args) {
          late String text;
          text =
              '${DateTime.fromMillisecondsSinceEpoch(args.value.toInt()).hour}:${DateTime.fromMillisecondsSinceEpoch(args.value.toInt()).minute}:${DateTime.fromMillisecondsSinceEpoch(args.value.toInt()).second}';
          return ChartAxisLabel(text, args.textStyle);
        });
  }

  void _updateDataSource(Timer timer) {
    startIndex += 1;
    endIndex += 1;
    widget.flowGraphData.add(widget.flowData[endIndex]);
    if (widget.flowGraphData.length == 21) {
      widget.flowGraphData.removeAt(0);
      flowSeriesController!.updateDataSource(
        addedDataIndexes: <int>[widget.flowGraphData.length - 1],
        removedDataIndexes: <int>[0],
      );
    }

    widget.pressureGraphData.add(widget.pressureData[endIndex]);
    if (widget.pressureGraphData.length == 21) {
      widget.pressureGraphData.removeAt(0);
      pressureSeriesController!.updateDataSource(
        addedDataIndexes: <int>[widget.pressureGraphData.length - 1],
        removedDataIndexes: <int>[0],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {timer = Timer.periodic(const Duration(milliseconds: 500), _updateDataSource)});
  }
}
