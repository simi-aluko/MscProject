

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msc_project/domain/scuba_repository.dart';

import '../../core/strings.dart';
import '../../data/models/organ.dart';
import '../../data/models/scuba_box.dart';
import '../../data/models/smart_audit_event.dart';

part 'scuba_tx_event.dart';
part 'scuba_tx_state.dart';

class OrgansListBloc extends Bloc<OrgansListEvent, OrgansListState> {
  final ScubaRepository scubaRepository;

  OrgansListBloc({
    required this.scubaRepository,
  }) : super(EmptyOrgansList()) {
    on<OrgansListEvent>(organsListEmitter);
  }

  organsListEmitter(OrgansListEvent event, Emitter<OrgansListState> emitter) async {
    if (event is GetAllOrgansEvent) {
      List<ScubaBox> scubaBoxes = scubaRepository.getAllScubaBoxes();
      emit(OrgansList(scubaBoxes: scubaBoxes, listType: stringAllOrgans));
    } else if (event is GetOrgansByTypeEvent) {
      List<ScubaBox> scubaBoxes = scubaRepository.getScubaBoxByOrgan(event.organType);
      emit(OrgansList(scubaBoxes: scubaBoxes, listType: event.organType.name));
    }
  }
}

class CurrentOrganBloc extends Bloc<CurrentOrganEvent, CurrentOrganState> {
  final ScubaRepository scubaRepository;

  CurrentOrganBloc({required this.scubaRepository}) : super(EmptyCurrentOrgan()) {
    on<CurrentOrganEvent>(currentOrganEmitter);
  }

  currentOrganEmitter(CurrentOrganEvent event, Emitter<CurrentOrganState> emitter) async {
    if (event is GetCurrentOrganEvent) {
      ScubaBox scubaBox = scubaRepository.getScubaBoxById(event.organId);
      emit(CurrentOrgan(scubaBox: scubaBox));
    }
  }
}

class CurrentChannelBloc extends Bloc<ChannelControlsEvent, ChannelControlsState> {
  CurrentChannelBloc() : super(const CurrentChannel(channel: 1)) {
    on<ChannelControlsEvent>(channelControlEmitter);
  }

  channelControlEmitter(ChannelControlsEvent event, Emitter<ChannelControlsState> emitter) async {
    if (event is PrevChannelEvent) {
      if (state.channel > 1) {
        emit(CurrentChannel(channel: state.channel - 1));
      }
    } else if (event is NextChannelEvent) {
      if (state.channel < 3) {
        emit(CurrentChannel(channel: state.channel + 1));
      }
    }
  }
}

class SmartAuditGraphBloc extends Bloc<SmartAuditGraphBlocEvent, SmartAuditGraphState>{

  SmartAuditGraphBloc() : super(EmptySmartAuditGraphState()){
   on<ShowSmartAuditGraph>(_onShowSmartAuditGraph);
  }

  _onShowSmartAuditGraph(ShowSmartAuditGraph event, Emitter<SmartAuditGraphState> state) async {
    emit(LoadedSmartAuditGraphState(smartAuditEvent: event.smartAuditEvent));
  }
}

class SmartAuditEventListBloc extends Bloc<SmartAuditEventsBlocEvent, SmartAuditEventListState>{
  final ScubaRepository scubaRepository;

  SmartAuditEventListBloc({required this.scubaRepository}): super(EmptySmartAuditEventListState()){
    on<ShowSmartAuditEventList>(_onShowSmartAuditEvents);
  }

  _onShowSmartAuditEvents(ShowSmartAuditEventList event, Emitter<SmartAuditEventListState> state){

    List<SmartAuditEvent> smartAuditEvents = scubaRepository.getSmartAuditEvents();
    emit(LoadedSmartAuditEventListState(smartAuditEvents: smartAuditEvents));
  }
}
