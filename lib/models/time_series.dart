import 'dart:collection';

import 'package:equatable/equatable.dart';

class TimeSeries extends Equatable {
  const TimeSeries({required this.time, required this.parameter});

  final DateTime time;
  final double parameter;

  @override
  List<Object?> get props => [time, parameter];
}

class ChannelData extends Equatable {
  final List<TimeSeries> pressure;
  final List<TimeSeries> flow;

  const ChannelData({required this.pressure, required this.flow});

  @override
  List<Object?> get props => [pressure, flow];
}
