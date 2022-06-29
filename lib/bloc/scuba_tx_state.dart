part of 'scuba_tx_bloc.dart';

abstract class ScubaTxState extends Equatable {
  const ScubaTxState();
}

class Empty extends ScubaTxState {
  @override
  List<Object?> get props => [];
}

class Loading extends ScubaTxState {
  @override
  List<Object?> get props => [];
}

class Loaded extends ScubaTxState {
  final List<ScubaBox> scubaBoxes;

  const Loaded(this.scubaBoxes);

  @override
  List<Object?> get props => [];
}

class Error extends ScubaTxState {
  final String message;

  const Error({required this.message});

  @override
  List<Object?> get props => [];
}
