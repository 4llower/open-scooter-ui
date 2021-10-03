import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class TopUpBalance extends UseCase<UserEntity, TopUpParams> {
  final UserRepo _userRepo;

  TopUpBalance(this._userRepo);

  Future<Either<Failure, UserEntity>> call(TopUpParams params) async {
    return _userRepo.topUp(params.card, params.balance, params.amount);
  }
}

class TopUpParams extends Equatable {
  final double amount;
  final BalanceEntity balance;
  final CreditCardEntity card;

  @override
  List<Object> get props => [];

  TopUpParams(
      {required this.card, required this.balance, required this.amount});
}
