import 'package:msc_project/data/models/organ.dart';
import 'package:msc_project/data/models/scuba_box.dart';
import 'package:msc_project/data/models/smart_audit_event.dart';
import 'package:msc_project/data/models/time_series.dart';
import 'package:msc_project/domain/scuba_repository.dart';

import '../data_sources/data_source.dart';

class ScubaRepositoryImpl extends ScubaRepository{
  ScubaDataSource scubaDataSource;

  ScubaRepositoryImpl({required this.scubaDataSource});

  @override
  List<ScubaBox> getAllScubaBoxes() => scubaDataSource.getAllScubaBoxes();

  @override
  ChannelData getChannel1Data() => scubaDataSource.getChannel1Data();

  @override
  ChannelData getChannel2Data() => scubaDataSource.getChannel2Data();

  @override
  ChannelData getChannel3Data() => scubaDataSource.getChannel3Data();

  @override
  ScubaBox getScubaBoxById(String id) => scubaDataSource.getScubaBoxById(id);

  @override
  List<ScubaBox> getScubaBoxByOrgan(OrganType organType) => scubaDataSource.getScubaBoxByOrgan(organType);

  @override
  List<SmartAuditEvent> getSmartAuditEvents() => scubaDataSource.getSmartAuditEvents();
}