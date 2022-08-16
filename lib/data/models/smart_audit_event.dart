import 'package:equatable/equatable.dart';

import 'time_series.dart';

class SmartAuditEvent extends Equatable{

  final SmartAuditEventType event;
  final ChannelData channelData;
  final int channel;
  final String name;
  final SmartAuditEventSeverity severity;

  const SmartAuditEvent({required this.event, required this.channelData,required this.channel,
    required this.name, required this.severity});

  @override
  List<Object?> get props => [event, channelData, channel, name, severity];

}

enum SmartAuditEventType {
  leak, blockage, highPressure, lowPressure, highFlow, lowFlow
}

enum SmartAuditEventSeverity {
  high, medium, low
}

