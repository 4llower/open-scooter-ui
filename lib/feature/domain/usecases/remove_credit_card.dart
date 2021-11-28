import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/usecases/usecase.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class RemoveCreditCard extends UseCase<UserEntity, RemoveCreditCardParams> {
  final UserRemoteRepo _userRemo;

  RemoveCreditCard(this._userRemo);

  Future<Either<Failure, UserEntity>> call(
      RemoveCreditCardParams params) async {
    return await _userRemo.removeCreditCard(params.creditCard);
  }
}

class RemoveCreditCardParams {
  final creditCard;

  RemoveCreditCardParams({this.creditCard});

  @override
  List<Object> get props => [this.creditCard];
}
