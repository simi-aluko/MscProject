import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/scuba_box.dart';
import '../models/time_series.dart';

class GraphWidget extends StatefulWidget {
  final List<TimeSeries> pressureData;
  final List<TimeSeries> flowData;
  List<TimeSeries> pressureGraphData = <TimeSeries>[];
  List<TimeSeries> flowGraphData = <TimeSeries>[];
  final int channel;
  bool isContinuous;

  GraphWidget({super.key, required this.pressureData, required this.flowData, required this.channel, this.isContinuous = true}) {
    pressureGraphData = isContinuous ? pressureData.take(20).toList(): pressureData;
    flowGraphData = isContinuous ? flowData.take(20).toList(): flowData;
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
        primaryYAxis: buildPressureNumericAxis(),
        axes: <ChartAxis>[
          buildFlowNumericAxis()
        ],
        series: <ChartSeries<TimeSeries, DateTime>>[
          LineSeries<TimeSeries, DateTime>(
              dataSource: widget.pressureGraphData,
              xValueMapper: (TimeSeries sales, _) => sales.time,
              yValueMapper: (TimeSeries sales, _) => sales.parameter,
              name: 'Pressure',
              onRendererCreated: (ChartSeriesController controller) {
                if(widget.isContinuous){
                  pressureSeriesController = controller;
                }
              },
              animationDuration: 1000,
              yAxisName: "yAxisPressure"),
          LineSeries<TimeSeries, DateTime>(
              dataSource: widget.flowGraphData,
              xValueMapper: (TimeSeries sales, _) => sales.time,
              yValueMapper: (TimeSeries sales, _) => sales.parameter,
              name: 'Flow',
              onRendererCreated: (ChartSeriesController controller) {
                if(widget.isContinuous){
                  flowSeriesController = controller;
                }
              },
              animationDuration: 1000,
              yAxisName: "yAxisFlow"),

        ]);
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
            textStyle: const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 12)),
        majorGridLines: const MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        intervalType: DateTimeIntervalType.seconds,
        visibleMinimum: widget.isContinuous ? null : widget.flowGraphData[20].time,
        visibleMaximum: widget.isContinuous ? null : widget.flowGraphData[widget.flowGraphData.length-1].time,
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
        .addPostFrameCallback((_) => {timer = Timer.periodic(const Duration(milliseconds: 1000), _updateDataSource)});
  }
}

class GraphPagerWidget extends StatelessWidget {
  const GraphPagerWidget({
    Key? key,
    required this.controller,
    required this.context,
    required this.scubaBox,
  }) : super(key: key);

  final PageController controller;
  final BuildContext context;
  final ScubaBox scubaBox;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: PageView(
        controller: controller,
        children: [
          GraphWidget(
            pressureData: scubaBox.channel1.pressure,
            flowData: scubaBox.channel1.flow,
            channel: 1,
          ),
          GraphWidget(
            pressureData: scubaBox.channel2.pressure,
            flowData: scubaBox.channel2.flow,
            channel: 2,
          ),
          GraphWidget(
            pressureData: scubaBox.channel3.pressure,
            flowData: scubaBox.channel3.flow,
            channel: 3,
          ),
        ],
      ),
    );
  }
}
