import 'package:equatable/equatable.dart';
import 'package:msc_project/models/time_series.dart';

import 'organ.dart';

class ScubaBox extends Equatable {
  final String id;
  final String temperature;
  final String gas;
  final String battery;
  final Organ organ;
  final List<TimeSeries> channel1;
  final List<TimeSeries> channel2;
  final List<TimeSeries> channel3;

  const ScubaBox({
    required this.id,
    required this.temperature,
    required this.gas,
    required this.battery,
    required this.organ,
    required this.channel1,
    required this.channel2,
    required this.channel3,
  });

  @override
  List<Object?> get props => [];
}
