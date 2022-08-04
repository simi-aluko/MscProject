import 'package:equatable/equatable.dart';

import 'time_series.dart';

class SmartAuditEvent extends Equatable{

  final SmartAuditEventType event;
  final ChannelData channelData;
  final int channel;
  final String name;

  const SmartAuditEvent({required this.event, required this.channelData,required this.channel, required this.name});

  @override
  List<Object?> get props => [event, channelData, channel];

}

enum SmartAuditEventType {
  leak, blockage, highPressure, lowPressure, highFlow, lowFlow
}

