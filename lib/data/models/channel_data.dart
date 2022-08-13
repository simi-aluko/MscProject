import 'package:equatable/equatable.dart';
import 'package:msc_project/data/models/time_series.dart';

class ChannelData extends Equatable {
  final List<TimeSeries> pressure;
  final List<TimeSeries> flow;

  const ChannelData({required this.pressure, required this.flow});

  @override
  List<Object?> get props => [pressure, flow];
}