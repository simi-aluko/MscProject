import 'package:intl/intl.dart';
import 'package:msc_project/data/data_sources/data_source.dart';
import 'package:msc_project/data/models/organ.dart';
import 'package:msc_project/data/models/scuba_box.dart';
import 'package:msc_project/data/models/smart_audit_event.dart';
import 'package:msc_project/data/models/time_series.dart';

import '../../core/strings.dart';

class CSVDataSource extends ScubaDataSource {
  final List<List<dynamic>> csvAsList;
  late ChannelData channelData1;
  late ChannelData channelData2;
  late ChannelData channelData3;
  late List<ScubaBox> defaultScubaBoxes;

  CSVDataSource({required this.csvAsList}){
    channelData1 = getChannel1Data();
    channelData2 = getChannel2Data();
    channelData3 = getChannel3Data();
    defaultScubaBoxes = [
      ScubaBox(channelData1, channelData2, channelData3,
          id: "ID1", temperature: "5º", gas: "40%", battery: "80%", organ: OrganType.liver),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "ID2", temperature: "2º", gas: "40%", battery: "90%", organ: OrganType.liver),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "ID3", temperature: "3º", gas: "100%", battery: "50%", organ: OrganType.pancreas),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "ID4", temperature: "4º", gas: "40%", battery: "50%", organ: OrganType.pancreas),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "ID5", temperature: "5º", gas: "100%", battery: "10%", organ: OrganType.heart),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "ID6", temperature: "2º", gas: "100%", battery: "30%", organ: OrganType.heart),
    ];
  }

  @override
  List<ScubaBox> getAllScubaBoxes() => defaultScubaBoxes;

  @override
  ChannelData getChannel1Data() => _getChannelData(pressureCol: 7, flowCol: 6);

  @override
  ChannelData getChannel2Data() => _getChannelData(pressureCol: 14, flowCol: 13);

  @override
  ChannelData getChannel3Data() => _getChannelData(pressureCol: 21, flowCol: 20);

  @override
  ScubaBox getScubaBoxById(String id) => defaultScubaBoxes.where((element) => element.id == id).toList()[0];


  @override
  List<ScubaBox> getScubaBoxByOrgan(OrganType organType) => defaultScubaBoxes.where((element) => element.organ == organType).toList();

  @override
  List<SmartAuditEvent> getSmartAuditEvents() {
    List<SmartAuditEvent> events = [
      SmartAuditEvent(event: SmartAuditEventType.leak, channelData: getChannel1Data(), channel: 1, name: stringLeak),
      SmartAuditEvent(event: SmartAuditEventType.blockage, channelData: getChannel2Data(), channel: 2, name: stringBlockage),
      SmartAuditEvent(event: SmartAuditEventType.highFlow, channelData: getChannel3Data(), channel: 3, name: stringHighFlow),
      SmartAuditEvent(event: SmartAuditEventType.highPressure, channelData: getChannel2Data(), channel: 2, name: stringHighPressure),
      SmartAuditEvent(event: SmartAuditEventType.lowPressure, channelData: getChannel1Data(), channel: 1, name: stringLowPressure),
    ];

    return events;
  }

  ChannelData _getChannelData({required int pressureCol, required int flowCol}) {
    List<TimeSeries> pressure = <TimeSeries>[];
    List<TimeSeries> flow = <TimeSeries>[];
    Set<String> dateTimeSet = {};

    for (int i = 0; i < csvAsList.length; i++) {
      if (i == 0) continue;

      String dateString = csvAsList[i][1];
      bool isAdded = dateTimeSet.add(dateString);
      DateTime dateTime = DateFormat('dd/MM/yyyy H:m:s').parse(dateString);

      if(isAdded){
        flow.add(TimeSeries(time: dateTime, parameter: csvAsList[i][flowCol]));
        pressure.add(TimeSeries(time: dateTime, parameter: csvAsList[i][pressureCol]));
      }
    }

    print("Flow Size : ${flow.length}, Pressure Size: ${pressure.length}");

    return ChannelData(pressure: pressure, flow: flow);
  }
}