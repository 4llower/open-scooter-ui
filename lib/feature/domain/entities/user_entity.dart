import 'package:open_scooter_ui/feature/domain/entities/balance_entity.dart';
import 'package:open_scooter_ui/feature/domain/entities/location_entity.dart';

class UserEntity {
  final String phone;
  final String token;
  final LocationEntity location;
  final BalanceEntity balance;

  UserEntity(
      {required this.phone,
      required this.location,
      required this.balance,
      required this.token});
}
