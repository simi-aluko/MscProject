import 'package:equatable/equatable.dart';

class Organ extends Equatable {
  final String name;
  final String id;
  final String icon;

  const Organ({
    required this.name,
    required this.id,
    required this.icon,
  });

  @override
  List<Object?> get props => [];
}
