import 'package:open_scooter_ui/feature/domain/entities/scooter_entity.dart';

import 'cost_model.dart';
import 'location_model.dart';

class ScooterModel extends ScooterEntity {
  ScooterModel(
      {required id, required location, required chargeLevel, required cost})
      : super(id: id, location: location, chargeLevel: chargeLevel, cost: cost);

  factory ScooterModel.fromJson(Map<String, dynamic> json) {
    return ScooterModel(
        id: json['id'],
        location: json['location'] != null
            ? LocationModel.fromJson(json['location'])
            : null,
        chargeLevel: json['chargeLevel'],
        cost: json['cost'] != null ? CostModel.fromJson(json['cost']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'location': this.location,
      'cost': this.cost,
      'chargeLevel': this.chargeLevel
    };
  }
}
