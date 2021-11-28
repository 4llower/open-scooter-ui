import 'package:dartz/dartz.dart';
import 'package:open_scooter_ui/core/error/exception.dart';
import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/core/status/ok.dart';
import 'package:open_scooter_ui/feature/data/datasources/user_local_data_source.dart';
import 'package:open_scooter_ui/feature/data/datasources/user_remote_data_source.dart';
import 'package:open_scooter_ui/feature/data/models/user_model.dart';
import 'package:open_scooter_ui/feature/domain/entities/credit_card_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/location_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';
import 'package:open_scooter_ui/feature/domain/repos/user_repo.dart';

class UserRemoteRepoImpl implements UserRemoteRepo {
  final UserRemoteDataSource userRemoteDataSource;
  //TODO: get rid of mock user
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

  UserRemoteRepoImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> addCreditCard(String cardNumber,
      String expirationDate, String cvc, String cardHolder) async {
    var cardNum = mockUser.balance.cards.length;
    mockUser.balance.cards.add(
        CreditCardEntity(type: "nice card #${cardNum + 1}", id: cardNumber));
    //TODO: delete waiting
    await Future.delayed(const Duration(seconds: 1));
    return Right(mockUser);
  }

  @override
  Future<Either<Failure, UserEntity>> auth(String smsCode) async {
    return Right(await this.userRemoteDataSource.auth(smsCode));
  }

  @override
  Future<Either<Failure, UserEntity>> removeCreditCard(
      CreditCardEntity card) async {
    mockUser.balance.cards.remove(card);
    return Right(mockUser);
  }

  @override
  Future<Either<Failure, OkStatus>> sendSMS(String phone) async {
    return Right(await this.userRemoteDataSource.sendSMS(phone));
  }

  @override
  Future<Either<Failure, UserEntity>> topUp(
      UserEntity user, CreditCardEntity card, double value) async {
    //TODO: delete waiting
    await Future.delayed(const Duration(seconds: 2));
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

class UserLocalRepoImpl implements UserLocalRepo {
  final UserLocalDataSource userLocalDataSource;

  UserLocalRepoImpl({required this.userLocalDataSource});
  //TODO: get rid of mock user
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

  @override
  Future<Either<Failure, UserEntity>> getUserCached() async {
    // await saveUserInCache(mockUser);
    try {
      var cachedUser = await userLocalDataSource.getUserFromCache();
      var user = UserEntity(
          phone: cachedUser.phone,
          location: cachedUser.location,
          balance: cachedUser.balance,
          token: cachedUser.token);
      return Right(user);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserInCache(UserEntity user) async {
    await userLocalDataSource.userToCache(UserModel(
        phone: user.phone,
        token: user.token,
        location: user.location,
        balance: user.balance));
    return Right(0);
  }

  @override
  Future<Either<Failure, String>> getTokenCached() async {
    try {
      var token = await userLocalDataSource.getTokenFromCache();
      return Right(token);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
