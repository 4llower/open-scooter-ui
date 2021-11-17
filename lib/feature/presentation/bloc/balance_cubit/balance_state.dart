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

class BalanceTopUp extends BalanceLoaded {
  final int selectedPrice;
  final int selectedMethod;
  static List<int> paymentPrices = [5, 10, 20];
  BalanceTopUp(
      {required user,
      required this.selectedPrice,
      required this.selectedMethod})
      : super(user: user);
  List<int> getPaymentPrices() {
    return BalanceTopUp.paymentPrices;
  }

  @override
  List<Object> get props => [];
}
