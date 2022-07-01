part of 'scuba_tx_bloc.dart';

abstract class ScubaTxEvent extends Equatable {
  const ScubaTxEvent();

  @override
  List<Object?> get props => [];
}

class GetAllOrgans extends ScubaTxEvent {}

class GetOrgansByType extends ScubaTxEvent {
  final OrganType organType;

  const GetOrgansByType(this.organType);
}

class GetOrgan extends ScubaTxEvent {
  final String organId;

  const GetOrgan(this.organId);
}

class CurrentChannel extends ScubaTxEvent {
  final int channel;

  const CurrentChannel(this.channel);
}
