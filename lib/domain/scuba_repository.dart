import '../data/models/organ.dart';
import '../data/models/scuba_box.dart';
import '../data/models/smart_audit_event.dart';
import '../data/models/time_series.dart';

abstract class ScubaRepository {
  List<ScubaBox> getAllScubaBoxes();
  List<ScubaBox> getScubaBoxByOrgan(OrganType organType);
  ScubaBox getScubaBoxById(String id);
  ChannelData getChannel1Data();
  ChannelData getChannel2Data();
  ChannelData getChannel3Data();
  List<SmartAuditEvent> getSmartAuditEvents();
}