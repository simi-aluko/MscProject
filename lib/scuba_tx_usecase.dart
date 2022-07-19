import 'dart:collection';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:msc_project/models/organ.dart';
import 'package:msc_project/models/scuba_box.dart';
import 'package:msc_project/models/smart_audit_event.dart';
import 'package:msc_project/models/time_series.dart';

class ScubaTxBoxUseCase {
  final List<List<dynamic>> csvAsList;
  late ChannelData channelData1;
  late ChannelData channelData2;
  late ChannelData channelData3;
  late List<ScubaBox> defaultScubaBoxes;

  ScubaTxBoxUseCase(this.csvAsList) {
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

  List<ScubaBox> getAllScubaBoxes() {
    return defaultScubaBoxes;
  }

  List<ScubaBox> getScubaBoxByOrgan(OrganType organType) {
    return defaultScubaBoxes.where((element) => element.organ == organType).toList();
  }

  ScubaBox getScubaBoxById(String id) {
    return defaultScubaBoxes.where((element) => element.id == id).toList()[0];
  }

  ChannelData getChannel1Data() => _getChannelData(pressureCol: 7, flowCol: 6);
  ChannelData getChannel2Data() => _getChannelData(pressureCol: 14, flowCol: 13);
  ChannelData getChannel3Data() => _getChannelData(pressureCol: 21, flowCol: 20);

  ChannelData _getChannelData({required int pressureCol, required int flowCol}) {
    List<TimeSeries> pressure = <TimeSeries>[];
    List<TimeSeries> flow = <TimeSeries>[];

    for (int i = 0; i < csvAsList.length; i++) {
      if (i == 0) continue;

      String dateString = csvAsList[i][1];
      DateTime dateTime = DateFormat('dd/MM/yyyy H:m:s').parse(dateString);

      flow.add(TimeSeries(time: dateTime, parameter: csvAsList[i][flowCol]));
      pressure.add(TimeSeries(time: dateTime, parameter: csvAsList[i][pressureCol]));
    }

    return ChannelData(pressure: pressure, flow: flow);
  }
  
  List<SmartAuditEvent> getSmartAuditEvents(){
   List<SmartAuditEvent> events = [
     SmartAuditEvent(event: SmartAuditEventType.leak, channelData: getChannel1Data(), channel: 1, name: leak),
     SmartAuditEvent(event: SmartAuditEventType.blockage, channelData: getChannel2Data(), channel: 2, name: blockage),
     SmartAuditEvent(event: SmartAuditEventType.highFlow, channelData: getChannel3Data(), channel: 3, name: highFlow),
     SmartAuditEvent(event: SmartAuditEventType.highPressure, channelData: getChannel2Data(), channel: 2, name: highPressure),
     SmartAuditEvent(event: SmartAuditEventType.lowPressure, channelData: getChannel1Data(), channel: 1, name: lowPressure),
   ];

   return events;
  }
}

class ReadCSV {
  final CsvToListConverter csvToListConverter;

  ReadCSV({required this.csvToListConverter});

  Future<List<List>> readCSV() async {
    final myData = await rootBundle.loadString('assets/files/test_data.csv');
    return csvToListConverter.convert(myData);
  }
}


