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
    var response = await new Future.delayed(
        const Duration(seconds: 1),
        () =>
            "{body: {scooters: [{id: 1, chargeLevel: 55, location: {lat: 53, lng: 27}, cost: {unlock: 2, minute: 0,35}}]}}, statusCode: 200");
    final scooters = json.decode(response)['body']['scooters'];

    return (scooters as List)
        .map((scooter) => ScooterModel.fromJson(scooter))
        .toList();
  }
}
