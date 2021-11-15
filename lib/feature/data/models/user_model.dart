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
    // TODO: when serializing models should have links to models, not entities
    var locationModel =
        LocationModel(lat: this.location.lat, lng: this.location.lng);
    var balanceModel = BalanceModel(
        amount: this.balance.amount,
        unit: this.balance.unit,
        cards: this.balance.cards);
    return {
      'phone': this.phone,
      'token': this.token,
      'location': locationModel.toJson(),
      'balance': balanceModel.toJson()
    };
  }
}
