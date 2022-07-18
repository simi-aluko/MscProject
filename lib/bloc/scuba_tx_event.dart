part of 'scuba_tx_bloc.dart';

// Organs List Event
abstract class OrgansListEvent extends Equatable {
  const OrgansListEvent();

  @override
  List<Object?> get props => [];
}

class GetAllOrgansEvent extends OrgansListEvent {}

class GetOrgansByTypeEvent extends OrgansListEvent {
  final OrganType organType;

  const GetOrgansByTypeEvent(this.organType);
}

// Current Organ Event
abstract class CurrentOrganEvent extends Equatable {
  const CurrentOrganEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentOrganEvent extends CurrentOrganEvent {
  final String organId;

  const GetCurrentOrganEvent(this.organId);
}

// Channel Controls Event
class PrevChannelEvent extends ChannelControlsEvent {}

class NextChannelEvent extends ChannelControlsEvent {}

abstract class ChannelControlsEvent extends Equatable {
  const ChannelControlsEvent();

  @override
  List<Object?> get props => [];
}

// Smart Audit Event Graph
abstract class SmartAuditGraphBlocEvent extends Equatable {
  const SmartAuditGraphBlocEvent();

  @override
  List<Object?> get props => [];
}

class ShowSmartAuditGraph extends SmartAuditGraphBlocEvent{
  final SmartAuditEvent smartAuditEvent;

  const ShowSmartAuditGraph({required this.smartAuditEvent});
}

// Smart Audit Events List
abstract class SmartAuditEventsBlocEvent extends Equatable {
  const SmartAuditEventsBlocEvent();

  @override
  List<Object?> get props => [];
}

class ShowSmartAuditEventList extends SmartAuditEventsBlocEvent{}