import 'package:open_scooter_ui/feature/data/models/balance_model.dart';
import 'package:open_scooter_ui/feature/data/models/location_model.dart';
import 'package:open_scooter_ui/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required phone, required token, required location, required balance})
      : super(phone: phone, token: token, location: location, balance: balance);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        phone: json['phone'],
        token: json['token'],
        location: LocationModel.fromJson(json['location']),
        balance: BalanceModel.fromJson(json['balance']));
  }

  Map<String, dynamic> toJson() {
    return {'phone': this.phone, 'location': this.location, 'balance': balance};
  }
}
