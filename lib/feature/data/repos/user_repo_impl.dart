import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/status/ok.dart';
import 'package:open_scooter_ui/feature/data/datasources/user_remote_data_source.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepoImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> addCreditCard(
      String cardNumber, String expirationDate, String cvc, String cardHolder) {
    // TODO: implement addCreditCard
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> auth(String smsCode) {
    // TODO: implement auth
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> removeCreditCard(CreditCardEntity card) {
    // TODO: implement removeCreditCard
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, OkStatus>> sendSMS(String phone) {
    // TODO: implement sendSMS
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> topUp(
      CreditCardEntity card, BalanceEntity balance, int value) {
    // TODO: implement topUp
    throw UnimplementedError();
  }
}
