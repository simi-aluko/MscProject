part of 'scuba_tx_bloc.dart';

// Organs List State
abstract class OrgansListState extends Equatable {
  const OrgansListState();
}

class EmptyOrgansList extends OrgansListState {
  @override
  List<Object?> get props => [];
}

class OrgansList extends OrgansListState {
  final List<ScubaBox> scubaBoxes;
  final String listType;

  const OrgansList({required this.scubaBoxes, required this.listType});

  @override
  List<Object?> get props => [scubaBoxes, listType];
}

// Current Organ State
abstract class CurrentOrganState extends Equatable {
  const CurrentOrganState();
}

class CurrentOrgan extends CurrentOrganState {
  final ScubaBox scubaBox;

  const CurrentOrgan({required this.scubaBox});

  @override
  List<Object?> get props => [scubaBox];
}

class EmptyCurrentOrgan extends CurrentOrganState {
  @override
  List<Object?> get props => [];
}

// Channel Controls State
abstract class ChannelControlsState extends Equatable {
  final int channel;

  const ChannelControlsState({required this.channel});
}

class CurrentChannel extends ChannelControlsState {
  const CurrentChannel({required super.channel});
  @override
  List<Object?> get props => [channel];
}

// SmartAuditEventGraph
abstract class SmartAuditGraphState extends Equatable {
  const SmartAuditGraphState();

  @override
  List<Object?> get props => [];
}

class EmptySmartAuditGraphState extends SmartAuditGraphState{}
class LoadedSmartAuditGraphState extends SmartAuditGraphState{
  final SmartAuditEvent smartAuditEvent;

  const LoadedSmartAuditGraphState({required this.smartAuditEvent});
}

// SmartAuditEventsList
abstract class SmartAuditEventListState extends Equatable {
  const SmartAuditEventListState();

  @override
  List<Object?> get props => [];
}

class EmptySmartAuditEventListState extends SmartAuditEventListState{}
class LoadedSmartAuditEventListState extends SmartAuditEventListState{
  final List<SmartAuditEvent> smartAuditEvents;

  const LoadedSmartAuditEventListState({required this.smartAuditEvents});
}

