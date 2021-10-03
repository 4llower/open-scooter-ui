import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/status/ok.dart';
import 'package:open_scooter_ui/feature/data/datasources/user_remote_data_source.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/location_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource userRemoteDataSource;
  bool mockUserToggle = true;
  UserEntity mockUser = UserEntity(
      phone: "228",
      location: LocationEntity(lat: 34, lng: 26),
      balance: BalanceEntity(
          amount: 99,
          cards: [
            CreditCardEntity(type: "visa", id: "88005553535"),
            CreditCardEntity(type: "master", id: "9900")
          ],
          unit: "USD"),
      token: "token");

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
      CreditCardEntity card, BalanceEntity balance, double value) async {
    // TODO: implement web view for top up
    mockUser = UserEntity(
        phone: mockUser.phone,
        location: mockUser.location,
        balance: BalanceEntity(
            amount: mockUser.balance.amount + value,
            unit: mockUser.balance.unit,
            cards: mockUser.balance.cards),
        token: mockUser.token);
    return Right(mockUser);
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String token) async {
    if (mockUserToggle) {
      var user = await userRemoteDataSource.getUser(token);
      mockUser = UserEntity(
          phone: user.phone,
          location: user.location,
          balance: user.balance,
          token: user.token);
      mockUserToggle = false;
    }
    return Right(mockUser);
  }
}
