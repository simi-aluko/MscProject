import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msc_project/models/organ.dart';
import 'package:msc_project/models/scuba_box.dart';
import 'package:msc_project/scuba_tx_usecase.dart';

part 'scuba_tx_event.dart';
part 'scuba_tx_state.dart';

class ScubaTxBloc extends Bloc<ScubaTxEvent, ScubaTxState> {
  final ScubaTxBoxUseCase scubaTxBoxUseCase;

  ScubaTxBloc({
    required this.scubaTxBoxUseCase,
  }) : super(Empty()) {
    on<ScubaTxEvent>(scubaTxStateEmitter);
  }

  scubaTxStateEmitter(ScubaTxEvent event, Emitter<ScubaTxState> emitter) async {
    if (event is GetAllOrgans) {
    } else if (event is GetOrgan) {
    } else if (event is GetOrgansByType) {}
  }
}
