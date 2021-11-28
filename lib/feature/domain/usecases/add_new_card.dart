import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class AddNewCard extends UseCase<UserEntity, AddNewCardParams> {
  final UserRemoteRepo _userRepo;

  AddNewCard(this._userRepo);

  Future<Either<Failure, UserEntity>> call(AddNewCardParams params) async {
    return await _userRepo.addCreditCard(params.cardNumber, params.expiryDate,
        params.cvvCode, params.cardHolderName);
  }
}

class AddNewCardParams {
  final cardNumber;
  final expiryDate;
  final cardHolderName;
  final cvvCode;

  AddNewCardParams(
      {this.cardNumber, this.expiryDate, this.cardHolderName, this.cvvCode});

  @override
  List<Object> get props =>
      [this.cardNumber, this.expiryDate, this.cardHolderName, this.cvvCode];
}
