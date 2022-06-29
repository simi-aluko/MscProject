import 'dart:collection';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:msc_project/models/organ.dart';
import 'package:msc_project/models/scuba_box.dart';
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
          id: "1", temperature: "30º", gas: "40%", battery: "80%", organ: OrganType.liver),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "2", temperature: "40º", gas: "100%", battery: "50%", organ: OrganType.kidney),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "3", temperature: "50º", gas: "40%", battery: "90%", organ: OrganType.liver),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "4", temperature: "60º", gas: "100%", battery: "10%", organ: OrganType.heart),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "5", temperature: "70º", gas: "100%", battery: "30%", organ: OrganType.heart),
      ScubaBox(channelData1, channelData2, channelData3,
          id: "6", temperature: "80º", gas: "40%", battery: "50%", organ: OrganType.kidney),
    ];
  }

  List<ScubaBox> getAllScubaBoxes() {
    return defaultScubaBoxes;
  }

  List<ScubaBox> getScubaBoxByOrgan(OrganType organType) {
    return defaultScubaBoxes.where((element) => element.organ == organType).toList();
  }

  ChannelData getChannel1Data() => _getChannelData(pressureCol: 6, flowCol: 7);
  ChannelData getChannel2Data() => _getChannelData(pressureCol: 13, flowCol: 14);
  ChannelData getChannel3Data() => _getChannelData(pressureCol: 20, flowCol: 21);

  ChannelData _getChannelData({required int pressureCol, required int flowCol}) {
    Queue<TimeSeries> pressure = Queue<TimeSeries>();
    Queue<TimeSeries> flow = Queue<TimeSeries>();

    for (int i = 0; i < csvAsList.length; i++) {
      if (i == 0) continue;

      String dateString = csvAsList[i][1];
      DateTime dateTime = DateFormat('dd/MM/yyyy H:m:s').parse(dateString);

      flow.add(TimeSeries(time: dateTime, parameter: csvAsList[i][flowCol]));
      pressure.add(TimeSeries(time: dateTime, parameter: csvAsList[i][pressureCol]));
    }

    return ChannelData(pressure: pressure, flow: flow);
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
