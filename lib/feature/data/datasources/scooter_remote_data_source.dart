import 'dart:convert';

import 'package:open_scooter_ui/feature/data/models/scooter_model.dart';
import 'package:http/http.dart' as http;

abstract class ScooterRemoteDataSource {
  Future<List<ScooterModel>> getAllScooters();
}

class ScooterRemoteDataSourceImpl implements ScooterRemoteDataSource {
  final http.Client client;

  ScooterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ScooterModel>> getAllScooters() async {
    const mock =
        '{"body":{"scooters":[{"id":1,"chargeLevel":55,"location":{"lat":53,"lng":27},"cost":{"unlock":2.0,"minute":0.35}}]}}';

    var response = await Future.delayed(const Duration(seconds: 1), () => mock);

    final scooters = json.decode(response)['body']['scooters'];

    print(scooters);

    final result = (scooters as List).map((scooter) {
      print(scooter);
      return ScooterModel.fromJson(scooter);
    }).toList();

    print(result);

    return result;
  }
}
