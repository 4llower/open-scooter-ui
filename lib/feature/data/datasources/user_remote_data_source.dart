import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_scooter_ui/feature/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String phone);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser(String phone) async {
    const mock =
        '{"228": {"phone": "228","token": "token","location": {"lat": 59,"lng": 69},"balance": {"amount": 99,"unit": "USD","cards": [{"id": "88005553535","type": "urmum"}]}},"327": {"phone": "327","token": "urmum","location": {"lat": 19,"lng": 19},"balance": {"amount": 10,"unit": "EUR","cards": [{"id": "297800255","type": "maestro"}]}}}';

    var response = await Future.delayed(const Duration(seconds: 1), () => mock);

    final user = json.decode(response)[phone];

    return UserModel.fromJson(user);
  }
}
