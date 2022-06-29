import 'package:equatable/equatable.dart';
import 'package:msc_project/models/time_series.dart';

import 'organ.dart';

class ScubaBox extends Equatable {
  final String id;
  final String temperature;
  final String gas;
  final String battery;
  final OrganType organ;
  final ChannelData channel1;
  final ChannelData channel2;
  final ChannelData channel3;

  const ScubaBox(
    this.channel1,
    this.channel2,
    this.channel3, {
    required this.id,
    required this.temperature,
    required this.gas,
    required this.battery,
    required this.organ,
  });

  @override
  List<Object?> get props => [id, temperature, gas, temperature, battery, organ, channel1, channel2, channel3];
}

class TempScubaBox extends Equatable {
  final String id;
  final String temperature;
  final String gas;
  final String battery;
  final Organ organ;

  const TempScubaBox({
    required this.id,
    required this.temperature,
    required this.gas,
    required this.battery,
    required this.organ,
  });

  @override
  List<Object?> get props => [id, temperature, gas, temperature, battery, organ];
}
