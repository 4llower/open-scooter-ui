import 'package:equatable/equatable.dart';

import 'cost_entity.dart';
import 'location_entity.dart';

class ScooterEntity extends Equatable {
  final int id;
  final LocationEntity location;
  final int chargeLevel;
  final CostEntity cost;

  ScooterEntity(
      {required this.id,
      required this.location,
      required this.chargeLevel,
      required this.cost});

  @override
  List<Object?> get props => [id];
}
