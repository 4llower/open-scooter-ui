import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_scooter_ui/feature/data/models/ok_model.dart';
import 'package:open_scooter_ui/feature/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<OkModel> sendSMS(String phone);
  Future<UserModel> auth(String smsCode);
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
}
