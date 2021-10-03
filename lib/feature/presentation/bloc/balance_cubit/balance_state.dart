import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';

abstract class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object> get props => [];
}

class BalanceEmpty extends BalanceState {
  @override
  List<Object> get props => [];
}

class BalanceLoading extends BalanceState {
  @override
  List<Object> get props => [];
}

class BalanceLoaded extends BalanceState {
  final UserEntity user;

  BalanceLoaded({required this.user});

  @override
  List<Object> get props => [];
}
