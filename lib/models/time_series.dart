import 'package:equatable/equatable.dart';

class TimeSeries extends Equatable {
  const TimeSeries({required this.time, required this.parameter});

  final DateTime time;
  final double parameter;

  @override
  List<Object?> get props => [];
}
