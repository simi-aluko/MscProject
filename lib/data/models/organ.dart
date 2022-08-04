import 'package:equatable/equatable.dart';

class Organ extends Equatable {
  final String id;
  final OrganType organType;

  const Organ({
    required this.id,
    required this.organType,
  });

  @override
  List<Object?> get props => [];
}

enum OrganType {
  liver,
  pancreas,
  heart,
}
