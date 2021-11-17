import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/status/ok.dart';
import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';

abstract class UserRemoteRepo {
  Future<Either<Failure, OkStatus>> sendSMS(String phone);
  Future<Either<Failure, UserEntity>> auth(String smsCode);
  Future<Either<Failure, UserEntity>> addCreditCard(
      String cardNumber, String expirationDate, String cvc, String cardHolder);
  Future<Either<Failure, UserEntity>> removeCreditCard(CreditCardEntity card);
  Future<Either<Failure, UserEntity>> topUp(
      UserEntity user, CreditCardEntity card, double value);
  Future<Either<Failure, UserEntity>> getUser(String token);
}

abstract class UserLocalRepo {
  Future<Either<Failure, UserEntity>> getUserCached();
  Future<Either<Failure, void>> saveUserInCache(UserEntity user);
}
