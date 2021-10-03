import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_scooter_ui/feature/data/models/ok_model.dart';
import 'package:open_scooter_ui/feature/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<OkModel> sendSMS(String phone);
  Future<UserModel> auth(String smsCode);
  Future<UserModel> getUser(String phone);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  Future<OkModel> sendSMS(String phone) {
    return Future.delayed(const Duration(seconds: 1), () => OkModel());
  }

  Future<UserModel> auth(String smsCode) {
    return Future.delayed(const Duration(seconds: 1), () {
      return UserModel.fromJson(jsonDecode(
          '{"phone":"228","token":"token","location":{"lat":59,"lng":69},"balance":{"amount":99,"unit":"USD","cards":[{"id":"88005553535","type":"urmum"}]}}'));
    });
  }

  @override
  Future<UserModel> getUser(String phone) async {
    const mock =
        '{"228": {"phone": "228","token": "token","location": {"lat": 59,"lng": 69},"balance": {"amount": 99,"unit": "USD","cards": [{"id": "88005553535","type": "urmum"}]}},"327": {"phone": "327","token": "urmum","location": {"lat": 19,"lng": 19},"balance": {"amount": 10,"unit": "EUR","cards": [{"id": "297800255","type": "maestro"}]}}}';

    var response = await Future.delayed(const Duration(seconds: 1), () => mock);

    final user = json.decode(response)[phone];

    return UserModel.fromJson(user);
  }
}
