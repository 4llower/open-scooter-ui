import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/feature/domain/entities/scooter_entity.dart';

abstract class ScooterState extends Equatable {
  const ScooterState();

  @override
  List<Object> get props => [];
}

class ScooterEmpty extends ScooterState {
  @override
  List<Object> get props => [];
}

class ScooterLoading extends ScooterState {
  @override
  List<Object> get props => [];
}

class ScooterLoaded extends ScooterState {
  final List<ScooterEntity> scooterList;

  ScooterLoaded({required this.scooterList});

  @override
  List<Object> get props => [];
}
